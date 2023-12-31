#!/usr/bin/env python3

"""
Model classes for latplan.
"""

import json
import numpy as np
from keras.layers import *
from keras.losses import mean_absolute_error

from keras.backend import slice
from keras.layers.normalization import BatchNormalization as BN
from keras.models import Model
from keras.optimizers import Adam
import keras.backend.tensorflow_backend as K
from keras.callbacks import LambdaCallback, LearningRateScheduler, Callback, CallbackList, ReduceLROnPlateau
import tensorflow as tf
from .util.noise import gaussian
from .util.distances import *
from .util.layers    import *
from .util.perminv   import *
from .util.tuning    import InvalidHyperparameterError
from .util.plot      import plot_grid, squarify
from .util           import ensure_list, NpEncoder, curry
from .util.stacktrace import print_object
from .mixins.latent          import *
from .mixins.encoder_decoder import *
from .mixins.locality        import *
from .mixins.output          import *
from .network                import Network


from keras.layers import Conv2D, MaxPooling2D, Conv2DTranspose

# Style guide
# * Each section is divided by 3 newlines
# * Each class is separated by 2 newline (so that hideshow will separate them by 1 newline when folded)

# utilities ####################################################################

def get(name):
    return globals()[name]

def get_ae_type(directory):
    import os.path
    with open(os.path.join(directory,"aux.json"),"r") as f:
        return json.load(f)["class"]

def load(directory,allow_failure=False):
    print("washere1")
    if allow_failure:
        try:
            classobj = get(get_ae_type(directory))
        except FileNotFoundError as c:
            print("Error skipped:", c)
            return None
    else:
        classobj = get(get_ae_type(directory))
    return classobj(directory).load(allow_failure=allow_failure)



# Network mixins ###############################################################

class AE(Network):
    """Autoencoder class. Supports SAVE and LOAD, as well as REPORT methods.
Additionally, provides ENCODE / DECODE / AUTOENCODE / AUTODECODE methods.
The latter two are used for verifying the performance of the AE.
"""
    def report(self,train_data,
               test_data=None,
               train_data_to=None,
               test_data_to=None,
               batch_size=400,
               **kwargs):
        test_data     = train_data if test_data is None else test_data
        train_data_to = train_data if train_data_to is None else train_data_to
        test_data_to  = test_data  if test_data_to is None else test_data_to
        opts = {"verbose":0,"batch_size":batch_size}

        performance = {}

        optimizer  = self.parameters["optimizer"]
        lr         = self.parameters["lr"]
        clipnorm   = self.parameters["clipnorm"]
        def make_optimizer(net):
            return getattr(keras.optimizers,optimizer)(
                lr,
                clipnorm=clipnorm
                # clipvalue=clipvalue,
            )

        self.optimizers = list(map(make_optimizer, self.nets))
        self.compile(self.optimizers)

        def reg(query, data, d={}):
            if len(query) == 1:
                d[query[0]] = data
                return d
            if query[0] not in d:
                d[query[0]] = {}
            reg(query[1:],data,d[query[0]])
            return d

        def test_both(query, fn, is_ztruc=False, need_gaussian=False):

            # train_data and test_data

            final_train_data = train_data


            #if not is_autoencoder:

            images_array_train_data = []
            for d in train_data:
                images_array_train_data.append(d[0])
            images_array_train_data = np.array(images_array_train_data)
            final_train_data=images_array_train_data
            actions_array_train_data = []
            for d in train_data:
                actions_array_train_data.append(d[1])
            actions_array_train_data = np.array(actions_array_train_data)
            
            print("len train_data")
            print(len(train_data[0]))
            print(type(train_data))
            #print(train_data)
            print("lassst")
            if need_gaussian:
                images_array_train_data = gaussian(images_array_train_data)
        
            if is_ztruc:
                final_train_data = [images_array_train_data, actions_array_train_data]

            result = fn(final_train_data)
            reg(query+["train"], result, performance)
            print(*query,"train", result)


            if test_data is not None:

                print("len test_data")

                print(len(test_data[0]))
                print(type(test_data))
                final_test_data=test_data

                #if not is_autoencoder:
                images_array_test_data = []
                for d in test_data:
                    images_array_test_data.append(d[0])
                images_array_test_data = np.array(images_array_test_data)
                final_test_data=images_array_test_data
                actions_array_test_data = []
                for d in test_data:
                    actions_array_test_data.append(d[1])
                actions_array_test_data = np.array(actions_array_test_data)
                    
                if need_gaussian:
                    images_array_test_data = gaussian(images_array_test_data)

                if is_ztruc:
                    final_test_data = [images_array_test_data, actions_array_test_data]

                result = fn(final_test_data)
                reg(query+["test"], result, performance)
                print(*query,"test", result)

        self._report(test_both,**opts)

        with open(self.local("performance.json"), "w") as f:
            json.dump(performance, f, cls=NpEncoder, indent=2)

        with open(self.local("parameter_count.json"), "w") as f:
            json.dump(count_params(self.autoencoder), f, cls=NpEncoder, indent=2)

        return self

    def encode(self,data,**kwargs):
        self.load()
        return self.encoder.predict(data,**kwargs)

    def decode(self,data,**kwargs):
        self.load()
        return self.decoder.predict(data,**kwargs)

    def autoencode(self,data,**kwargs):
        self.load()
        return self.autoencoder.predict(data,**kwargs)

    def autodecode(self,data,**kwargs):
        self.load()
        return self.autodecoder.predict(data,**kwargs)

    def summary(self,verbose=False):
        if verbose:
            self.encoder.summary()
            self.decoder.summary()
        self.autoencoder.summary()
        return self

    def build_gs(self,N=None,M=None,
                 **kwargs):
        # python methods cannot use self in the
        # default values, because python sucks
        assert (N is not None) or (M is not None)
        def fn(max_temperature = self.parameters["max_temperature"],
               min_temperature = self.parameters["min_temperature"],
               annealing_start = self.parameters["gs_annealing_start"],
               annealing_end   = self.parameters["gs_annealing_end"],
               train_noise     = self.parameters["train_noise"],
               train_hard      = self.parameters["train_hard"],
               test_noise      = self.parameters["test_noise"],
               test_hard       = self.parameters["test_hard"]):
            gs = GumbelSoftmax(
                N,M,min_temperature,max_temperature,
                annealing_start,
                annealing_end,
                train_noise = train_noise,
                train_hard  = train_hard,
                test_noise  = test_noise,
                test_hard   = test_hard)
            self.callbacks.append(LambdaCallback(on_epoch_end=gs.update))
            self.add_metric("tau",gs.variable)
            return gs

        return fn(**kwargs)

    def build_bc(self,
                 **kwargs):
        # python methods cannot use self in the
        # default values, because python sucks
        def fn(max_temperature = self.parameters["max_temperature"],
               min_temperature = self.parameters["min_temperature"],
               annealing_start = self.parameters["gs_annealing_start"],
               annealing_end   = self.parameters["gs_annealing_end"],
               train_noise     = self.parameters["train_noise"],
               train_hard      = self.parameters["train_hard"],
               test_noise      = self.parameters["test_noise"],
               test_hard       = self.parameters["test_hard"]):
            bc = BinaryConcrete(
                min_temperature,max_temperature,
                annealing_start,
                annealing_end,
                train_noise = train_noise,
                train_hard  = train_hard,
                test_noise  = test_noise,
                test_hard   = test_hard)
            self.callbacks.append(LambdaCallback(on_epoch_end=bc.update))
            return bc

        return fn(**kwargs)



# Mixins #######################################################################

class ZeroSuppressMixin:
    def _build_around(self,input_shape):
        print("_build_around0")
        print(input_shape)
        super()._build_around(input_shape)

        alpha = StepSchedule(schedule={
            0:0,
            (self.parameters["epoch"]*self.parameters["zerosuppress_delay"]):self.parameters["zerosuppress"],
        }, name="zerosuppress")
        self.callbacks.append(LambdaCallback(on_epoch_end=alpha.update))

        zerosuppress_loss = K.mean(self.encoder.output)

        self.net.add_loss(K.in_train_phase(zerosuppress_loss * alpha.variable, 0.0))

        def activation(x, y):
            return zerosuppress_loss

        # def zerosuppres(x, y):
        #     return alpha.variable

        self.metrics.append(activation)
        # self.metrics.append(zerosuppress)
        return


class EarlyStopMixin:
    def _build_around(self,input_shape):
        print("_build_around1")
        print(input_shape)
        super()._build_around(input_shape)

        # check all hyperparameters and ensure that the earlystop does not activate until all
        # delayed loss epoch kicks in
        max_delay = 0.0
        for key in self.parameters:
            if "delay" in key:
                max_delay = max(max_delay, self.parameters[key])
        earlystop_delay = max_delay + 0.1

        # self.callbacks.append(
        #     ChangeEarlyStopping(
        #         epoch_start=self.parameters["epoch"]*earlystop_delay,
        #         verbose=1,))

        # self.callbacks.append(
        #     LinearEarlyStopping(
        #         self.parameters["epoch"],
        #         epoch_start = self.parameters["epoch"]*earlystop_delay,
        #         target_value = self.parameters["current_best"],
        #         verbose     = 1,))

        # self.callbacks.append(
        #     ExplosionEarlyStopping(
        #         self.parameters["epoch"],
        #         epoch_start=10,
        #         verbose     = 1,))

        pass



# State Auto Encoder ###########################################################

# AAAI18 paper
class StateAE(ConcreteLatentMixin, EarlyStopMixin, FullConnectedMixin, AE):
    """An AE whose latent layer is BinaryConcrete.
Fully connected layers only, no convolutions.
Note: references to self.parameters[key] are all hyperparameters."""
    def _build_primary(self,input_shape):
        self.loss = self.output.loss

        x = Input(shape=input_shape, name="autoencoder")
        z = self._encode(x)
        y = self._decode(z)

        self.encoder     = Model(x, z)
        self.autoencoder = Model(x, y)
        self.net = self.autoencoder

    def _build_aux_primary(self,input_shape):
        # to be called after the training
        z2 = Input(shape=self.zdim(), name="autodecoder")
        y2 = self._decode(z2)
        w2 = self._encode(y2)
        self.decoder     = Model(z2, y2)
        self.autodecoder = Model(z2, w2)

    def render(self,x):
        return self.output.render(x)

    def plot(self,x,path,verbose=False,epoch=None):
        self.load()
        print("inplot")
        print(x.shape)
        print(x[0].shape)
        print(x[0])
        #exit()
        z = self.encode(x)
        print("ZZZZBEFORE")
        print(z.shape)
        print(z)
        where0 = np.where(z[0] == 1.)
        where1 = np.where(z[1] == 1.)
        where2 = np.where(z[2] == 1.)
        where3 = np.where(z[3] == 1.)
        print(where0)
        print(where1)
        print(where2)
        print(where3)

        inter = np.intersect1d(where0[0], where1[0])
        print("inter0")
        print(inter)

        inter = np.intersect1d(inter, where2[0])
        print("inter1")
        print(inter)

        inter = np.intersect1d(inter, where3[0])
        print("inter3")
        print(inter)
    


        y = self.autoencode(x)

        xg = gaussian(x)

        z_noise = self.encode(xg)

        yg = self.autoencode(xg)

        x = self.render(x)
        y = self.render(y)
        xg = self.render(xg)
        yg = self.render(yg)

        dy  = ( y-x+1)/2
        dyg = (yg-x+1)/2

        _z = squarify(z)

        _z_noise = squarify(z_noise)
        print("ZZZZAFTER")
        print(_z.shape) # (4, 18, 18)
        print(_z)

        #self._plot(path, (x, _z, y, dy, xg, yg, dyg),epoch=epoch)
        self._plot(path, (x, _z, y, dy, xg, _z_noise, yg, dyg),epoch=epoch)
        #xg = x
        #self._plot(path, (x, z),epoch=epoch)

        return x,z,y

    def plot_cycle(self,x1,path,cycles=3,verbose=False,epoch=None):
        self.load()
        B, *_ = x1.shape

        def diff(src,dst):
            return (dst - src + 1)/2

        rx1 = self.render(x1)
        rz1 = squarify(self.encode(x1).reshape((B,-1)))
        print("rx1.min()",rx1.min(),"rx1.max()",rx1.max())
        print("rz1.min()",rz1.min(),"rz1.max()",rz1.max())

        results_x = [rx1]
        results_z = [rz1]
        results_dx = []
        results_dz = []

        for i in range(cycles):
            x2  = self.autoencode(x1)
            rx2 = self.render(x2)
            rz2 = squarify(self.encode(x2).reshape((B,-1)))
            print("rx2.min()",rx2.min(),"rx2.max()",rx2.max())
            print("rz2.min()",rz2.min(),"rz2.max()",rz2.max())
            results_x.append(rx2)
            results_z.append(rz2)
            results_dx.append(diff(rx1,rx2))
            results_dz.append(diff(rz1,rz2))
            x1 = x2
            rx1 = rx2
            rz1 = rz2

        import os.path
        name, ext = os.path.splitext(path)
        self._plot(name+"_x"+ext, results_x, epoch=epoch)
        self._plot(name+"_z"+ext, results_z, epoch=epoch)
        self._plot(name+"_dx"+ext, results_dx, epoch=epoch)
        self._plot(name+"_dz"+ext, results_dz, epoch=epoch)
        return

    def plot_plan(self,z,path,verbose=False):
        "Plot a sequence of states horizontally."
        self.load()
        y = self.decode(z)
        y = self.render(y)
        y = [ r for r in y ]
        plot_grid(y, w=8, path=path, verbose=True)
        return


    def dump_actions(self,*args,**kwargs):
        """Is here so that SAE and TAE has the consistent interface"""
        pass


    def _report(self,test_both,**opts):

        print("jjjjjjjjjjjjjjj")

        from .util.np_distances import mse, mae

        def metrics(data):


            # images_array = []
            # for d in data:
            #     images_array.append(d[0])
            # images_array = np.array(images_array)

            # actions_array = []
            # for d in data:
            #     actions_array.append(d[1])
            # actions_array = np.array(actions_array)




            # return { k:v for k,v in zip(self.net.metrics_names,
            #                             ensure_list(self.net.evaluate([images_array, actions_array], images_array, **opts)))}        

            print("selfNET")
            print(self.net) # <keras.engine.training.Model object at 0x7f3382bafd30>


            return { k:v for k,v in zip(self.net.metrics_names,
                                        ensure_list(self.net.evaluate(data, data[0], **opts)))}
           
            # return { k:v for k,v in zip(self.net.metrics_names,
            #                             ensure_list(self.net.evaluate([data, np.tile(np.arange(24), (len(data), 1))], data, **opts)))}

            # return { k:v for k,v in zip(self.net.metrics_names,
            #                             ensure_list(self.net.evaluate(data, data, **opts)))}



        test_both(["metrics"], metrics, True)

        # evaluate the current state reconstruction loss.
        # This is using self.autoencoder rather than self.net, therefore the second reconstruction is through the SAE, not AAE
        #test_both(["sae","mse","vanilla"],  lambda data: mse(data, self.autoencoder.predict(data,  **opts)))
        test_both(["sae","mse","vanilla"],  lambda data: mse(data, self.autoencoder.predict(data, **opts)), False)
        # 
        test_both(["sae","mse","gaussian"], lambda data: mse(data, self.autoencoder.predict(gaussian(data),**opts)), False)
        #test_both(["sae","mse","gaussian"], lambda data: mse(images_array, self.autoencoder.predict(gaussian(images_array),**opts)))

        test_both(["sae","activation"], lambda data: float(self.encode(data,**opts).mean()), False)
        #test_both(["sae","activation"], lambda data: float(self.encode(images_array,**opts).mean()))

        # UGLY! The following functions are added because this code path should handle both the single-state case
        # and the double-state (transition) case.
        def batch_amax_mod(z):
            # this is latent space vectors, so it is either [batch,2,N] or [batch,N]
            if z.ndim == 2:
                return np.amax(z,axis=0)
            # the input is a latent transition (z0, z1)
            if z.ndim == 3:
                return np.amax(z,axis=(0,1))
            assert False
        def batch_amin_mod(z):
            # this is latent space vectors, so it is either [batch,2,N] or [batch,N]
            if z.ndim == 2:
                return np.amin(z,axis=0)
            # the input is a latent transition (z0, z1)
            if z.ndim == 3:
                return np.amin(z,axis=(0,1))
            assert False

        test_both(["sae","ever_1"],     lambda data: float(np.sum(batch_amax_mod(self.encode(data,**opts)))))
        test_both(["sae","ever_0"],     lambda data: float(np.sum(1-batch_amin_mod(self.encode(data,**opts)))))
        test_both(["sae","effective"],  lambda data: float(np.sum((1-batch_amin_mod(self.encode(data,**opts)))*batch_amax_mod(self.encode(data,**opts)))))

        def latent_variance_noise(data,noise):
            encoded = [self.encode(noise(data),**opts).round() for i in range(10)]
            var = np.var(encoded,axis=0)
            return {
                "max":float(np.amax(var)),
                "min":float(np.amin(var)),
                "mean":float(np.mean(var)),
                "median":float(np.median(var)),
            }

        test_both(["sae","variance","gaussian"], lambda data: latent_variance_noise(data,gaussian))

        def cycle_consistency(data):
            x0 = data
            z0 = self.encoder.predict(x0,**opts)
            x1 = x0
            z1 = z0
            xs01 = []            # does x move away from the initial x?
            xs12 = []            # does x converge?
            zs01 = []            # does z move away from the initial z?
            zs12 = []            # does z converge?
            for i in range(10):
                xs01.append(mse(x0,x1))
                zs01.append(mae(z0,z1))
                x2 = self.decoder.predict(z1,**opts)
                z2 = self.encoder.predict(x2,**opts)
                xs12.append(mse(x1,x2))
                zs12.append(mae(z1,z2))
                z1 = z2
                x1 = x2

            # noisy input
            x3 = gaussian(x0)
            z3 = self.encoder.predict(x3,**opts)
            xs13 = []           # does x with noise converge to the same value (x1)?
            xs34 = []           # does x converge?
            zs13 = []
            zs34 = []
            for i in range(10):
                xs13.append(mse(x1,x3))
                zs13.append(mae(z1,z3))
                x4 = self.decoder.predict(z3,**opts)
                z4 = self.encoder.predict(x4,**opts)
                xs34.append(mse(x3,x4))
                zs34.append(mae(z3,z4))
                z3 = z4
                x3 = x4

            return {"xs01":xs01,
                    "xs12":xs12,
                    "xs13":xs13,
                    "xs34":xs34,
                    "zs01":zs01,
                    "zs12":zs12,
                    "zs13":zs13,
                    "zs34":zs34}

        test_both(["cycle_consistency"], cycle_consistency)

        return



# Transition Auto Encoder ######################################################

# Warning!!! Action and effect mapping mixins are used before TransitionWrapper in the precedence list.
# TransitionWrapper removes the first element (which should be 2) in the input_shape.
# If your forgot this and use e.g. input_shape[0] trying to obtain the size of the first dimension of the state,
# you are screwed! You instead get 2.

class TransitionWrapper:
    """A wrapper over SAEs which makes it able to handle 2 states at once. This does not imply it learns an action."""
    def double_mode(self):
        pass
    def single_mode(self):
        pass
    def mode(self, single):
        pass

    def adaptively(self, fn, data, *args, **kwargs):
        try:
            return fn(data,*args,**kwargs)
        except ValueError:
            # not transitions
            return fn(np.expand_dims(data,1).repeat(2, axis=1),*args,**kwargs)[:,0]

    def encode(self, data, *args, **kwargs):
        print("daata")
        print(len(data))
        print(type(data))
        print(data[0].shape)

        # 2
        # <class 'list'>
        # (5000, 2, 48, 48, 1)

        # il faut

        # 5000
        # <class 'numpy.ndarray'>
        # (2, 48, 48, 1)

        
        return self.adaptively(super().encode, data, *args, **kwargs)
        
    def decode(self, data, *args, **kwargs):
        return self.adaptively(super().decode, data, *args, **kwargs)
    def autoencode(self, data, *args, **kwargs):
        return self.adaptively(super().autoencode, data, *args, **kwargs)
    def autodecode(self, data, *args, **kwargs):
        return self.adaptively(super().autodecode, data, *args, **kwargs)


    def _build_around(self,input_shape):
        print("_build_around2")
        print(input_shape)
        super()._build_around(input_shape[1:])

    def _build_aux_around(self,input_shape):
        super()._build_aux_around(input_shape[1:])

    def _build_primary(self,input_shape):
        # [batch, 2, ...] -> [batch, ...]

        x       = Input(shape=(2,*input_shape))
        _, x_pre, x_suc = dapply(x)
        z, z_pre, z_suc = dapply(x, self._encode)
        y, y_pre, y_suc = dapply(z, self._decode)

        self.encoder     = Model(x, z)
        self.autoencoder = Model(x, y)

        state_loss_fn = self.output.loss

        def loss(x,y):
            return state_loss_fn(x_pre, y_pre) + state_loss_fn(x_suc, y_suc)
        self.loss = loss

        self.net = self.autoencoder

        self.double_mode()
        return

    def _build_aux_primary(self,input_shape):

        z2       = Input(shape=(2,*self.zdim()), name="double_input_decoder")
        y2, _, _ = dapply(z2, self._decode)
        w2, _, _ = dapply(y2, self._encode)

        self.decoder     = Model(z2, y2)
        self.autodecoder = Model(z2, w2)
        return

    # def dump_actions(self,transitions,**kwargs):
    #     """Since TransitionWrapper may not have action discovery (AAE), it just saves a set of concatenated transitions"""
        
    #     transitions_z = self.encode(transitions,**kwargs)
    #     pre = transitions_z[:,0,...]
    #     suc = transitions_z[:,1,...]
    #     data = np.concatenate([pre,suc],axis=1)
    #     self.save_array("actions.csv", data)
    #     return

    def dump_actions(self,transitions,**kwargs):
        print("doit passer là")
        transitions_z = self.encode(transitions[0],**kwargs)
        pre = transitions_z[:,0,...]
        suc = transitions_z[:,1,...]
        pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(pre,suc,**kwargs)
        self.save_array("available_actions.csv", action_ids)
        self.dump_effects      (pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)
        self.dump_preconditions(pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)


class BaseActionMixin:
    """An abstract mixin for learning action labels/symbols. This may or may not have interpretable effect learning."""
    def encode_action(self,data,**kwargs):
        print("ici")
        print(len(data))
        print(data[0].shape)
        print(data[1].shape)
        return  data[1]
        #return self.action.predict(data,**kwargs)
    def apply(self,data,**kwargs):
        return self.applier.predict(data,**kwargs)
    def regress(self,data,**kwargs):
        return self.regressor.predict(data,**kwargs)

    def build_action_fc_unit(self):
        return Sequential([
            Dense(self.parameters["aae_width"], activation=self.parameters["aae_activation"], use_bias=False),
            BN(),
            Dropout(self.parameters["dropout"]),
        ])

    def apply_direct_loss(self,true,pred):
        if true is None:
            return pred
        dummy = Lambda(lambda x: x)
        loss  = K.mean(eval(self.parameters["direct_loss"])(true, pred))
        loss1 = K.mean(SymmetricBCE(true, pred)) * self.parameters["direct_eval"]
        # direct loss should be treated as the real loss
        dummy.add_loss(K.in_train_phase(loss * self.direct_alpha.variable, loss1))
        def direct(x,y):
            return loss1
        self.metrics.append(direct)
        return dummy(pred)

#     def _dump_actions_prologue(self,pre,suc,**kwargs):
#         """Compute and return a matrix, whose each row is a one-hot vector.
# It contans only as many rows as the available actions. Unused actions are removed."""
#         N=pre.shape[1]
#         data = np.concatenate([pre,suc],axis=1)
#         actions = self.encode_action([pre,suc], **kwargs).round()

#         histogram = np.squeeze(actions.sum(axis=0,dtype=int))
#         print(histogram)
#         true_num_actions = np.count_nonzero(histogram)
#         print(true_num_actions)
#         all_labels = np.zeros((true_num_actions, actions.shape[1], actions.shape[2]), dtype=int)
#         action_ids = np.where(histogram > 0)[0]
#         for i, a in enumerate(action_ids):
#             all_labels[i][0][a] = 1

#         return pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids



    def count_patterns(self, binary_matrix):
        from collections import Counter
        # Convert each binary vector to a string
        patterns = [''.join(map(str, row)) for row in binary_matrix]
        
        # Count the patterns
        pattern_counts = Counter(patterns)
        
        return pattern_counts



    def _dump_actions_prologue(self, actions, pre,suc,**kwargs):
        """Compute and return a matrix, whose each row is a one-hot vector.
It contans only as many rows as the available actions. Unused actions are removed."""
        print(pre.shape)
        
        N=pre.shape[1]
        data = np.concatenate([pre,suc],axis=1)
        #actions = self.encode_action([pre,suc], **kwargs).round()
        print("actionsactions")
        print(actions.shape)

        actions = np.expand_dims(actions, axis=1)
        print("actionsactions22222")
        print(actions.shape)
        print(actions)
        histogram = np.squeeze(actions.sum(axis=0,dtype=int))
        print(histogram)
        true_num_actions = np.count_nonzero(histogram)
        print(true_num_actions)
        all_labels = np.zeros((true_num_actions, actions.shape[1], actions.shape[2]), dtype=int)
        action_ids = np.where(histogram > 0)[0]
        true_num_actions = len(all_labels)
        for i, a in enumerate(action_ids):
            all_labels[i][0][a] = 1

        return pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids


        # #
        # actions_counter = self.count_patterns(actions)

        # print(actions_counter)
        # print(type(actions_counter))
        # print(len(actions_counter))
        # print(actions_counter.elements())

        # list_of_strings = list(actions_counter.keys())

        # print(list_of_strings)


        # # [[0,1,1,1,1,1], ....]
        # list_of_binary_actions = np.array([[[int(bit) for bit in string]] for string in list_of_strings])

        # print(list_of_binary_actions)

        # # (24, 1, 6)

        # squeezed_list_of_binary_actions = np.squeeze(list_of_binary_actions, axis=1)
        # print(squeezed_list_of_binary_actions[:5])

        # # Convert the binary vectors to decimal numbers
        # decimals = np.packbits(squeezed_list_of_binary_actions, axis=-1).astype(np.uint8)
        # corrected_decimals = decimals >> 2
        # print(corrected_decimals)
        



        # actions = np.expand_dims(actions, axis=1)

        # # 23 actions, un truc comme ça... pas terrible
        # true_num_actions = len(actions_counter)

        # histogram = np.squeeze(actions.sum(axis=0,dtype=int))
        # #print(histogram)
     

        # #true_num_actions = np.count_nonzero(histogram)
        
        # # all_labels doit avoir true_num_actions elements
        # all_labels = np.zeros((true_num_actions, actions.shape[1], 64), dtype=int)
    
        # # Create an identity matrix of size 64x64
        # identity = np.eye(64)
        # one_hot_encoded = identity[corrected_decimals.squeeze()]
        # # Reshape to (24, 1, 64)
        # all_labels = one_hot_encoded.reshape(24, 1, 64)


       
        # #all_labels = np.expand_dims(list_of_one_hot_repr, axis=1)

        # # #action_ids = np.where(histogram > 0)[0]
        # action_ids = np.arange(true_num_actions)
        # # #action_ids += 1

        # # for i, a in enumerate(action_ids):
        # #     all_labels[i][0][a] = 

        # # convertis ['011111', '010010', '001001', '010110', ...] en vecteur du type [
        # # (24, 1, 6)
        # #]

        # # bon, au final, all_labels c'est un vecteur avec du type (24, 1, 64)
        # # 

        # all_labels = list_of_binary_actions
        # print(all_labels)
        # print(" actions ids ")
        # print(action_ids)

        # return pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids



    def edim(self):
        "Returns the effect size. In a grounded representation, this is same as the size of the propositional state."
        return self.zdim()

    def dump_effects(self, pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids):
        pass
    def dump_preconditions(self, pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids):
        pass


    def dump_actions(self,transitions,**kwargs):
        print("doit passer là")
        transitions_z = self.encode(transitions[0],**kwargs)
        pre = transitions_z[:,0,...]
        suc = transitions_z[:,1,...]
        pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(transitions[1], pre,suc,**kwargs)
        self.save_array("available_actions.csv", action_ids)
        self.dump_effects      (pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)
        self.dump_preconditions(pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)
    pass



# action mapping variations
# Note: There were two more variations (see: old/precondition-networks.py), but now they do not make sense (JAIR)

class DetActionMixin:
    "Deterministic mapping from a state pair to an action"
    def _build_around(self, input_shape):
        self.action_encoder_net = [
            (Densify if self.parameters["densify"] else Sequential)
            ([self.build_action_fc_unit() for i in range(self.parameters["aae_depth"]-1)]),
            Sequential([
                Dense(self.parameters["A"]),
                self.build_gs(N=1,
                              M=self.parameters["A"],),
            ]),
        ]
        print("_build_around3")
        print(input_shape)
        super()._build_around(input_shape)

    def adim(self):
        return (1,self.parameters["A"])

    def _action(self,p_pre,p_suc):
        return Sequential(self.action_encoder_net)(concatenate([p_pre,p_suc],axis=-1))

    def _build_aux_around(self, input_shape):
        super()._build_aux_around(input_shape)
        z_pre = Input(shape=self.edim())
        z_suc = Input(shape=self.edim())
        #saction = self._action(z_pre, z_suc)
        #self.action = Model([z_pre, z_suc], action)

        return

    def _report(self,test_both,**opts):
        super()._report(test_both,**opts)

        def encode_and_split(data):
            print("in encode_and_split 1")
            z     = self.encode(data)
            pre, suc = z[:,0,...], z[:,1,...]
            return [pre, suc]

        def true_num_actions(data):
            actions = self.encode_action(encode_and_split(data), **opts).round()
            histogram = np.squeeze(actions.sum(axis=0,dtype=int))
            true_num_actions = np.count_nonzero(histogram)
            return true_num_actions

        test_both(["action","true_num_actions"], true_num_actions)

        return


# effect mapping variations

class EffectMixin:
    def _build_aux_around(self, input_shape):
        super()._build_aux_around(input_shape)

        z      = Input(shape=self.edim())
        action = Input(shape=self.adim())
        self.applier = Model([z,action], self._apply(z, action))

        return

    def dump_effects(self, pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs):

        # extract the effects.
        # there were less efficient version 2 and 3, which uses the transition dataset.
        # this version does not require iterating over hte dataset --- merely twice over all actions.
        add_effect = self.apply([np.zeros((true_num_actions, *self.edim())),all_labels], **kwargs)
        del_effect = 1-self.apply([np.ones((true_num_actions, *self.edim())),all_labels], **kwargs)
        self.save_array("action_add4.csv",add_effect)
        self.save_array("action_del4.csv",del_effect)
        self.save_array("action_add4+ids.csv",np.concatenate((add_effect,action_ids.reshape([-1,1])), axis=1))
        self.save_array("action_del4+ids.csv",np.concatenate((del_effect,action_ids.reshape([-1,1])), axis=1))

        return

    def _report(self,test_both,**opts):
        super()._report(test_both,**opts)

        from .util.np_distances import mse, mae

        # # note: This is using self.net assuming it will return y0 and y2. It should not be self.autoencoder, which returns y0 and y1.
        # #test_both(["x1y2","mse","vanilla"],  lambda data: mse(data[:,1,...], self.net.predict(data,          **opts)[:,1,...]))
        # test_both(["x1y2","mse","vanilla"],  lambda data: mse(data[:,1,...], self.net.predict([data, np.tile(np.arange(24),(len(data), 1))],          **opts)[:,1,...]))
        # #test_both(["x1y2","mse","gaussian"], lambda data: mse(data[:,1,...], self.net.predict(gaussian(data),**opts)[:,1,...]))
        # test_both(["x1y2","mse","gaussian"], lambda data: mse(data[:,1,...], self.net.predict([gaussian(data), np.tile(np.arange(24),(len(data), 1))],**opts)[:,1,...]))

        def encode_and_split(data):
            print("in encode_and_split 2")

            print("daata")
            print(type(data))
            print(type(data[0]))

            data_for_encode = data
            actions = None
            if isinstance(data, list):
                if(len(data) == 2):
                    data_for_encode = data[0]
            z     = self.encode(data_for_encode)

            z_pre, z_suc = z[:,0,...], z[:,1,...]
            actions=data[1]
            actions = np.expand_dims(actions, axis=1)
            #actions = self.encode_action([z_pre, z_suc], **opts).round()
            print("fffffffff")
            print(actions.shape) # (4500, 1, 24)
            print(z_pre.shape) # (4500, 300)

            
            z_suc_aae = self.apply([z_pre,actions], **opts)

            return z_pre, z_suc, z_suc_aae

        def z_mae(data):
            z_pre, z_suc, z_suc_aae = encode_and_split(data)
            return mae(z_suc, z_suc_aae)

        test_both(["z1z2","mae","vanilla"], z_mae, True)
        test_both(["z1z2","mae","gaussian"],z_mae, True, True)

        def z_match_prob(data):
            z_pre, z_suc, z_suc_aae = encode_and_split(data)
            z_match   = 1-np.abs(z_suc_aae-z_suc)
            return np.prod(np.mean(z_match,axis=0))

        test_both(["z1z2","match_prob","vanilla"], z_match_prob, True)
        test_both(["z1z2","match_prob","gaussian"],z_match_prob, True, True)

        def z_allmatch_prob(data):
            z_pre, z_suc, z_suc_aae = encode_and_split(data)
            z_match   = 1-np.abs(z_suc_aae-z_suc)
            return np.mean(np.prod(z_match,axis=1))

        test_both(["z1z2","allmatch_prob","vanilla"], z_allmatch_prob, True)
        #test_both(["z1z2","allmatch_prob","gaussian"],lambda data: z_allmatch_prob(gaussian(data)))
        test_both(["z1z2","allmatch_prob","gaussian"], z_allmatch_prob, True, True)

        def z_xor(data):
            print("onesla")
            print(type(data)) # list
            print(len(data)) # 2
            print(type(data[0])) # <class 'numpy.ndarray'>
            print(type(data[1])) # <class 'numpy.ndarray'>
            
            z     = self.encode(data[0])
            pre = z[:,0,...]
            suc = z[:,1,...]
            pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(data[1], pre,suc,**opts)

            # print("doit passer là")
            # transitions_z = self.encode(transitions[0],**kwargs)
            # pre = transitions_z[:,0,...]
            # suc = transitions_z[:,1,...]
            # pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(transitions[1], pre,suc,**kwargs)
        


            add_effect = self.apply([np.zeros((true_num_actions, *self.edim())),all_labels], **opts)
            del_effect = 1-self.apply([np.ones((true_num_actions, *self.edim())),all_labels], **opts)
            xor_effect = add_effect * del_effect # 1 when both add and del are 1
            # now this is [A, N] matrix.
            return np.mean(np.sum(xor_effect,axis=1))

        test_both(["z1z2","xor"], z_xor, True)

        def compiled_action(data):
            
            print("ééééééééé")
            print(type(data)) # <class 'numpy.ndarray'>

            print(len(data)) # 4500
            #print(data.shape) # (4500, 2, 48, 48, 1)

            z     = self.encode(data[0])
            pre = z[:,0,...]
            suc = z[:,1,...]
            pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(data[1], pre,suc,**opts)

            add_effect = self.apply([np.zeros((true_num_actions, *self.edim())),all_labels], **opts)
            del_effect = 1-self.apply([np.ones((true_num_actions, *self.edim())),all_labels], **opts)
            xor_effect = add_effect * del_effect # 1 when both add and del are 1
            # now this is [A, N] matrix.
            xor_number_per_action = np.sum(xor_effect,axis=1)
            compiled_actions_per_action = 2 ** xor_number_per_action
            total_compiled_action = np.sum(compiled_actions_per_action)
            return total_compiled_action

        test_both(["z1z2","compiled_action"], compiled_action, True)

        def kl_a_z(data):
            metrics = { k:v for k,v in zip(self.net.metrics_names,
                                           ensure_list(self.net.evaluate(data, data[0], **opts)))}
            # metrics = { k:v for k,v in zip(self.net.metrics_names,
            #                                ensure_list(self.net.evaluate([data, np.tile(np.arange(24), (len(data), 1))], data, **opts)))}

            # 
            return metrics["kl_a_z0"]

        test_both(["kl_a_z0"], kl_a_z, True)

        return

    pass


class ConditionalEffectMixin:
    """The effect depends on both the current state and the action labels -- Same as AAE in AAAI18.
It overwrites dump_actions because effects/preconditions must be learned separately."""
    def _build_primary(self,input_shape):
        self.action_decoder_net = [
            *[self.build_action_fc_unit() for i in range(self.parameters["aae_depth"]-1)],
            # this must be wrapped like this for ConditionalSequential
            Sequential([
                Dense(np.prod(self.edim())),
                self.build_bc(),
                Reshape(self.edim()),
            ])
        ]
        super()._build_primary(input_shape)

    def _apply(self,z_pre,action):
        print("this apply0")
        z_suc_aae = ConditionalSequential(self.action_decoder_net, z_pre, axis=1)(MyFlatten()(action))
        return z_suc_aae

    # def dump_actions(self,transitions,**kwargs):
    #     transitions_z = self.encode(transitions,**kwargs)
    #     pre = transitions_z[:,0,...]
    #     suc = transitions_z[:,1,...]

    #     pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(pre,suc,**kwargs)
    #     self.save_array("available_actions.csv", action_ids)

    #     A = self.parameters["A"]
    #     def to_id(actions):
    #         return (actions * np.arange(A)).sum(axis=-1,dtype=int)
    #     actions_byid = to_id(actions)
    #     data_byid = np.concatenate((data,actions_byid), axis=1)
    #     data_aae = np.concatenate([pre,self.apply([pre,actions], **kwargs)], axis=1)
    #     data_aae_byid = np.concatenate((data_aae,actions_byid), axis=1)
    #     self.save_array("actions.csv", data)
    #     self.save_array("actions+ids.csv", data_byid)
    #     self.save_array("actions_aae.csv", data_aae)
    #     self.save_array("actions_aae+ids.csv", data_aae_byid)
    #     self.save_array("actions_both.csv", np.concatenate([data,data_aae], axis=0))
    #     self.save_array("actions_both+ids.csv", np.concatenate([data_byid,data_aae_byid], axis=0))

    #     return

    def dump_actions(self,transitions,**kwargs):
        print("doit passer là")
        transitions_z = self.encode(transitions[0],**kwargs)
        pre = transitions_z[:,0,...]
        suc = transitions_z[:,1,...]
        pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(pre,suc,**kwargs)
        self.save_array("available_actions.csv", action_ids)
        self.dump_effects      (pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)
        self.dump_preconditions(pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs)

class CategoricalEffectMixin:
    def _build_primary(self,input_shape):
        print("eff 1")
        self.eff_decoder_net = [
            MyFlatten(),
            Dense(np.prod(self.edim())*3),
            Reshape((*self.edim(),3)),
            self.build_gs(),
            Reshape((*self.edim(),3)),
        ]
        super()._build_primary(input_shape)


class BoolMinMaxEffectMixin(CategoricalEffectMixin):
    "A naive effect learning method. Add/delete effects are directly modeled as binary min/max."
    def _apply(self,z_pre,action):
        print("this apply1")
        z_eff     = Sequential(self.eff_decoder_net)(action)
        z_add     = wrap(z_eff, z_eff[...,0])
        z_del     = wrap(z_eff, z_eff[...,1])
        z_suc_aae = wrap(z_pre, K.minimum(1-z_del, K.maximum(z_add, z_pre)))
        return z_suc_aae


class BoolSmoothMinMaxEffectMixin(CategoricalEffectMixin):
    "A naive effect learning method. Add/delete effects are directly modeled as binary smooth min/max."
    def _apply(self,z_pre,action):
        print("this apply2")
        z_eff     = Sequential(self.eff_decoder_net)(action)
        z_add     = wrap(z_eff, z_eff[...,0])
        z_del     = wrap(z_eff, z_eff[...,1])
        z_suc_aae = wrap(z_pre, smooth_min(1-z_del, smooth_max(z_add, z_pre)))
        return z_suc_aae



class LogitEffectMixin:
    def _build_primary(self,input_shape):
        print("eff 0")
        self.eff_decoder_net = [
            MyFlatten(),
            Dense(np.prod(self.edim()),use_bias=False,kernel_regularizer=self.parameters["eff_regularizer"]),
            # Dropout(0.2),
            #Dense(np.prod(300),use_bias=False,kernel_regularizer=self.parameters["eff_regularizer"]),
            # Dropout(0.2),
            # Dense(np.prod(self.edim()),use_bias=True,kernel_regularizer=self.parameters["eff_regularizer"]),
            *([BN()] if self.btl_eff_batchnorm else [])
        ]
        if self.btl_pre_batchnorm:
            self.scaling_pre = BN()
        else:
            self.scaling_pre = Lambda(lambda x: 2*x - 1) # same scale as the final batchnorm
        super()._build_primary(input_shape)

    def _apply(self,z_pre,action):
        print("this apply3")
        print(self.eff_decoder_net)
        l_eff     = Sequential(self.eff_decoder_net)(action)
        l_pre     = self.scaling_pre(z_pre)
        l_suc_aae = add([l_pre,l_eff])
        z_suc_aae = self.build_bc()(l_suc_aae)
        return z_suc_aae


class NormalizedLogitAddEffectMixin(LogitEffectMixin):
    "The effect depends only on the action labels. Add/delete effects are implicitly modeled by back2logit technique with batchnorm."
    btl_eff_batchnorm = True
    btl_pre_batchnorm = True
    pass


class LogitAddEffectMixin(LogitEffectMixin):
    "The effect depends only on the action labels. Add/delete effects are implicitly modeled by back2logit technique. Uses batchnorm in s_t, but not in effect (shifted from [0,1] to [-1/2,1/2].)"
    btl_eff_batchnorm = False
    btl_pre_batchnorm = True
    pass


class LogitAddEffect2Mixin(LogitEffectMixin):
    "The effect depends only on the action labels. Add/delete effects are implicitly modeled by back2logit technique. Uses batchnorm in effect, but not in s_t (shifted from [0,1] to [-1/2,1/2].)"
    btl_eff_batchnorm = True
    btl_pre_batchnorm = False
    pass



# precondition mapping variations

class AddHocPreconditionMixin:
    def dump_preconditions(self, pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs):
        A = self.parameters["A"]
        # extract the preconditions.
        # it is done by checking if a certain bit is always 0 or always 1.
        def to_id(actions):
            return (actions * np.arange(A)).sum(axis=-1,dtype=int)
        actions_byid = to_id(actions)
        pos = []
        neg = []
        for a in action_ids:
            pre_a = pre[np.where(actions_byid == a)[0]]
            pos_a =   pre_a.min(axis=0,keepdims=True) # [1,C]
            neg_a = 1-pre_a.max(axis=0,keepdims=True) # [1,C]
            pos.append(pos_a)
            neg.append(neg_a)
        pos = np.concatenate(pos,axis=0) # [A,C]
        neg = np.concatenate(neg,axis=0) # [A,C]
        self.save_array("action_pos4.csv",pos)
        self.save_array("action_neg4.csv",neg)
        self.save_array("action_pos4+ids.csv",np.concatenate((pos,action_ids.reshape([-1,1])), axis=1))
        self.save_array("action_neg4+ids.csv",np.concatenate((neg,action_ids.reshape([-1,1])), axis=1))
        return


class PreconditionMixin:
    def _build_aux_around(self, input_shape):
        super()._build_aux_around(input_shape)

        z      = Input(shape=self.edim())
        action = Input(shape=self.adim())
        self.regressor  = Model([z,action], self._regress(z, action))

        return

    def dump_preconditions(self, pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids, **kwargs):

        # extract the preconditions with deterministic regression.
        pos_precondition = self.regress([np.zeros((true_num_actions, *self.edim())),all_labels], **kwargs)
        neg_precondition = 1-self.regress([np.ones((true_num_actions, *self.edim())),all_labels], **kwargs)
        self.save_array("action_pos4.csv",pos_precondition)
        self.save_array("action_neg4.csv",neg_precondition)
        self.save_array("action_pos4+ids.csv",np.concatenate((pos_precondition,action_ids.reshape([-1,1])), axis=1))
        self.save_array("action_neg4+ids.csv",np.concatenate((neg_precondition,action_ids.reshape([-1,1])), axis=1))
        return

    def _report(self,test_both,**opts):
        super()._report(test_both,**opts)

        from .util.np_distances import mse, mae

        # note: This is using self.net assuming it will return y3 and y2. It should not be self.autoencoder, which returns y0 and y1.
        test_both(["x0y3","mse","vanilla"],  lambda data: mse(data[0][:,0,...], self.net.predict(data,**opts)[:,0,...]), True)
        test_both(["x0y3","mse","gaussian"], lambda data: mse(data[0][:,0,...], self.net.predict(data,**opts)[:,0,...]), True, True)


        def encode_and_split(data):
          

            data_for_encode = data
            actions = None
            if isinstance(data, list):
                if(len(data) == 2):
                    data_for_encode = data[0]
            z     = self.encode(data_for_encode)

            z_pre, z_suc = z[:,0,...], z[:,1,...]
            actions=data[1]
            actions = np.expand_dims(actions, axis=1)
          
            z_pre_aae = self.regress([z_suc,actions], **opts)

            return z_pre, z_suc, z_pre_aae





        def z_mae(data):
            z_pre, z_suc, z_pre_aae = encode_and_split(data)
            return mae(z_pre, z_pre_aae)

        test_both(["z0z3","mae","vanilla"], z_mae, True)
        test_both(["z0z3","mae","gaussian"],lambda data: z_mae(data), True, True)

        def z_match_prob(data):
            z_pre, z_suc, z_pre_aae = encode_and_split(data)
            z_match   = 1-np.abs(z_pre_aae-z_pre)
            return np.prod(np.mean(z_match,axis=0))

        test_both(["z0z3","match_prob","vanilla"], z_match_prob, True)
        test_both(["z0z3","match_prob","gaussian"], lambda data: z_match_prob(data), True, True)

        def z_allmatch_prob(data):
            z_pre, z_suc, z_pre_aae = encode_and_split(data)
            z_match   = 1-np.abs(z_pre_aae-z_pre)
            return np.mean(np.prod(z_match,axis=1))

        test_both(["z0z3","allmatch_prob","vanilla"], z_allmatch_prob, True)
        test_both(["z0z3","allmatch_prob","gaussian"], lambda data: z_allmatch_prob(data), True, True)

        def z_xor(data):
            z     = self.encode(data[0])
            pre = z[:,0,...]
            suc = z[:,1,...]
            pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(data[1], pre,suc,**opts)

            pos_precondition = self.regress([np.zeros((true_num_actions, *self.edim())),all_labels], **opts)
            neg_precondition = 1-self.regress([np.ones((true_num_actions, *self.edim())),all_labels], **opts)
            xor_precondition = pos_precondition * neg_precondition # 1 when both pos and neg are 1
            # now this is [A, N] matrix.
            return np.mean(np.sum(xor_precondition,axis=1))

        test_both(["z0z3","xor"], z_xor, True)

        def compiled_action(data):
            z     = self.encode(data[0])
            pre = z[:,0,...]
            suc = z[:,1,...]
            pre, suc, data, actions, histogram, true_num_actions, all_labels, action_ids = self._dump_actions_prologue(data[1], pre,suc,**opts)

            add_effect = self.apply([np.zeros((true_num_actions, *self.edim())),all_labels], **opts)
            del_effect = 1-self.apply([np.ones((true_num_actions, *self.edim())),all_labels], **opts)
            xor_effect = add_effect * del_effect # 1 when both add and del are 1
            pos_precondition = self.regress([np.zeros((true_num_actions, *self.edim())),all_labels], **opts)
            neg_precondition = 1-self.regress([np.ones((true_num_actions, *self.edim())),all_labels], **opts)
            xor_precondition = pos_precondition * neg_precondition # 1 when both pos and neg are 1
            # now this is [A, N] matrix.
            xor_bits = np.maximum(xor_effect, xor_precondition)
            xor_number_per_action = np.sum(xor_bits,axis=1)
            compiled_actions_per_action = 2 ** xor_number_per_action
            total_compiled_action = np.sum(compiled_actions_per_action)
            return total_compiled_action

        test_both(["z0z3","compiled_action"], compiled_action, True)

        return




class NormalizedLogitAddPreconditionMixin:
    def _build_primary(self,input_shape):
        self.pre_decoder_net = [
            MyFlatten(),
            Dense(np.prod(self.edim()),use_bias=False,kernel_regularizer=self.parameters["eff_regularizer"]),
            BN(),
        ]
        self.scaling_suc = BN()
        super()._build_primary(input_shape)

    def _regress(self,z_suc,action):
        l_eff     = Sequential(self.pre_decoder_net)(action)
        l_suc = self.scaling_suc(z_suc)
        l_pre_aae = add([l_suc,l_eff])
        z_pre_aae = self.build_bc()(l_pre_aae)
        return z_pre_aae



# effect + precondition variations

class NormalizedLogitAddBidirectionalMixin(NormalizedLogitAddPreconditionMixin, NormalizedLogitAddEffectMixin):
    pass


class UnidirectionalMixin(AddHocPreconditionMixin, EffectMixin):
    def plot_transitions(self,data,path,verbose=False,epoch=None):
        import os.path
        basename, ext = os.path.splitext(path)
        pre_path = basename+"_pre"+ext
        suc_path = basename+"_suc"+ext

        x = data
        z = self.encode(x)
        y = self.autoencode(x)

        x_pre, x_suc = x[:,0,...], x[:,1,...]
        z_pre, z_suc = z[:,0,...], z[:,1,...]
        y_pre, y_suc = y[:,0,...], y[:,1,...]
        action    = self.encode_action([z_pre,z_suc])
        z_suc_aae = self.apply([z_pre, action])
        y_suc_aae = self.decode(z_suc_aae)

        x_pre_r, x_suc_r = self.render(x_pre), self.render(x_suc)
        y_pre_r, y_suc_r = self.render(y_pre), self.render(y_suc)
        y_suc_aae_r = self.render(y_suc_aae)

        def diff(src,dst):
            return (dst - src + 1)/2


        self._plot(basename+"_transition_image"+ext,
                   [x_pre_r, x_suc_r,
                    y_pre_r, y_suc_r, y_suc_aae_r,],epoch=epoch)

        self._plot(basename+"_transition_image_diff"+ext,
                   [diff(x_pre_r,y_pre_r),
                    diff(x_suc_r,y_suc_r),
                    diff(x_suc_r,y_suc_aae_r),],epoch=epoch)

        self._plot(basename+"_transition_action"+ext,
                   [action,],epoch=epoch)

        self._plot(basename+"_transition_latent"+ext,
                   map(squarify,
                       [z_pre,     z_suc, z_suc_aae,]),epoch=epoch)

        self._plot(basename+"_transition_latent_diff"+ext,
                   map(squarify,
                       [diff(z_suc, z_suc_aae),]),epoch=epoch)

        self._plot(basename+"_transition_latent_eff"+ext,
                   map(squarify,
                       [diff(z_pre, z_suc),
                        diff(z_pre, z_suc_aae),]),epoch=epoch)

        p_b = self._encode_prob.predict(x)
        p_b_aae = self._encode_prob_aae.predict(x)
        p_b_pre, p_b_suc = p_b[:,0,...], p_b[:,1,...]
        _,       p_b_suc_aae = p_b_aae[:,0,...], p_b_aae[:,1,...]
        self._plot(basename+"_transition_prob"+ext,
                   map(squarify,
                       [p_b_pre,
                        p_b_suc,
                        p_b_suc_aae,]),epoch=epoch)
        self._plot(basename+"_transition_prob_diff"+ext,
                   map(squarify,
                       [diff(p_b_suc,p_b_suc_aae),]),epoch=epoch)
        return


class BidirectionalMixin(PreconditionMixin, EffectMixin):
    def plot_transitions(self,data,path,verbose=False,epoch=None):
        import os.path
        basename, ext = os.path.splitext(path)
        pre_path = basename+"_pre"+ext
        suc_path = basename+"_suc"+ext

        x = data
        z = self.encode(x)
        y = self.autoencode(x)

        x_pre, x_suc = x[:,0,...], x[:,1,...]
        z_pre, z_suc = z[:,0,...], z[:,1,...]
        y_pre, y_suc = y[:,0,...], y[:,1,...]
        action    = self.encode_action([z_pre,z_suc])
        z_pre_aae = self.regress([z_suc, action])
        y_pre_aae = self.decode(z_pre_aae)
        z_suc_aae = self.apply([z_pre, action])
        y_suc_aae = self.decode(z_suc_aae)

        def diff(src,dst):
            return (dst - src + 1)/2

        x_pre_r,     x_suc_r     = self.render(x_pre),     self.render(x_suc)
        y_pre_r,     y_suc_r     = self.render(y_pre),     self.render(y_suc)
        y_pre_aae_r, y_suc_aae_r = self.render(y_pre_aae), self.render(y_suc_aae)

        self._plot(basename+"_transition_image"+ext,
                   [x_pre_r, x_suc_r,
                    y_pre_r, y_suc_r,
                    y_pre_aae_r, y_suc_aae_r,],epoch=epoch)

        self._plot(basename+"_transition_image_diff"+ext,
                   [diff(x_pre_r,y_pre_r),
                    diff(x_suc_r,y_suc_r),
                    diff(x_pre_r,y_pre_aae_r),
                    diff(x_suc_r,y_suc_aae_r),],epoch=epoch)

        self._plot(basename+"_transition_action"+ext,
                   [action,],epoch=epoch)

        self._plot(basename+"_transition_latent"+ext,
                   map(squarify,
                       [z_pre,     z_suc,
                        z_pre_aae, z_suc_aae,]),epoch=epoch)

        self._plot(basename+"_transition_latent_diff"+ext,
                   map(squarify,
                       [diff(z_pre, z_pre_aae),
                        diff(z_suc, z_suc_aae),]),epoch=epoch)

        self._plot(basename+"_transition_latent_eff"+ext,
                   map(squarify,
                       [diff(z_pre, z_suc),
                        diff(z_pre, z_suc_aae),
                        diff(z_pre_aae, z_suc),]),epoch=epoch)

        p_b = self._encode_prob.predict(x)
        p_b_aae = self._encode_prob_aae.predict(x)
        p_b_pre, p_b_suc = p_b[:,0,...], p_b[:,1,...]
        p_b_pre_aae, p_b_suc_aae = p_b_aae[:,0,...], p_b_aae[:,1,...]
        self._plot(basename+"_transition_prob"+ext,
                   map(squarify,
                       [p_b_pre,
                        p_b_suc,
                        p_b_pre_aae,
                        p_b_suc_aae,]),epoch=epoch)
        self._plot(basename+"_transition_prob_diff"+ext,
                   map(squarify,
                       [diff(p_b_pre,p_b_pre_aae),
                        diff(p_b_suc,p_b_suc_aae),]),epoch=epoch)
        return



# AMA3 Space AE : Transition AE + Action AE double wielding! ###################

class BaseActionMixinAMA3(UnidirectionalMixin, BaseActionMixin):
    def _build_primary(self,input_shape):
        super()._build_primary(input_shape)

        x = self.net.input      # keras has a bug, we can"t make a new Input here
        _, x_pre, x_suc = dapply(x)
        z, z_pre, z_suc = dapply(self.encoder.output)
        y, y_pre, y_suc = dapply(self.autoencoder.output)

        action    = self._action(z_pre,z_suc)

        # set up direct loss (there are no other place it could be called)
        self.direct_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["direct_delay"]):self.parameters["direct"],}, name="direct")
        self.callbacks.append(LambdaCallback(on_epoch_end=self.direct_alpha.update))
        z_suc_aae = self._apply(z_pre,action)

        z_suc_aae = self.apply_direct_loss(z_suc,z_suc_aae)

        y_suc_aae = self._decode(z_suc_aae)

        state_loss_fn = self.output.loss

        rec_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["rec_delay"]):1,}, name="rec")
        aae_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["aae_delay"]):1,}, name="aae")
        self.callbacks.append(LambdaCallback(on_epoch_end=rec_alpha.update))
        self.callbacks.append(LambdaCallback(on_epoch_end=aae_alpha.update))

        def loss(dummy_x,dummy_y):
            return \
                rec_alpha.variable * state_loss_fn(x_pre, y_pre) + \
                rec_alpha.variable * state_loss_fn(x_suc, y_suc) + \
                aae_alpha.variable * state_loss_fn(x_suc, y_suc_aae)

        self.loss = loss
        self.net = Model(x, dmerge(y_pre, y_suc_aae))
        # note: adding the successor loss to self.net by add_loss and not defining a new net does not work
        # because Model.save only saves the weights that are included in the computation graph between input and output.
        self.encoder     = Model(x, z) # note : directly through the encoder, not AAE
        self.autoencoder = Model(x, y) # note : directly through the decoder, not AAE

        return

    pass


# AMA4  Space AE : Bidirectional model #########################################

class BaseActionMixinAMA4(BidirectionalMixin, BaseActionMixin):
    def _build_primary(self,input_shape):
        super()._build_primary(input_shape)

        x = self.net.input      # keras has a bug, we can"t make a new Input here
        _, x_pre, x_suc = dapply(x)
        z, z_pre, z_suc = dapply(self.encoder.output)
        y, y_pre, y_suc = dapply(self.autoencoder.output)

        action    = self._action(z_pre,z_suc)

        # set up direct loss (there are no other place it could be called)
        self.direct_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["direct_delay"]):self.parameters["direct"],}, name="direct")
        self.callbacks.append(LambdaCallback(on_epoch_end=self.direct_alpha.update))
        z_pre_aae = self._regress(z_suc,action)
        z_suc_aae = self._apply  (z_pre,action)

        z_pre_aae = self.apply_direct_loss(z_pre,z_pre_aae)
        z_suc_aae = self.apply_direct_loss(z_suc,z_suc_aae)

        y_pre_aae = self._decode(z_pre_aae)
        y_suc_aae = self._decode(z_suc_aae)

        state_loss_fn = self.output.loss

        rec_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["rec_delay"]):1,}, name="rec")
        aae_alpha = StepSchedule(schedule={0:0, (self.parameters["epoch"]*self.parameters["aae_delay"]):1,}, name="aae")
        self.callbacks.append(LambdaCallback(on_epoch_end=rec_alpha.update))
        self.callbacks.append(LambdaCallback(on_epoch_end=aae_alpha.update))

        def loss(dummy_x,dummy_y):
            return \
                rec_alpha.variable * state_loss_fn(x_pre, y_pre) + \
                rec_alpha.variable * state_loss_fn(x_suc, y_suc) + \
                aae_alpha.variable * state_loss_fn(x_pre, y_pre_aae) + \
                aae_alpha.variable * state_loss_fn(x_suc, y_suc_aae)

        self.loss = loss
        self.net = Model(x, dmerge(y_pre_aae, y_suc_aae))
        # note: adding the successor loss to self.net by add_loss and not defining a new net does not work
        # because Model.save only saves the weights that are included in the computation graph between input and output.
        self.encoder     = Model(x, z) # note : directly through the encoder, not AAE
        self.autoencoder = Model(x, y) # note : directly through the decoder, not AAE

        return

    pass


# AMA3+ Space AE : Space AE with correct ELBO ##################################

class BaseActionMixinAMA3Plus(UnidirectionalMixin, BaseActionMixin):
    def _save(self,path=""):
        # saved separately so that we can switch between loading or not loading it.
        # since the weights are fixed size, loading it with a different input shape causes an error.
        super()._save(path)
        print("saving additional networks")
        import os.path
        np.savez_compressed(self.local(os.path.join(path,f"p_a_z0_net.npz")),*self.p_a_z0_net[0].get_weights())

    def _load(self,path=""):
        # loaded separately so that we can switch between loading or not loading it.
        # since the weights are fixed size, loading it with a different input shape causes an error.
        # reload_with_shape does not call _load.
        super()._load(path)
        print("loading additional networks")
        import os.path
        try:
            print("onestla")
            print(self.local(os.path.join(path,f"p_a_z0_net.npz")))
            
            with np.load(self.local(os.path.join(path,f"p_a_z0_net.npz"))) as data:
                self.p_a_z0_net[0].set_weights([ data[key] for key in data.files ])
        except FileNotFoundError:
            print("failed to find weights for additional networks")

    def _build_around(self,input_shape):
        A  = self.parameters["A"]
        self.p_a_z0_net = [
            Dense(A),
            Reshape(self.adim()),
        ]
        def update_dynamics_training_flag(epoch, logs=None):
            if epoch == self.parameters["kl_cycle_start"]:
                print(f"epoch {epoch}: freezing the decoder")
                for layer in self.decoder_net:
                    layer.trainable = False
                # force compilation
                self._compile(self.optimizers)
        self.callbacks.append(LambdaCallback(on_epoch_begin = update_dynamics_training_flag))
        print("_build_around4")
        print(input_shape)
        super()._build_around(input_shape)

    def _build_primary(self,input_shape):

        x = Input(shape=(2,*input_shape))
        _, x_pre, x_suc = dapply(x)
        z, z_pre, z_suc = dapply(x, self._encode)
        y, y_pre, y_suc = dapply(z, self._decode)

        # to generate a correct ELBO, input to action should be deterministic
        (l_pre,     ), _ = z_pre.variational_source # see Variational class
        (l_suc,     ), _ = z_suc.variational_source # see Variational class
        p_pre = wrap(l_pre, K.sigmoid(l_pre))
        p_suc = wrap(l_suc, K.sigmoid(l_suc))
        # note: _action takes a probability, but feeding 0/1 data in test time is fine (0/1 can be seen as probabilities)
        action    = self._action(p_pre,p_suc)
        z_suc_aae = self._apply(z_pre,action)
        y_suc_aae = self._decode(z_suc_aae)
        z_aae = dmerge(z_pre, z_suc_aae)
        y_aae = dmerge(y_pre, y_suc_aae)

        (l_action,  ), _ = action.variational_source # see Variational class
        (l_suc_aae, ), _ = z_suc_aae.variational_source # see Variational class

        p         = dmerge(p_pre, p_suc)
        p_suc_aae = wrap(l_suc_aae, K.sigmoid(l_suc_aae))
        p_aae     = dmerge(p_pre, p_suc_aae)

        pdiff_z1z2 = K.mean(K.abs(p_suc - p_suc_aae),axis=-1)
        pdiff_z0z1 = K.mean(K.abs(p_pre - p_suc),axis=-1)
        pdiff_z0z2 = K.mean(K.abs(p_pre - p_suc_aae),axis=-1)

        kl_z0 = z_pre.loss(l_pre, p=self.parameters["zerosuppress"])
        kl_a_z0 = action.loss(l_action, logit_p=Sequential(self.p_a_z0_net)(z_pre))
        kl_z1z2 = z_suc_aae.loss(l_suc, logit_p=l_suc_aae)
        _rec = self.output.loss
        x0y0 = _rec(x_pre,y_pre)
        x1y1 = _rec(x_suc,y_suc)
        x1y2 = _rec(x_suc,y_suc_aae)
        ama3_forward_loss1  = self.parameters["beta_z"] * kl_z0 + x0y0 + kl_a_z0 + self.parameters["beta_d"] * kl_z1z2 + x1y1
        ama3_forward_loss2  = self.parameters["beta_z"] * kl_z0 + x0y0 + kl_a_z0 + x1y2
        total_loss = (ama3_forward_loss1 + ama3_forward_loss2)/2
        ama3_forward_elbo1  = kl_z0 + x0y0 + kl_a_z0 + kl_z1z2 + x1y1
        ama3_forward_elbo2  = kl_z0 + x0y0 + kl_a_z0 + x1y2
        elbo = (ama3_forward_elbo1 + ama3_forward_elbo2)/2
        self.add_metric("pdiff_z1z2",pdiff_z1z2)
        self.add_metric("pdiff_z0z1",pdiff_z0z1)
        self.add_metric("pdiff_z0z2",pdiff_z0z2)
        self.add_metric("kl_z0",kl_z0)
        self.add_metric("kl_a_z0",kl_a_z0)
        self.add_metric("kl_z1z2",kl_z1z2)
        self.add_metric("x0y0",x0y0)
        self.add_metric("x1y1",x1y1)
        self.add_metric("x1y2",x1y2)
        self.add_metric("elbo",elbo)
        def loss(*args):
            return total_loss
        self.loss = loss
        # note: original z does not work because Model.save only saves the weights that are included in the computation graph between input and output.
        self.net = Model(x, y_aae)
        self.encoder     = Model(x, z) # note : directly through the encoder, not AAE
        self.autoencoder = Model(x, y) # note : directly through the decoder, not AAE

        # verify the note above : self.autoencoder.weights does not contain weights for AAE
        # print(self.net.weights)
        # print(self.autoencoder.weights)

        # for plotting
        self._encode_prob     = Model(x, p) # note : directly through the encoder, not AAE
        self._encode_prob_aae = Model(x, p_aae) # note : directly through the encoder, not AAE

        return

    def evaluate(self,*args,**kwargs):
        print("evaluate3")
        metrics = { k:v for k,v in zip(self.net.metrics_names,
                                       ensure_list(self.net.evaluate(*args,**kwargs)))}
        return [metrics["elbo"],metrics["loss"],metrics["x0y0"]+metrics["x1y1"]/2+metrics["x1y2"]/2, metrics["kl_z1z2"], metrics["kl_z0"]]

    pass







# AMA4+ Space AE : Bidirectional model with correct ELBO #######################

class BaseActionMixinAMA4Plus(BidirectionalMixin, BaseActionMixin):
    def _save(self,path="", epoch=None):
        # saved separately so that we can switch between loading or not loading it.
        # since the weights are fixed size, loading it with a different input shape causes an error.
        super()._save(path, epoch=epoch)
        print("saving additional networks")
        import os.path
        np.savez_compressed(self.local(os.path.join(path,f"p_a_z0_net-{epoch}.npz")),*self.p_a_z0_net[0].get_weights())
        np.savez_compressed(self.local(os.path.join(path,f"p_a_z1_net-{epoch}.npz")),*self.p_a_z1_net[0].get_weights())

    def _load(self,path=""):
        # loaded separately so that we can switch between loading or not loading it.
        # since the weights are fixed size, loading it with a different input shape causes an error.
        # reload_with_shape does not call _load.
        super()._load(path)
        print("loading additional networks")
        import os.path
        try:
            print("onestla2")
            print("washere5")
            print(self.local(os.path.join(path,f"p_a_z0_net.npz")))
            with np.load(self.local(os.path.join(path,f"p_a_z0_net.npz"))) as data:
                
                self.p_a_z0_net[0].set_weights([ data[key] for key in data.files ])
            with np.load(self.local(os.path.join(path,f"p_a_z1_net.npz"))) as data:
                self.p_a_z1_net[0].set_weights([ data[key] for key in data.files ])
        except FileNotFoundError:
            print("failed to find weights for additional networks")

    def _build_around(self,input_shape):
        A  = self.parameters["A"]
        self.p_a_z0_net = [
            Dense(A),
            Reshape(self.adim()),
        ]
        self.p_a_z1_net = [
            Dense(A),
            Reshape(self.adim()),
        ]
        initial_weights = []
        def save_initial_weight(epoch, logs=None):
            for layer in self.encoder_net:
                initial_weights.append(layer.get_weights())
        def reset_initial_weight(epoch, logs=None):
            if epoch == self.parameters["kl_cycle_start"]:
                for layer,weights in zip(self.encoder_net,initial_weights):
                    layer.set_weights(weights)
        # self.callbacks.append(LambdaCallback(on_train_begin = save_initial_weight))
        # self.callbacks.append(LambdaCallback(on_epoch_begin = reset_initial_weight))
        def update_dynamics_training_flag(epoch, logs=None):
            if epoch == self.parameters["kl_cycle_start"]:
                print(f"epoch {epoch}: freezing the decoder")
                for layer in (*self.decoder_net,
                              *self.eff_decoder_net,
                              *self.pre_decoder_net):
                    layer.trainable = False
                # force compilation
                self._compile(self.optimizers)
        # self.callbacks.append(LambdaCallback(on_epoch_begin = update_dynamics_training_flag))
        print("_build_around5")
        print(input_shape)
        super()._build_around(input_shape)





    # loss between an existing action (logit_q ?) and 
    def SpecificLoss(self,logit_q,logit_p=None,p=None):
        # logit_q is the output of the GS (the action vector of size 6000 ?)
        q = K.softmax(logit_q)
        q = K.clip(q,1e-5,1-1e-5) # avoid nan in log
        q = q / K.sum(q,axis=-1,keepdims=True) # ensure sum is 1
        log_q = K.log(q)
        if (logit_p is None) and (p is None):
            # p = 1 / self.M
            # log_p = K.log(1/self.M)
            # loss = q * (log_q - log_p)
            # loss = K.sum(loss, axis=-1)
            # sum (q*logq - qlogp) = sum (q*logq) - sum (q*(-logM)) = sum qlogq + sum q logM = sum qlogq + 1*logM
            loss = K.sum(q * log_q, axis=-1) + K.log(K.cast(self.parameters["A"], "float"))
        elif logit_p is not None:
            s = K.shape(logit_p)
            logit_p = wrap(logit_p, K.reshape(logit_p, (s[0], 1, self.parameters["A"])))
            p = K.softmax(logit_p)
            p = K.clip(p,1e-5,1-1e-5) # avoid nan in log
            p = p / K.sum(p,axis=-1,keepdims=True) # ensure sum is 1
            log_p = K.log(p)
            loss = q * (log_q - log_p)
            loss = K.sum(loss, axis=-1)
        elif p is not None:
            p = K.clip(p,1e-5,1-1e-5) # avoid nan in log
            # p = p / K.sum(p,axis=-1,keepdims=True) # ensure sum is 1
            log_p = K.log(p)
            loss = q * (log_q - log_p)
            loss = K.sum(loss, axis=-1)
        else:
            raise Exception("what??")

        # sum across dimensions
        loss = K.batch_flatten(loss)
        loss = K.sum(loss, axis=-1)
        return loss



    # loss between an existing action (logit_q ?) and 
    def SpecificLoss(self,logit_q,logit_p=None,p=None):
        # logit_q is the output of the GS (the action vector of size 6000 ?)
        q = K.softmax(logit_q)
        q = K.clip(q,1e-5,1-1e-5) # avoid nan in log
        q = q / K.sum(q,axis=-1,keepdims=True) # ensure sum is 1
        log_q = K.log(q)
        if (logit_p is None) and (p is None):
            # p = 1 / self.M
            # log_p = K.log(1/self.M)
            # loss = q * (log_q - log_p)
            # loss = K.sum(loss, axis=-1)
            # sum (q*logq - qlogp) = sum (q*logq) - sum (q*(-logM)) = sum qlogq + sum q logM = sum qlogq + 1*logM
            loss = K.sum(q * log_q, axis=-1) + K.log(K.cast(self.parameters["A"], "float"))
        elif logit_p is not None:
            s = K.shape(logit_p)
            logit_p = wrap(logit_p, K.reshape(logit_p, (s[0], 1, self.parameters["A"])))
            p = K.softmax(logit_p)
            p = K.clip(p,1e-5,1-1e-5) # avoid nan in log
            p = p / K.sum(p,axis=-1,keepdims=True) # ensure sum is 1
            log_p = K.log(p)
            loss = q * (log_q - log_p)
            loss = K.sum(loss, axis=-1)
        elif p is not None:
            p = K.clip(p,1e-5,1-1e-5) # avoid nan in log
            # p = p / K.sum(p,axis=-1,keepdims=True) # ensure sum is 1
            log_p = K.log(p)
            loss = q * (log_q - log_p)
            loss = K.sum(loss, axis=-1)
        else:
            raise Exception("what??")

        # sum across dimensions
        loss = K.batch_flatten(loss)
        loss = K.sum(loss, axis=-1)
        return loss


    def mask_layers(self):

        return Sequential([
            Dense(32, activation='relu'),
            Dense(2304)
        ])

        # encoded = Dense(32, activation='relu')(concatenated)

        # decoded = Dense(2304)(encoded)

        # return decoded
        
        #
        # from a 48x48 image ===> to 2304 vector
        # + concatenate the 24 vector 

        # this GIVES the INPUT vector

        # then to a Dense of size 32 THEN another Dense of size 2304
        # THEN the loss you know what to do 





    def zero_out_regions(self, image_dataset, indices_min_x, indices_max_x, indices_min_y, indices_max_y):
        # Ensure the shape of the indices are as expected
        # indices_min_x = tf.cast(tf.reshape(indices_min_x, [-1]), tf.int32)
        # indices_max_x = tf.cast(tf.reshape(indices_max_x, [-1]), tf.int32)
        # indices_min_y = tf.cast(tf.reshape(indices_min_y, [-1]), tf.int32)
        # indices_max_y = tf.cast(tf.reshape(indices_max_y, [-1]), tf.int32)

        indices_min_x = tf.cast(indices_min_x, tf.int32)
        indices_max_x = tf.cast(indices_max_x, tf.int32)
        indices_min_y = tf.cast(indices_min_y, tf.int32)
        indices_max_y = tf.cast(indices_max_y, tf.int32)


        def zero_out_single_image(image, min_x, max_x, min_y, max_y):

            range_x = tf.range(48, dtype=tf.int32)
            range_y = tf.range(48, dtype=tf.int32)

            # Create a mask for the x and y ranges
            mask_x = tf.logical_and(range_x > min_x, range_x < max_x)
            mask_y = tf.logical_and(range_y > min_y, range_y < max_y)

            # Apply the mask to zero out the specified regions
            masked_image = tf.where(tf.logical_and(mask_x[:, None], mask_y), image, tf.ones_like(image))
            #masked_image = tf.where(tf.logical_and(mask_x, mask_y), image, tf.ones_like(image))

            return masked_image

        # Apply the operation to each image in the dataset
        zeroed_out_images = tf.map_fn(lambda x: zero_out_single_image(x[0], x[1], x[2], x[3], x[4]), 
                                    (image_dataset, indices_min_x, indices_max_x, indices_min_y, indices_max_y), 
                                    dtype=tf.float32)

        return zeroed_out_images

    # Example usage
    # image_dataset = ...  # Your image dataset tensor
    # indices_min_x = ...  # Your indices_min_x tensor
    # indices_max_x = ...  # Your indices_max_x tensor
    # indices_min_y = ...  # Your indices_min_y tensor
    # indices_max_y = ...  # Your indices_max_y tensor

    # zeroed_out_dataset = zero_out_regions(image_dataset, indices_min_x, indices_max_x, indices_min_y, indices_max_y)








    
    def plot_image(self,a,name):
        import matplotlib.pyplot as plt
        plt.figure(figsize=(6,6))
        plt.imshow(a,interpolation='nearest',cmap='gray',)
        plt.savefig(name)





    def _build_primary(self, input_shape):

        # print("input_shapeinput_shape")
        # print(input_shape) # (48, 48, 1)
        #input_shape = (5, 36, 3)

        x = Input(shape=(2,*input_shape)) # shape is (?, 2, 48, 48 )
        action_input = Input(shape=(self.parameters["A"],)) # shape is # (? ,24)

        masks = Input(shape=(48,48,))
        print("masks.shape ok")
        print(masks.shape)

        self.output_mask = action_input

        ####### "Modifying" the two images so that ONLY the part of INTEREST STAYS "clear"
        #######  (the rest is put to 0s)


        # ################## CALCULATING THE MASK BETWEEN PRE IMAGE and SUCC IMAGE ############
        first_images = Lambda(lambda x: x[:, 0, :, :], name = "Lambda_0")(x)
        first_image_reshaped = Reshape((48, 48))(first_images) # shape is (?, 48, 48)


        lambda_Multiply = Lambda(lambda inputs: inputs[0]*inputs[1])
        masked_ = lambda_Multiply([first_image_reshaped, masks])


        lambda_NOT = Lambda(lambda input: tf.logical_not(input))

        lambda_toBool = Lambda(lambda input: tf.cast(input, dtype=tf.bool))

        masks_bool = lambda_toBool(masks)

        negative_masks = lambda_NOT(masks_bool)

        lambda_toFloat32 = Lambda(lambda input: tf.cast(input, dtype=tf.float32))

        masked_negative = lambda_Multiply([first_image_reshaped, lambda_toFloat32(negative_masks)])

        #flattened_first_image = Reshape((2304,))(first_image_reshaped) # shape is (?, 2304)

        # #second_images = x[:, 1, :, :]
        # second_images = Lambda(lambda x: x[:, 1, :, :], name = "Lambda_1")(x)
        # second_images_reshaped = Reshape((48, 48))(second_images)
        # flattened_second_images = Reshape((2304,))(second_images_reshaped)

        # #elements_equal = tf.equal(flattened_second_images, flattened_first_image)

        # lambda_layer1 = Lambda(lambda inputs: tf.equal(inputs[1], inputs[0]))
        # elements_equal = lambda_layer1([flattened_first_image, flattened_second_images])


        # lambda_layer2 = Lambda(lambda input: tf.cast(tf.logical_not(input), tf.float32))
        # themask = lambda_layer2(elements_equal)

        # masked_image = Reshape((48, 48))(themask) # Will be 1s where difference, 0s otherwise

        # ################## CALCULATING THE xmin/xmax/ymin/ymax of the MASK ###############
        

        # ## VERSION: ANY actions per batch
        # print(masked_image.shape) # (?, 48, 48)
        # # xmin, xmax
        # lambda_reduceMaxAxis2 = Lambda(lambda input: tf.reduce_max(input, axis=2))
        # maxes_from_axis_one = lambda_reduceMaxAxis2(masked_image) #tf.reduce_max(masked_image, axis=2)
        # lambda_argxMaxAxis1 = Lambda(lambda input: tf.argmax(input, axis=1))
        # xmin = lambda_argxMaxAxis1(maxes_from_axis_one)
        # flipped_axis_one = tf.reverse(maxes_from_axis_one, axis=[1])
        # xmax = tf.math.subtract(48 , tf.cast(tf.argmax(flipped_axis_one, axis=1), dtype=tf.int32))

        # # # ymin, ymax
        # maxes_from_axis_zero = tf.reduce_max(masked_image, axis=1)
        # ymin = tf.argmax(maxes_from_axis_zero, axis=1)
        # flipped_axis_zero = tf.reverse(maxes_from_axis_zero, axis=[1])
        # ymax = tf.math.subtract(48 , tf.cast(tf.argmax(flipped_axis_zero, axis=1), dtype=tf.int32))

        # lambda_castInt32 = Lambda(lambda input: tf.cast(input, dtype=tf.int32))
        # xmin = lambda_castInt32(xmin)
        # xmax = tf.cast(xmax, dtype=tf.int32)
        # ymin = tf.cast(ymin, dtype=tf.int32)
        # ymax = tf.cast(ymax, dtype=tf.int32)



        # # Step 1: Expand xmin to match the shape of masked_images
        # lambda_expandDimsMoinsUn = Lambda(lambda input: tf.expand_dims(input, -1))
        # xmin_expanded = lambda_expandDimsMoinsUn(xmin)  # Shape becomes (?, 1)
        # xmin_expanded = lambda_expandDimsMoinsUn(xmin_expanded)  # Shape becomes (?, 1, 1)
        # lambda_tile = Lambda(lambda input: tf.tile(input, [1, 48, 48]))
        # xmin_expanded = lambda_tile(xmin_expanded)  # Shape becomes (?, 48, 48)

        # # Step 2: Create a range tensor
        # lambda_xRange = Lambda(lambda input: tf.range(input))
        # x_range = lambda_xRange(tf.constant(48))  # Shape (48,)
        # lambda_reshapeUnUnQuaranteHuit = Lambda(lambda input: tf.reshape(input, (1, 1, 48)))
        # x_range = lambda_reshapeUnUnQuaranteHuit(x_range)  # Shape becomes (1, 1, 48)
        # lambda_tile = Lambda(lambda inputs: tf.tile(inputs[0], [tf.shape(inputs[1])[0], 48, 1]))
        # x_range = lambda_tile([x_range, masked_image])  # Shape becomes (?, 48, 48)

        # # # Step 3: Create the mask
        # lambda_GreaterOrEqual = Lambda(lambda inputs: tf.greater_equal(inputs[0], inputs[1]))
        # mask = lambda_GreaterOrEqual([x_range, xmin_expanded])  

        # lambda_toFloat32 = Lambda(lambda input: tf.cast(input, dtype=tf.float32))
        # mask = lambda_toFloat32(mask)

        # lambda_layerlol = Lambda(lambda inputs: inputs[0]*inputs[1])
        # #masked_image = masked_image * tf.cast(mask, tf.float32)

        # print("tavu")
        # print(masked_image)
        # print(mask)

        # masked_image = lambda_layerlol([masked_image, mask])

        # x_coords, y_coords = tf.meshgrid(tf.range(48, dtype=tf.int32), tf.range(48, dtype=tf.int32))


        # # masked_image
        # print(x_coords.shape) # (48, 48)
        # print(y_coords.shape) # (48, 48)


        # mask_creation_layer = MaskCreationLayer()
        # thelist = mask_creation_layer([xmin, ymin, xmax, ymax])
        # outside_masks, inside_masks = thelist[0], thelist[1]

        # #outside_masks, inside_masks = tf.map_fn(create_mask, (xmin, ymin, xmax, ymax), dtype=(tf.float32, tf.float32))
        # inside_masks = create_mask((xmin, ymin, xmax, ymax))
        # print("daccord")
        # #print(outside_masks.shape) # (?, 48, 48)
        # print(inside_masks.shape) # (48, 48)

        #self.plot_image(inside_masks[0].eval(session=tf.Session()),"inside_mask.png")

        ## VERSION: one action PER batch

        #masked_image = masked_image[0]
        # # xmin, xmax
        # maxes_from_axis_one = tf.reduce_max(masked_image, axis=1)
        # xmin = tf.argmax(maxes_from_axis_one, axis=0)
        # flipped_axis_one = tf.reverse(maxes_from_axis_one, axis=[0])
        # xmax = tf.math.subtract(48 , tf.cast(tf.argmax(flipped_axis_one, axis=0), dtype=tf.int32))

        # # # ymin, ymax
        # maxes_from_axis_zero = tf.reduce_max(masked_image, axis=0)
        # ymin = tf.argmax(maxes_from_axis_zero, axis=0)
        # flipped_axis_zero = tf.reverse(maxes_from_axis_zero, axis=[0])
        # ymax = tf.math.subtract(48 , tf.cast(tf.argmax(flipped_axis_zero, axis=0), dtype=tf.int32))

        # xmin = tf.cast(xmin, dtype=tf.int32)
        # xmax = tf.cast(xmax, dtype=tf.int32)
        # ymin = tf.cast(ymin, dtype=tf.int32)
        # ymax = tf.cast(ymax, dtype=tf.int32)

        # x_coords, y_coords = tf.meshgrid(tf.range(48, dtype=tf.int32), tf.range(48, dtype=tf.int32))

        # # Create the mask
        # mask_rectangle = tf.logical_and(
        #     tf.logical_and(x_coords >= xmin, x_coords < xmax),
        #     tf.logical_and(y_coords >= ymin, y_coords < ymax)
        # )
        # #

        # mask_negative_of_rectangle = tf.logical_not(mask_rectangle)
        # mask_negative_of_rectangle = tf.cast(mask_negative_of_rectangle, tf.float32)
        
        # mask_rectangle = tf.cast(mask_rectangle, tf.float32)
       


        #####################################################################################
        ############################ INPUTS for the MASKER MODEL ############################
        #####################################################################################
        # #first_images = x[:, 0, :, :] # shape is (?, 48, 48, 1)

        # concatenated_tensor = concatenate([flattened_first_image, action_input], axis=-1) # shape is (?, 2328)

        # y_mask = Sequential([
        #     Dense(64, activation='relu'),
        #     #Dense(32, activation='relu'),
        #     Dense(2304)
        # ])(concatenated_tensor)

        # #y_mask = self.mask_layers()(concatenated_tensor)


        # #
        # # Compare elements
        

        # # Convert boolean tensor to 0s and 1s
        

        # # si (48, 48)
        # #               sur axis=0 (x), prends le + petit "x" où valeur est diff de 0 (min_x)
        # #                                   prends le + grand "x" où valeur est diff de 0 (max_x)
        # #                                       IDEM pour "y"
        # #                           ENSUITE tu mets tout à 1 là entre min_x < i < max_x, et j stuff
        

        # # masked_image is really the difference
        


        # # Create a boolean mask where values are True if they are equal to 1
        
        # # Find the index of the first occurrence of True (1) in each example of the batch along the first axis
        # #indices_min_x = tf.reduce_min(tf.argmax(tf.cast(masked_image, tf.int32), axis=1), axis=1)
        # #indices_min_x = tf.reduce_min(tf.argmax(tf.cast(masked_image, tf.int32), axis=1), axis=1)
        # # IS ACTUALLY FUCKING Y ....

        # # x_min .... tu fais: 7
        # indices_min_x = tf.argmax(tf.reduce_max(tf.cast(masked_image, tf.int32), axis=2), axis=1)

        # flipped_masked_image_first_axis = tf.reverse(masked_image, axis=[1])
        # indices_max_x = tf.argmax(tf.reduce_max(tf.cast(flipped_masked_image_first_axis, tf.int32), axis=2), axis=1)

        # indices_max_x = tf.math.subtract(48 , tf.cast(indices_max_x, dtype=tf.int32))

        # print(indices_max_x.shape) # (?,)
        # #exit()
        # print("indices_min_x.shape")
        # print(indices_min_x.shape)
        # #exit()

        # indices_min_y = tf.argmax(tf.reduce_max(tf.cast(masked_image, tf.int32), axis=1), axis=1)
        # flipped_masked_image_second_axis = tf.reverse(masked_image, axis=[2])
        # indices_max_y = tf.argmax(tf.reduce_max(tf.cast(flipped_masked_image_second_axis, tf.int32), axis=1), axis=1)
        # indices_max_y = tf.math.subtract(48 , tf.cast(indices_max_y, dtype=tf.int32))

            
        # indices_min_x = tf.cast(indices_min_x, tf.int32)
        # indices_max_x = tf.cast(indices_max_x, tf.int32)
        

        # # indices_min_x = tf.fill(tf.shape(indices_min_x), 5)
        # # indices_max_x = tf.fill(tf.shape(indices_min_x), 20)
        # # indices_min_y = tf.fill(tf.shape(indices_min_x), 5)
        # # indices_max_y = tf.fill(tf.shape(indices_min_x), 20)

        # masks_target = self.zero_out_regions(masked_image, indices_min_x, indices_max_x, indices_min_y, indices_max_y)

        # #print(masks_target.shape)
        # masks_target = Reshape((2304,))(masks_target)

        # # y_mask <=> predictions
        # self.MaskLoss = mean_absolute_error(masks_target, y_mask)

        # def theloss(*args):
        #     return self.MaskLoss

        # self.theloss = theloss
        #####################################################################################
        ######################## END INPUTS for the MASKER MODEL ############################
        #####################################################################################



        # # Sequential(self.encoder_net)(x)

        ###########################################################################
        # [ CODE for if one Input ]
        # action_layer = Lambda(lambda x: x[:,2], dtype="int32", trainable=False)(x)
        # print(action_layer.shape) # (?, 48, 48, 1)
        # reshaped_tensor = tf.squeeze(action_layer, axis=[0, 3]) # 
        # theaction = reshaped_tensor[0, :24]        
        # images_layer = Lambda(lambda x: x[:,:2])(x)
        ###########################################################################

        

        _, x_pre, x_suc = dapply(x)
        z, z_pre, z_suc = dapply(x, self._encode)
        y, y_pre, y_suc = dapply(z, self._decode)
        # to generate a correct ELBO, input to action should be deterministic
        (l_pre,     ), _ = z_pre.variational_source # see Variational class
        (l_suc,     ), _ = z_suc.variational_source # see Variational class
        p_pre = wrap(l_pre, K.sigmoid(l_pre))
        p_suc = wrap(l_suc, K.sigmoid(l_suc))
        # note: _action takes a probability, but feeding 0/1 data in test time is fine (0/1 can be seen as probabilities)
        #action    = self._action(p_pre,p_suc) # (?, 1, 24)
        #squeezed_action = tf.squeeze(action, axis=1)



        # cosine distance between 1st item of batch of _action output AND 1st item of batch of action_layer

        # Reduce Mean of Cosine Distance between pairwise Predicted action (squeezed) AND the label (theaction)
        # action (?, 1, 24)   CHECK
        # action_layer (?, 48, 48, 1)




        ###########################################################################
        # [ CODE for if one Input ]
        # reshaped_action_layer = tf.squeeze(action_layer, axis=[3])[:, 0, :24]
        # reshaped_label_action = tf.squeeze(action, axis=1)
        # print(reshaped_action_layer.shape) # (?, 24)
        # print(reshaped_label_action.shape) # (?, 24)
        # print(tf.multiply(reshaped_label_action, reshaped_action_layer).shape)
      

        action = action_input
        z_suc_aae = self._apply  (z_pre, action)
        z_pre_aae = self._regress(z_suc, action)
        y_suc_aae = self._decode(z_suc_aae) # 



        # sinon UN SEUL _decode MAIS qui a 2 outputs (1 "mask", 1 contour)
        # # xmin, xmax, ymin, ymax
        #
        # y_pre_aae 
        #   

        y_pre_aae = self._decode(z_pre_aae) # 
        z_aae = dmerge(z_pre_aae, z_suc_aae) # dmerge do from a pair of [B,D,E,F] to [B,2,D,E,F]
        y_aae = dmerge(y_pre_aae, y_suc_aae)

        #(l_action,  ), _ = action.variational_source # see Variational class
        (l_suc_aae, ), _ = z_suc_aae.variational_source # see Variational class
        (l_pre_aae, ), _ = z_pre_aae.variational_source # see Variational class

        p         = dmerge(p_pre, p_suc)
        p_pre_aae = wrap(l_pre_aae, K.sigmoid(l_pre_aae))
        p_suc_aae = wrap(l_suc_aae, K.sigmoid(l_suc_aae))
        p_aae     = dmerge(p_pre_aae, p_suc_aae)

        pdiff_z1z2 = K.mean(K.abs(p_suc - p_suc_aae),axis=-1)
        pdiff_z0z3 = K.mean(K.abs(p_pre - p_pre_aae),axis=-1)
        pdiff_z0z1 = K.mean(K.abs(p_pre - p_suc),axis=-1)
        pdiff_z0z2 = K.mean(K.abs(p_pre - p_suc_aae),axis=-1)

        kl_z0 = z_pre.loss(l_pre, p=self.parameters["zerosuppress"])
        kl_z1 = z_suc.loss(l_suc, p=self.parameters["zerosuppress"])

        # kl_a_z0 = action.loss(l_action, logit_p=Sequential(self.p_a_z0_net)(z_pre))
        # kl_a_z1 = action.loss(l_action, logit_p=Sequential(self.p_a_z1_net)(z_suc))


        kl_a_z0 = self.SpecificLoss(action_input, logit_p=Sequential(self.p_a_z0_net)(z_pre))
        kl_a_z1 = self.SpecificLoss(action_input, logit_p=Sequential(self.p_a_z1_net)(z_suc))


        kl_z1z2 = z_pre_aae.loss(l_pre, logit_p=l_pre_aae)
        kl_z0z3 = z_suc_aae.loss(l_suc, logit_p=l_suc_aae)
        _rec = self.output.loss
        

        # print(self.output) # <latplan.mixins.output.GaussianOutput object at 0x7fbbaa5a3850>
        # print(self) # <latplan.model.ConvolutionalConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus object at 0x7fba4bdf2fd0>
        # print(self.output.loss) # <bound method GaussianOutput.loss of <latplan.mixins.output.GaussianOutput object at 0x7fbbaa5a3850>>


        x0y0 = _rec(x_pre,y_pre)
        x1y1 = _rec(x_suc,y_suc)
        x0y3 = _rec(x_pre,y_pre_aae)
        x1y2 = _rec(x_suc,y_suc_aae) # x1y2 is the "loss" between next ground truth image and prediction of this image

        # masked_image
        #print(masked_image.shape) # (?, 48, 48)
        #print(x_suc.shape) # (?, 48, 48, 1)

        # # 
        x_suc_sq = tf.squeeze(x_suc)
        y_suc_aae_qs = tf.squeeze(y_suc_aae)

        #   outside_masks = tf.expand_dims(outside_masks, 0)
        print("laok")
        # print(inside_masks.shape)
        # print(outside_masks.shape)

        negative_masks = lambda_toFloat32(negative_masks)

        #mask_negative_of_rectangle
        x1y2_in = _rec(x_suc_sq*masks, y_suc_aae_qs*masks)
        x1y2_out = _rec(x_suc_sq*negative_masks,y_suc_aae_qs*negative_masks)

        x_pre_sq = tf.squeeze(x_pre)
        y_pre_aae_sq = tf.squeeze(y_pre_aae)
        x0y3_in = _rec(x_pre_sq*masks, y_pre_aae_sq*masks)
        x0y3_out = _rec(x_pre_sq*negative_masks, y_pre_aae_sq*negative_masks)
        #inside_maskssssss = Lambda(lambda x: x, name = "Lambda_1")(inside_masks)

        self.parameters["beta_a_recons"] = 1
        

        ama3_forward_loss1  = self.parameters["beta_z"] * kl_z0 + x0y0 + kl_a_z0 + self.parameters["beta_d"] * kl_z1z2 + x1y1
        ama3_forward_loss2  = self.parameters["beta_z"] * kl_z0 + x0y0 + kl_a_z0 + self.parameters["beta_a_recons"] * x1y2
        ama3_backward_loss1 = self.parameters["beta_z"] * kl_z1 + x1y1 + kl_a_z1 + self.parameters["beta_d"] * kl_z0z3 + x0y0
        ama3_backward_loss2 = self.parameters["beta_z"] * kl_z1 + x1y1 + kl_a_z1 + self.parameters["beta_a_recons"] * x0y3

        total_loss = (ama3_forward_loss1 + ama3_forward_loss2 + ama3_backward_loss1 + ama3_backward_loss2)/4 

        #total_loss = 10000 * (pdiff_z1z2 + pdiff_z0z3)

        ama3_forward_elbo1  = kl_z0 + x0y0 + kl_a_z0 + kl_z1z2 + x1y1
        #ama3_forward_elbo2  = kl_z0 + x0y0 + kl_a_z0 + x1y2
        ama3_forward_elbo2  = kl_z0 + x0y0 + kl_a_z0 + x1y2_in*0.9 + x1y2_out*0.1
        ama3_backward_elbo1 = kl_z1 + x1y1 + kl_a_z1 + kl_z0z3 + x0y0
        ama3_backward_elbo2 = kl_z1 + x1y1 + kl_a_z1 + x0y3_in*0.9 + x0y3_out*0.1
        elbo = (ama3_forward_elbo1 + ama3_forward_elbo2 + ama3_backward_elbo1 + ama3_backward_elbo2)/4

        self.add_metric("pdiff_z1z2",pdiff_z1z2)
        self.add_metric("pdiff_z0z3",pdiff_z0z3)
        self.add_metric("pdiff_z0z1",pdiff_z0z1)
        self.add_metric("pdiff_z0z2",pdiff_z0z2)
        self.add_metric("kl_z0",kl_z0)
        self.add_metric("kl_z1",kl_z1)
        self.add_metric("kl_a_z0",kl_a_z0)
        self.add_metric("kl_a_z1",kl_a_z1)
        self.add_metric("kl_z1z2",kl_z1z2)
        self.add_metric("kl_z0z3",kl_z0z3)
        self.add_metric("x0y0",x0y0)
        self.add_metric("x1y1",x1y1)
        self.add_metric("x0y3",x0y3)
        self.add_metric("x0y3_in",x0y3_in)
        self.add_metric("x0y3_out",x0y3_out)
        self.add_metric("x1y2_in",x1y2_in)
        self.add_metric("x1y2_out",x1y2_out)
        self.add_metric("elbo",elbo)

        def loss(*args):
            return total_loss
        self.loss = loss

        # note: original z does not work because Model.save only saves the weights that are included in the computation graph between input and output.
        #
        #self.net = Model(x, y_aae)
        # AJOUTE ça à l'output outside_masks, inside_masks, pour vérifier
        self.net = Model(inputs=[x, action_input, masks], outputs=y_aae)
        #self.net = Model(inputs=[x, action_input, masks], outputs=[masked_negative, y_aae])
       
        # AE takes as input x, and the action_input as well
        # BUT outputs y_mask
        #self.masker = Model(inputs=[x, action_input], outputs=y_mask)

        self.encoder     = Model(x, z) # note : directly through the encoder, not AAE
        self.autoencoder = Model(x, y) # note : directly through the decoder, not AAE

        # verify the note above : self.autoencoder.weights does not contain weights for AAE
        # print(self.net.weights)
        # print(self.autoencoder.weights)

        # # for plotting
        # self._encode_prob     = Model(x, p) # note : directly through the encoder, not AAE
        # self._encode_prob_aae = Model(x, p_aae) # note : directly through the encoder, not AAE

        return

    def evaluate(self,*args,**kwargs):
        #exit()
        print("evaluate2")
        metrics = { k:v for k,v in zip(self.net.metrics_names,
                                       ensure_list(self.net.evaluate(*args,**kwargs)))}
        return [metrics["elbo"],metrics["loss"],metrics["x0y0"]+metrics["x1y1"]/2+metrics["x1y2"]/2, metrics["kl_z1z2"], metrics["kl_z0"]]

    pass





################################################################################
# Concrete Class Instantiations

# Zero-sup SAE #################################################################

# ICAPS19 paper
class ZeroSuppressStateAE              (ZeroSuppressMixin, StateAE):
    pass

# Transition SAE ################################################################

# earlier attempts to "sparcify" the transitions. No longer used
class VanillaTransitionAE(              ZeroSuppressMixin, TransitionWrapper, StateAE):
    pass

class HammingTransitionAE(HammingMixin, ZeroSuppressMixin, TransitionWrapper, StateAE):
    pass
class CosineTransitionAE (CosineMixin,  ZeroSuppressMixin, TransitionWrapper, StateAE):
    pass
class PoissonTransitionAE(PoissonMixin, ZeroSuppressMixin, TransitionWrapper, StateAE):
    pass


# IJCAI2020 paper : AMA3
# note: ZeroSuppressMixin must come before TransitionWrapper
# because the loss must be set up after the correct self.encoder is set by _build in TransitionWrapper
class ConcreteDetConditionalEffectTransitionAE              (ZeroSuppressMixin, DetActionMixin, ConditionalEffectMixin,        BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Vanilla Space AE"""
    pass
class ConcreteDetBoolMinMaxEffectTransitionAE               (ZeroSuppressMixin, DetActionMixin, BoolMinMaxEffectMixin,         BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Cube-Space AE with naive discrete effects (not BTL)"""
    pass
class ConcreteDetBoolSmoothMinMaxEffectTransitionAE         (ZeroSuppressMixin, DetActionMixin, BoolSmoothMinMaxEffectMixin,   BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Cube-Space AE with naive discrete effects with smooth min/max"""
    pass
class ConcreteDetLogitAddEffectTransitionAE                 (ZeroSuppressMixin, DetActionMixin, LogitAddEffectMixin,           BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Cube-Space AE without BatchNorm"""
    pass
class ConcreteDetLogitAddEffect2TransitionAE                (ZeroSuppressMixin, DetActionMixin, LogitAddEffect2Mixin,          BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Cube-Space AE without BatchNorm for the current state but with BatchNorm for effects"""
    pass
class ConcreteDetNormalizedLogitAddEffectTransitionAE       (ZeroSuppressMixin, DetActionMixin, NormalizedLogitAddEffectMixin, BaseActionMixinAMA3, TransitionWrapper, StateAE):
    """Final Cube-Space AE implementation in IJCAI2020"""
    pass


CubeSpaceAE_AMA3 = ConcreteDetNormalizedLogitAddEffectTransitionAE


# AMA4 : bidirectional extention of AMA3. It does not have a correct elbo, but it trains reasonably
class ConcreteDetNormalizedLogitAddBidirectionalTransitionAE(ZeroSuppressMixin, DetActionMixin, NormalizedLogitAddBidirectionalMixin, BaseActionMixinAMA4, TransitionWrapper, StateAE):
    """Bidirectional Cube-Space AE implementation; not appearing in any literature"""
    pass


CubeSpaceAE_AMA4 = ConcreteDetNormalizedLogitAddBidirectionalTransitionAE

# note: ConvolutionLiftedBidirectionalMixin must come first in order to set self.parameters["N"] in _build_around

# AMA3 plus : Correction of AMA3 that optimizes the network using correct ELBO.
class ConcreteDetLogitAddEffectTransitionAEPlus(DetActionMixin, LogitAddEffectMixin, BaseActionMixinAMA3Plus, TransitionWrapper, StateAE):
    """Cube-Space AE implementation in JAIR"""
    pass

class ConcreteDetLogitAddEffect2TransitionAEPlus(DetActionMixin, LogitAddEffect2Mixin, BaseActionMixinAMA3Plus, TransitionWrapper, StateAE):
    """Cube-Space AE implementation in JAIR"""
    pass

class ConcreteDetNormalizedLogitAddEffectTransitionAEPlus(DetActionMixin, NormalizedLogitAddEffectMixin, BaseActionMixinAMA3Plus, TransitionWrapper, StateAE):
    """Cube-Space AE implementation in JAIR"""
    pass

class ConvolutionalConcreteDetNormalizedLogitAddEffectTransitionAEPlus(StridedConvolutionalMixin, ConcreteDetNormalizedLogitAddEffectTransitionAEPlus):
    pass

CubeSpaceAE_AMA3Plus = ConcreteDetNormalizedLogitAddEffectTransitionAEPlus
CubeSpaceAE_AMA3Conv = ConvolutionalConcreteDetNormalizedLogitAddEffectTransitionAEPlus


# AMA4 plus : Correction of AMA4 that optimizes the network using correct ELBO.
class ConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus(DetActionMixin, NormalizedLogitAddBidirectionalMixin, BaseActionMixinAMA4Plus, TransitionWrapper, StateAE):
    """Bidirectional Cube-Space AE implementation in JAIR"""
    pass

class ConvolutionalConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus(StridedConvolutionalMixin,ConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus):
    pass

CubeSpaceAE_AMA4Plus = ConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus
CubeSpaceAE_AMA4Conv = ConvolutionalConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus


