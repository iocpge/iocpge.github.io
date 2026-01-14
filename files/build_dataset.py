import math
import random


def import_csv(filename):
    with open(filename, 'r') as file:
        # cette syntaxe ferme le fichier même si une exception est levée ;-)
        headers = file.readline()
        lines = file.readlines()
    E = []
    C = []
    for line in lines:
        current_data = []
        fields = line.split(',')
        for f in fields[:-1]:  # ne pas prendre la classe
            current_data.append(float(f))
        C.append(int(fields[-1]))
        E.append(current_data)
    return E, C


def mixid(E, C):
    zipped = list(zip(E, C))
    random.shuffle(zipped)
    E, C = zip(*zipped)
    E, C = list(E), list(C)
    return E, C


def split_train_test(E, C, ratio):
    n = len(C)
    stop = math.floor(ratio * n)
    Xtrain = E[:stop]
    Xtests = E[stop:]
    Ytrain = C[:stop]
    Ytests = C[stop:]
    return Xtrain, Ytrain, Xtests, Ytests


if __name__=="__main__":
    E,C = import_csv('iris.csv')
    E, C = mixid(E, C)  # mélanger le jeu de données
    Xtrain, Ytrain, Xtests, Ytests = split_train_test(E, C, 0.7)
    print(len(Xtrain), len(Ytrain), len(Xtests), len(Ytests))