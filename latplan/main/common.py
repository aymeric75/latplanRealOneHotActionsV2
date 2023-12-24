import os
import os.path
import glob

import numpy as np
import latplan.model
import latplan.util.stacktrace
from latplan.util.tuning import simple_genetic_search, parameters, nn_task, reproduce
from latplan.util        import curry, ensure_list

from ..util.noise import gaussian

def _ensure_hyperparameters_list(parameters):
    return {
        k : ensure_list(v)
        for k, v in parameters.items()
    }


################################################################
# globals

args     = None
sae_path = None
thetask = None
################################################################
# command line parsing

import argparse

parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)


# 
# RawDescriptionHelpFormatter
# ArgumentDefaultsHelpFormatter


import matplotlib.pyplot as plt
def plot_image(a,name):
    plt.figure(figsize=(6,6))
    plt.imshow(a,interpolation='nearest',cmap='gray',)
    plt.savefig(name)


parser.add_argument(
    "mode",
    help=(
        "A string which contains mode substrings."
        "\nRecognized modes are:"
        "\n" 
        "\n   learn     : perform the training with a hyperparameter tuner. Results are stored in logs/."
        "\n   plot      : load the weights of the current best hyperparameter and produce visualizations"
        "\n   dump      : dump csv files necessary for producing PDDL models"
        "\n   summary   : perform extensive evaluations and collect the statistics, store the result in performance.json"
        "\n   debug     : debug training limited to epoch=2, batch_size=100. dataset is truncated to 200 samples"
        "\n   reproduce : train the best hyperparameter so far three times with different random seeds. store the best results."
        "\n   iterate   : iterate plot/dump/summary commands above over all hyperparmeters that are already trained and stored in logs/ directory."
        "\n"
        "\nFor example, learn_plot_dump contains 'learn', 'plot', 'dump' mode."
        "\nThe separater does not matter because its presense is tested by python's `in` directive, i.e., `if 'learn' in mode:` ."
        "\nTherefore, learnplotdump also works."))


subparsers = parser.add_subparsers(
    title="subcommand",
    metavar="subcommand",
    required=True,
    description=(
        "\nA string which matches the name of one of the dataset functions in latplan.main module."
        "\n"
        "\nEach task has a different set of parameters, e.g.,"
        "\n'puzzle' has 'type', 'width', 'height' where 'type' should be one of 'mnist', 'spider', 'mandrill', 'lenna',"
        "\nwhile 'lightsout' has 'type' being either 'digital' and 'twisted', and 'size' being an integer."
        "\nSee subcommand help."))

def add_common_arguments(subparser,task,objs=False):
    subparser.set_defaults(task=task)
    subparser.add_argument(
        "num_examples",
        default=5000,
        type=int,
        help=(
            "\nNumber of data points to use. 90%% of this number is used for training, and 5%% each for validation and testing."
            "\nIt is assumed that the user has already generated a dataset archive in latplan/puzzles/,"
            "\nwhich contains a larger number of data points using the setup-dataset script provided in the root of the repository."))
    subparser.add_argument(
        "aeclass",
        help=
        "A string which matches the name of the model class available in latplan.model module.\n"+
        "It must be one of:\n"+
        "\n".join([ " "*4+name for name, cls in vars(latplan.model).items()
                    if type(cls) is type and \
                    issubclass(cls, latplan.network.Network) and \
                    cls is not latplan.network.Network
                ])
    )
    if objs:
        subparser.add_argument("location_representation",
                               nargs='?',
                               choices=["bbox","coord","binary","sinusoidal","anchor"],
                               default="coord",
                               help="A string which specifies how to convert/encode the location in the dataset. See documentations for normalize_transitions_objects")
        subparser.add_argument("randomize_location",
                               nargs='?',
                               type=bool,
                               default=False,
                               help="A boolean which specifies whether we randomly translate the environment globally. See documentations for normalize_transitions_objects")
    subparser.add_argument("comment",
                           nargs='?',
                           default="",
                           help="A string which is appended to the directory name to label each experiment.")
    
    

    subparser.add_argument("--hash",
                           nargs='?',
                           default="",
                           help="A string which replaces (forces) the last part of the directory name")

    return



def main(parameters={}):
    import latplan.util.tuning
    latplan.util.tuning.parameters.update(parameters)

    import sys
    global args, sae_path, thetask, theparameters
    args = parser.parse_args()
    task = args.task
    thetask = task
    delattr(args,"task")
    print(vars(args))
    latplan.util.tuning.parameters.update(vars(args))
    
    theparameters = parameters

    if(sys.argv[2]=="puzzle"):
        sae_path = "_".join(sys.argv[2:9])
    if(sys.argv[2]=="blocks"):
        sae_path = "_".join(sys.argv[2:7])
    if(sys.argv[2]=="lightsout"):
        sae_path = "_".join(sys.argv[2:8])
    if(sys.argv[2]=="sokoban"):
        sae_path = "_".join(sys.argv[2:7])
    if(sys.argv[2]=="hanoi"):
        sae_path = "_".join(sys.argv[2:7])
    #sae_path = "_".join(sys.argv[2:])


    try:
        task(args)
    except:
        latplan.util.stacktrace.format()


################################################################
# procedures for each mode

def plot_autoencoding_image(ae,transitions,label):
    if 'plot' not in args.mode:
        return

    if hasattr(ae, "plot_transitions"):
        transitions = transitions[:6]
        ae.plot_transitions(transitions, ae.local(f"transitions_{label}"),verbose=True)
    else:
        transitions = transitions[:3]
        states = transitions.reshape((-1,*transitions.shape[2:]))
        ae.plot(states, ae.local(f"states_{label}"),verbose=True)

    return


def dump_all_actions(ae,configs,trans_fn,name = "all_actions.csv",repeat=1):
    if 'dump' not in args.mode:
        return
    l     = len(configs)
    batch = 5000
    loop  = (l // batch) + 1
    print(ae.local(name))
    with open(ae.local(name), 'wb') as f:
        for i in range(repeat):
            for begin in range(0,loop*batch,batch):
                end = begin + batch
                print((begin,end,len(configs)))
                transitions = trans_fn(configs[begin:end])
                pre, suc    = transitions[0], transitions[1]
                pre_b       = ae.encode(pre,batch_size=1000).round().astype(int)
                suc_b       = ae.encode(suc,batch_size=1000).round().astype(int)
                actions     = np.concatenate((pre_b,suc_b), axis=1)
                np.savetxt(f,actions,"%d")


def dump_actions(ae,transitions,name = "actions.csv",repeat=1):
    if 'dump' not in args.mode:
        return
    print(ae.local(name))
    ae.dump_actions(transitions,batch_size = 1000)


def dump_all_states(ae,configs,states_fn,name = "all_states.csv",repeat=1):
    if 'dump' not in args.mode:
        return
    l     = len(configs)
    batch = 5000
    loop  = (l // batch) + 1
    print(ae.local(name))
    with open(ae.local(name), 'wb') as f:
        for i in range(repeat):
            for begin in range(0,loop*batch,batch):
                end = begin + batch
                print((begin,end,len(configs)))
                states   = states_fn(configs[begin:end])
                states_b = ae.encode(states,batch_size=1000).round().astype(int)
                np.savetxt(f,states_b,"%d")


def dump_states(ae,states,name = "states.csv",repeat=1):
    if 'dump' not in args.mode:
        return
    print(ae.local(name))
    with open(ae.local(name), 'wb') as f:
        for i in range(repeat):
            np.savetxt(f,ae.encode(states,batch_size = 1000).round().astype(int),"%d")


def dump_code_unused():
    # This code is not used. Left here for copy-pasting in the future.
    if False:
        dump_states      (ae,all_states,"all_states.csv")
        dump_all_actions (ae,all_transitions_idx,
                          lambda idx: all_states[idx.flatten()].reshape((len(idx),2,num_objs,-1)).transpose((1,0,2,3)))


def train_val_test_split(x):
    train = x[:int(len(x)*0.9)]
    val   = x[int(len(x)*0.9):int(len(x)*0.95)]
    test  = x[int(len(x)*0.95):]
    return train, val, test




def run(path,transitions,extra=None):

    print("typetr0")
    print(type(transitions))
    print(transitions.shape)
    print(theparameters)
    transitionss = transitions
    

    os.environ["WANDB_AGENT_MAX_INITIAL_FAILURES"]= "50"

    if(args.hash != ""):
        path_to_json = os.path.join(path+"/logs/"+args.hash)
        #path_to_json = os.path.join(path+"/logs/")

    print(path_to_json)

    import json
    if os.path.isfile(os.path.join(path_to_json,"aux.json")):
        with open(os.path.join(path_to_json,"aux.json"),"r") as f:
            parameters = json.load(f)["parameters"]
    else:
        parameters = {}

    print("MEAN !!!")
    #print(parameters["mean"])
    print()
    #print(len(parameters["mean"]))
    #print(np.array(parameters["mean"]).shape) # (1, 4, 16, 3)
    # (4, 16, 3)

    #print(np.array(parameters["mean"][0]).shape)
    # print("picsize0")
    # print(parameters["picsize"])

    train_for_report, val_for_report, test_for_report = train_val_test_split(transitions)

    print("thetassssk")
    print(thetask.__name__)
    print(str(thetask))


    import sys
    sys.path.append("/workspace/latplanDatasetGen")  # Add the parent directory to sys.path

    

    if thetask.__name__ == "puzzle":
        print("IN MNISTT")
        from genMnist import return_transitions_one_hot
        transitions, actions_transitions = return_transitions_one_hot(augmented=False, custom=True)
    
    elif thetask.__name__ == "hanoi":
        print("lil")
        print(args)
        print(args.disks)
        print(args.towers)
        print(args.num_examples)
        from genHanoi import return_hanoi_transitions_and_actions
        transitions, actions_transitions = return_hanoi_transitions_and_actions(args, parameters, version="with_pddl_constraints")
        #print(transitions)
        #exit()



    elif thetask.__name__ == "sokoban":
        print("lil222")
        print(args)
        from genSokoban import return_sokoban
        transitions = return_sokoban(args, parameters)
        #print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG55555555555555555")
        print(transitions)


    elif thetask.__name__ == "blocks":
        print("blockyblock")
        print(args)
        from genBlocksworld import return_blocks
        transitions = return_blocks(args, parameters)
        print("TTTTTTTTTTTTTTT4444444444444444")
        print(transitions)
        exit()



    for hh in range(10, 14):


        print("acccc")
        print(actions_transitions[hh])
        print(np.where(actions_transitions[hh] == 1))
        #plt.imshow(transitions[10][0],interpolation='nearest',cmap='gray',)
        plt.imshow(transitions[hh][0])
        plt.savefig("HANOIPRE"+str(hh)+".png")

        plt.imshow(transitions[hh][1])
        plt.savefig("HANOISUCC"+str(hh)+".png")


    exit()
    # print("typetr1")
    # print(type(transitions))
    # print(transitions.shape)
    # exit()


    #transitions, actions_transitions

    # print("actions_transitionsactions_transitions")
    # print(type(actions_transitions))
    # print(actions_transitions.shape) # (2400, 192)
    # print(actions_transitions[10]) # [0 0 0 0 0 0 0 0 0 0 1 0 0 .... ]
    # print() # 8 2 7, càd 0 pos 8, left, et 7 a cote
    # print(np.where(actions_transitions[10] == 1))
    # print()
    # plot_image(np.squeeze(transitions[11][0]),"TrBefore11")
    # plot_image(np.squeeze(transitions[11][1]),"TrAfter11")
    print(type(transitions)) # numpy array
    print(transitions.shape) # (2800, 2, 48, 48, 1)

    # plt.imshow()
    

    # in this V2 version, actions_transitions must be represented directly as a one-hot 
    # vector
    #    t d l r   (mouvement)
    #    0 to 8 (positions of the "0")

    # in total (occurence of a position's type X #possible moves):
    #        1 x 4 + 4 x 3 + 4 x 2 = 24 moves SO the one-hot vector must be of size 24 !!!!!


    all_transitions_with_actions = [[transitions[i], actions_transitions[i]] for i in range(len(transitions))]


    # 
    #   
    #

    # # code for expanding actions_transitions ((5000, 2)) into (5000, 2, 48, 48, 1)
    # first = [actions_transitions for i in range(48)] # [(5000, 2) * 10]
    # r0 = np.stack(first, axis=2) # do the matrix
    # second = [r0 for i in range(48)]
    # r1 = np.stack(second, axis=3)
    # print(r1.shape)
    # r1 = np.expand_dims(r1, axis=4)
    # print(r1.shape)

    # ####### now into (5000, 4, 48, 48, 1)

    # concat = np.concatenate((transitions, r1), axis=1)

    # 
    #all_transitions_with_actions = transitions


    train, val, test = train_val_test_split(all_transitions_with_actions)



    def postprocess(ae):
        show_summary(ae, train, test)
        plot_autoencoding_image(ae,train,"train")
        plot_autoencoding_image(ae,test,"test")
        dump_actions(ae,transitions)
        return ae


    def report(net,eval):
        try:
            postprocess(net)
            if extra:
                extra(net)
        except:
            latplan.util.stacktrace.format()
        return





    def train_fn(config=None):

        import wandb

        with wandb.init(config=config, group="GRIDHanoi-4-4", resume=True):
            
            path=path_to_json
            config = wandb.config

            parameters["beta_d"] = config.beta_d
            parameters["beta_z"] = config.beta_z
            parameters["N"] = config.N

            #parameters["beta_a_recons"] = config.beta_a_recons
            #parameters["beta_ama_recons"] = config.beta_ama_recons
            #parameters["aae_width"] = config.aae_width
            # parameters["dropout"] = config.dropout
            # parameters["A"] = 24
            # parameters["beta_d"] = 1000
            # parameters["beta_z"] = 10
            # parameters["beta_a_recons"] = 1
            # parameters["N"] = 300

            parameters["epoch"] = 1200
            parameters["time_start"] = args.hash
            task = curry(nn_task, latplan.model.get(parameters["aeclass"]), path, train, train, val, val, parameters, False) 
            task()



    def normalize(x,save=True):
        mean               = np.mean(x,axis=0)
        std                = np.std(x,axis=0)
        return [mean.tolist()], [std.tolist()]
        # if ("mean" in parameters) and save:
        #     mean = np.array(parameters["mean"][0])
        #     std  = np.array(parameters["std"][0])
        # else:
        #     mean               = np.mean(x,axis=0)
        #     std                = np.std(x,axis=0)
        #     if save:
        #         parameters["mean"] = [mean.tolist()]
        #         parameters["std"]  = [std.tolist()]
        # print("normalized shape:",mean.shape,std.shape)
        # return (x - mean)/(std+1e-20)


    def normalize_transitions(pres,sucs):
        """Normalize a dataset for image-based input format.
    Normalization is performed across batches."""
        B, *F = pres.shape
        transitions = np.stack([pres,sucs], axis=1) # [B, 2, F]
        print(transitions.shape)

        means, stds  = normalize(np.reshape(transitions, [-1, *F])) # [2BO, F]
        # states      = normalized.reshape([-1, *F])
        # transitions = states.reshape([-1, 2, *F])
        return means, stds


    if 'remove_zi' in args.mode:

        net = latplan.model.load(path_to_json, allow_failure=False)
        
        transitionss_noise = gaussian(transitionss)

        zi = net.encode(transitionss[:,:,:,:,:]) # (5000, 2, 300)
        zi_noise = net.encode(transitionss_noise[:,:,:,:,:])

        absolute_differences = np.abs(zi - zi_noise)
        #sum_of_differences = np.sum(absolute_differences, axis=2)

        print(absolute_differences.shape)

        sum1 = np.sum(absolute_differences, axis=0)
        sum2 = np.sum(sum1, axis=0)
        print(sum2)

        print(np.where(sum2 != 0.))

        exit()
        # 
        print()
        print(zi[1])
        print()
        print(zi_noise[1])
        print()
        diff_indices_row1 = np.where(zi[1] != zi_noise[1])[0]
        print("diff ")
        print(diff_indices_row1)


        ##### 

        exit()

    if 'regen_aux' in args.mode:
        
        print(transitionss.shape) # (5000, 2, 4, 16, 3)

        mean, std = normalize_transitions(transitionss[:,0,:,:,:],transitionss[:,1,:,:,:])

        #normalize_transitions
        print("MEAAAAN")
        print(mean)
        # with open(os.path.join(path_to_json,"aux.json"), "w") as f:
        #     json.dump({"parameters": parameters}, f)


    if 'report' in args.mode:

        net = latplan.model.load(path_to_json, allow_failure=False)

        print("train and test data")
        print(len(train))
        print(train[0][0].shape) # the 2 images
        print(len(train[0][1])) # action label
        print("selfNET0")
        print(net) # <latplan.model.ConvolutionalConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus object at 0x7f7eaf929910>

        #net.report(train_for_report, test_data = test_for_report, train_data_to=train_for_report, test_data_to=test_for_report)
        net.report(train, test_data = test, train_data_to=train, test_data_to=test)

    if 'learn' in args.mode:
        
        # #parameters["use_wandb"] = True
        # #parameters["aeclass"] = 
        # simple_genetic_search(
        #     curry(nn_task, latplan.model.get(parameters["aeclass"]),
        #           path,
        #           train, train, val, val), # noise data is used for tuning metric
        #     parameters,
        #     path,
        #     limit              = 100,
        #     initial_population = 100,
        #     population         = 100,
        #     report             = report,
        # )

        # exit()

        import wandb

        # parameters["do_sweep"] = True

        # # 2: Define the search space
        # sweep_configuration = {
        #     "method": "grid",
        #     "parameters": {
        #         #"aae_width": {"values": [100, 500, 1000]},
        #         "beta_d": {"values": [100, 1000, 10000]},
        #         "beta_z": {"values": [1, 10]},
        #         #"output": {"values": ["GaussianOutput(sigma=0.1)", "GaussianOutput(sigma=0.07)", "GaussianOutput(sigma=0.05)"]},
        #         #"new_loss_divider": {"values": [5, 10]},
        #         "N": {"values": [50, 100, 300]},
        #         #"beta_a_recons": {"values": [10, 100, 1000]}
        #     },
        # }

        # parameters["use_wandb"] = True



        # sweep_id = wandb.sweep(sweep_configuration, project="my-Latplan")
        # wandb.agent("mc7358u2", function=train_fn, count=18)



        # 2: Define the conf for single exp
        single_configuration = {
          
        }
        
        wandb.login(key="2eec5f6bab880cdbda5c825881bbd45b4b3819d9")

        with wandb.init(project="my-Latplan", group="Singleruns", name="8-mnist-one-action-really-all-examples-Beta_a10k-RE", resume=False):
            
            parameters["load_sae_weights"] = False
            parameters["do_sweep"] = False
            # parameters["N"] = 300
            # parameters["beta_d"] = 1000
            #parameters["beta_a_recons"] = 10
            # parameters["beta_z"] = 10
            parameters["epoch"] = 2000
            # parameters["aae_width"] = 100
            # parameters["dropout"] = 0
            parameters["use_wandb"] = True
            
            parameters["beta_a_recons"] = 10000

            config = wandb.config
            path = path_to_json
            task = curry(nn_task, latplan.model.get(parameters["aeclass"]), path, train, train, val, val, parameters, False) 
            task()





    if 'learncontinual' in args.mode:
        
        import wandb

        parameters["do_sweep"] = False

        # 2: Define the search space
        sweep_configuration = {
            "method": "grid",
            "parameters": {
                "beta_d": {"values": [100, 1000, 10000]},
                "output": {"values": ["GaussianOutput(sigma=0.1)", "GaussianOutput(sigma=0.07)", "GaussianOutput(sigma=0.05)"]},
                #"new_loss_divider": {"values": [5, 10]},
                "N": {"values": [300, 200, 100]},
            },
        }

        parameters["use_wandb"] = True



        # sweep_id = wandb.sweep(sweep_configuration, project="my-Latplan")
        # wandb.agent(sweep_id, function=train_fn, count=27)



        # 2: Define the conf for single exp
        single_configuration = {
          
        }
        

        # with wandb.init(project="my-Latplan", group="Continuals", name="continual0", resume=False):
            
        #     parameters["load_sae_weights"] = True
        #     parameters["do_sweep"] = False
        #     parameters["N"] = 300
        #     parameters["beta_d"] = 10000
        #     parameters["epoch"] = 2000
            

        #     config = wandb.config
        #     path = path_to_json
        #     task = curry(nn_task, latplan.model.get(parameters["aeclass"]), path, train, train, val, val, parameters, False) 
        #     task()






    if 'dump' in args.mode:
        # prob ici c'est que ça load 
        print("path_to_json")
        print(path_to_json)
        
        net = latplan.model.load(path_to_json, allow_failure=True)

        print(type(transitions)) # <class 'numpy.ndarray'>
        print(transitions.shape) # (5000, 2, 48, 48, 1)


        print(type(all_transitions_with_actions)) # <class 'list'>
        print(len(all_transitions_with_actions)) # 5000

        print(net) # latplan.model.ConvolutionalConcreteDetNormalizedLogitAddBidirectionalTransitionAEPlus

        parameters["beta_ama_recons"] = 1

        dump_actions(net, [transitions, actions_transitions], name = "actions.csv", repeat=1)
        #dump_actions(net, transitions, name = "actions.csv", repeat=1)



    def load_image(name):
        image = imageio.imread(problem(f"{name}.png")) / 255
        print("IIIMMMMM")
        print(image.shape) # (48, 48)
        if len(image.shape) == 2:
            image = image.reshape(*image.shape, 1)
        print("IIMMMM222") # (48, 48, 1)
        print(image.shape)
        image = sae.output.normalize(image)
        print("IIMMMM333") # (48, 48, 1)
        print(image.shape)
        return image


    if 'apply_actions' in args.mode:



        ##  actions: push_up: 0, push_down: 1, push_left: 2, push_right: 3

        # 0 down
        # 0 right
        # 1 down
        # 1 left
        # 1 right
        # 2 down
        # 2 left
        # 3 up
        # 3 down
        # 3 right
        # 4 up
        # 4 down
        # 4 left
        # 4 right
        # 5 up
        # 5 down
        # 5 right
        # 6 up
        # 6 right
        # 7 up
        # 7 left
        # 7 right
        # 8 up
        # 8 left

        net = latplan.model.load(path_to_json, allow_failure=False)

        import tensorflow as tf

        theindex = 9


        # de à 23
        #
        #   
        #
        #


        # images = np.expand_dims(test[theindex][0].astype(np.float32), axis=0)
        # #images = test[4][0].astype(np.float32)
        # action = np.expand_dims(test[theindex][1].astype(np.float32), axis=0)
        # #actions = test[4][1].astype(np.float32)
        # print(images.shape)
        # print(action.shape)
        # print("theAction")
        # print(action)
        # plot_image(np.squeeze(images)[0],"ImBefore9999")

        next_image = net.net.predict([images, action])

        # load_image(name)

        #next_image = net.net([tf.convert_to_tensor(images), tf.convert_to_tensor(actions)])
        # next_image = net.net([images, actions])
        print(type(next_image))
        print(next_image.shape)
        plot_image(np.squeeze(next_image)[1],"ImAfterPredicted9999")
        plot_image(np.squeeze(images)[1],"ImAfterGroundTruth9999")
        exit()

    if 'inspect_latent' in args.mode:

        net = latplan.model.load(path_to_json, allow_failure=False)

        

        import tensorflow as tf
        print(net)
        # input shape (?, 2, 48, 48, 1)

        #theinput = np.ones((1, 2, 48, 48, 1))
        #theinput = np.random.normal(0, 1., size=(1, 2, 48, 48, 1))
        #theinput = tf.convert_to_tensor(theinput)
        theinput = transitions[2]

        outttt= net.autoencode(theinput)

        plt.imshow(outttt[0])
        plt.savefig('outttt.png')

        print(outttt.shape) # (2, 3, 36, 3)

        exit()

        latentvector = np.squeeze(np.array(net.encode(theinput)))
        print("latentvector")
        print(latentvector)
        #print(net.net)
        print()
        print()
        print("jjjjjjj")
        where0 = np.where(latentvector[0] == 1.)
        print(where0)
        print(where0[0].shape)


        print()
        where1 = np.where(latentvector[1] == 1.)
        print(where1)
        print(where1[0].shape)
        inter = np.intersect1d(where0[0], where1[0])
        print("inter")
        print(inter)
        print(len(inter))


    if 'resume' in args.mode:
        simple_genetic_search(
            lambda parameters: nn_task(latplan.model.get(parameters["aeclass"]), path, train, train, val, val, parameters, resume=True),
            parameters,
            path,
            limit              = 100,
            initial_population = 100,
            population         = 100,
            report             = report,
        )

    elif 'debug' in args.mode:
        print("debug run. removing past logs...")
        for _path in glob.glob(os.path.join(path,"*")):
            if os.path.isfile(_path):
                os.remove(_path)
        parameters["epoch"]=1
        parameters["batch_size"]=100
        train, val = train[:200], val[:200]
        simple_genetic_search(
            curry(nn_task, latplan.model.get(parameters["aeclass"]),
                  path,
                  train, train, val, val), # noise data is used for tuning metric
            parameters,
            path,
            limit              = 1,
            initial_population = 1,
            population         = 1,
            report             = report,
        )

    elif 'reproduce' in args.mode:   # reproduce the best result from the grid search log
        reproduce(
            curry(nn_task, latplan.model.get(parameters["aeclass"]),
                  path,
                  train, train, val, val), # noise data is used for tuning metric
            path,
            report      = report,
        )

    if 'iterate' in args.mode:
        wild = os.path.join(path,"logs","*")
        print(f"iterating mode {args.mode} for all weights stored under {wild}")
        for path in glob.glob(wild):
            postprocess(latplan.model.load(path))



def show_summary(ae,train,test):
    if 'summary' in args.mode:
        ae.summary()
        ae.report(train, test_data = test, train_data_to=train, test_data_to=test)


