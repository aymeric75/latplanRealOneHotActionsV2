#!/usr/bin/env python3
import sys
import seaborn as sns
import matplotlib as plt
import pandas as pd
# takes path of work
# takes array of indices (for the columns)


def main():

    ## sys.argv[1] = path file1
    ## sys.argv[2] = path file2

    # array total_array_WITH <=> sys.argv[1]
    # array total_array_WITHOUT <=> sys.argv[2]

    label_legend_without = "Real Actions" # <=> total_array_WITH
    label_legend_with = "Normal settings" # <=> total_array_WITHOUT


    # fichier val_metrics.txt
    with open(sys.argv[1]) as file:
     

        # Total array
        total_array_WITH = []

        one_training_dico = {}

        # à chaque "new training" create new array
        # and put the values of all metrics in it

        # parcours du fichier ligne par ligne
        for line in file:

            arr_line = line.split(" ")


            new_arr_line = []
            for ele in arr_line:
                if(ele != ""):
                    new_arr_line.append(ele)                

            # 
            new_arr_line = new_arr_line[1:]

            # if one_training_dico empty
            if not one_training_dico:
                # on ajoute les clés (<=> éléments pairs : elbo , kl_a_z0 etc.)
                for i in range(0, len(new_arr_line), 2):
                    one_training_dico[new_arr_line[i]] = []

            # on ajoute les valeurs à one_training_dico
            for i in range(0, len(new_arr_line), 2):
                one_training_dico[new_arr_line[i]].append(float(new_arr_line[i+1].replace("\n","")))


        total_array_WITH.append(one_training_dico)

    print(total_array_WITH)

    # 2e fichier val_metrics.txt
    with open(sys.argv[2]) as file:
        

        # Total array
        total_array_WITHOUT = []

        one_training_dico = {}

        # à chaque "new training" create new array
        # and put the values of all metrics in it

        for line in file:

            arr_line = line.split(" ")

            new_arr_line = []
            for ele in arr_line:
                if(ele != ""):
                    new_arr_line.append(ele)                

            new_arr_line = new_arr_line[1:]

            if not one_training_dico:
                for i in range(0, len(new_arr_line), 2):
                    one_training_dico[new_arr_line[i]] = []

            for i in range(0, len(new_arr_line), 2):

                one_training_dico[new_arr_line[i]].append(float(new_arr_line[i+1].replace("\n","")))


        total_array_WITHOUT.append(one_training_dico)


    print()
    print()
    print()

    print(total_array_WITHOUT)




    ###########################
    # Choose columns (by key)
    ##########################

    last_dico = {} # this is the final dico (to construct), each key contains the value for one metric for
                   # for the trainng with and without 

    keys = ['elbo', 'kl_a_z0', 'kl_a_z1', 'kl_z0', 'kl_z0z3', 'kl_z1', 'kl_z1z2', 'loss', 'pdiff_z0z1', 'pdiff_z0z2', 'pdiff_z0z3', 'pdiff_z1z2', 'tau', 'x0y0', 'x1y2']

    #keys.append('perc_violations')

    for k in keys:
        last_dico[k] = {"WITH": [], "WITHOUT": []}

        if not k=='perc_violations':
            for dic in total_array_WITHOUT:
                last_dico[k]["WITHOUT"].append(dic[k])
        
        else: # for 'perc_violations' we add the values of the total_array_WITH array
            for dic in total_array_WITH:
                last_dico[k]["WITHOUT"].append(dic[k])

        for dic in total_array_WITH:
            last_dico[k]["WITH"].append(dic[k])


    # parcours du final dico

    nb_of_graphs = len(last_dico)


    import matplotlib.pyplot as plt
    import math


    if(nb_of_graphs==1):
        nbrows, nbcols = 1, 1
    elif(nb_of_graphs==2):
        nbrows, nbcols = 1, 2
    else:
        nbrows = math.ceil(math.sqrt(nb_of_graphs))
        nbcols = math.ceil(math.sqrt(nb_of_graphs))

    print(nb_of_graphs)

    print("nbrows ", nbrows)
    print("nbcols ", nbcols)

    if (nbrows*nbcols - nb_of_graphs) >= nbcols:
        nbrows-=1

    fig, axs = plt.subplots(nbrows, nbcols, figsize=(11, 11))


    fig.tight_layout(pad=2)


    print(last_dico)


    
    # each item here is a new graph
    for cc, (k, v) in enumerate(last_dico.items()):


        nb_exps = len(v["WITH"])
        nb_epochs = len(v["WITH"][0])
        epochs = [i*10 for i in range(nb_epochs)]
        epochs += epochs
        #epochs += epochs

        labels = [label_legend_without for i in range(nb_epochs*nb_exps)]
        

        labels = labels + [label_legend_with for i in range(nb_epochs*nb_exps)]
        #labels[-1] = "WITH"
        

        final_values = []
        for vv in v["WITH"]:
            for el in vv:
                final_values.append(el)

        for vv in v["WITHOUT"]:
            for el in vv:
                final_values.append(el)


        print(len(epochs))
        print(len(labels))
        print(len(final_values))
        #exit()

        d = {'epochs': epochs, 'type': labels, 'values': final_values }

        df = pd.DataFrame(data=d)


        ii = ( cc ) // nbcols
        jj = cc % nbcols

        print("ii: {}, jj: {}".format(ii, jj))

        # [ii][jj]

        if nb_of_graphs == 1:
            sns.lineplot(data=df, x="epochs", y="values", hue="type", ax = axs[0])
            axs[0].set_title(k)
            axs[0].set(xlabel='Variance', ylabel="stuff")


        if nb_of_graphs == 2:
            sns.lineplot(data=df, x="epochs", y="values", hue="type", ax = axs[ii])
            axs[ii].set_title(k)
            axs[ii].set(xlabel='Variance', ylabel="stuff")

        if nb_of_graphs > 2:
            sns.lineplot(data=df, x="epochs", y="values", hue="type", ax = axs[ii][jj])
            axs[ii][jj].set_title(k)
            axs[ii][jj].set(xlabel='Epoch', ylabel="Value")




    plt.tight_layout()
    plt.savefig("title_plot_fileZZ"+".png")



    #


if __name__ == '__main__':

    main()