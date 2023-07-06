import itertools

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.inspection import DecisionBoundaryDisplay

# IMPORT DATASET
df = sns.load_dataset('iris')
print(df)
print(df.describe())
df.info()

# Matrice de dispersion des paramètres / SCATTER MATRIX
sns.pairplot(data=df, hue='species', palette='mako')
plt.savefig('iris_pscatter.svg')
plt.show()

# CREATE DATASETS
X = df[['sepal_length', 'sepal_width', 'petal_length', 'petal_width']].values
y = df['species'].values
print('X -> ', X)
print('Y -> ', y)

# NORMALIZATION
X = StandardScaler().fit(X).transform(X.astype(float))
print('Normalized X -> ', X)

# SPLIT DATASETS -> TRAIN/TEST
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)
print('Train set shape -> ', X_train.shape, y_train.shape)
print('Test set shape -> ', X_test.shape, y_test.shape)

# MACHINE LEARNING
k = 5
classifier = KNeighborsClassifier(n_neighbors=k, weights='distance')
classifier.fit(X_train, y_train)
print(classifier)

# TEST CLASSIFIER / COMPARE TRUE AND PREDICTION
predicted = classifier.predict(X_test)
print('Prediction Accuracy Score (%) :', round(accuracy_score(y_test, predicted) * 100, 2))

# CONFUSION MATRIX
cm = confusion_matrix(y_test, predicted)
print(cm)
labels = np.unique(df['species'].values)
print(labels)
print(labels.shape)
print(labels[1])
ax = sns.heatmap(cm / np.sum(cm), annot=True, cmap='mako', xticklabels=labels, yticklabels=labels)
# plt.show()

# EXTRA -> impact de k sur la frontière de décision
df = sns.load_dataset('iris')
X = df[['sepal_length', 'sepal_width', 'petal_length', 'petal_width']].values
X = StandardScaler().fit(X).transform(X.astype(float))
y = df['species'].values
cls = {}
fig= plt.figure()
sns.set(rc={'figure.figsize':(16,9)})
for id_graph, (i, j) in enumerate([[0, 1], [0, 2], [0, 3], [1, 2], [1, 3], [2, 3]]):
    x = X[:, [i, j]]
    # Train
    cls[(i, j)] = KNeighborsClassifier(n_neighbors=k)
    cls[(i, j)].fit(x, y)
    predicted = cls[(i, j)].predict(X_test[:, [i, j]])
    ax = plt.subplot(2, 3, id_graph + 1)
    plt.tight_layout(h_pad=0.5, w_pad=0.5, pad=2.5)
    rdf = df[[df.columns[i], df.columns[j], 'species']]
    DecisionBoundaryDisplay.from_estimator(
        cls[(i, j)],
        x,
        cmap='mako',
        ax=ax,
        response_method="predict",
        plot_method="pcolormesh",
        xlabel=rdf.columns[0],
        ylabel=rdf.columns[1],
        shading="auto",
    )
    sns.scatterplot(x=x[:, 0], y=x[:, 1], hue=y,
            palette='mako',
            alpha=1.0,
            edgecolor="white",
            legend = False
        )
handles, labels = ax.get_legend_handles_labels()
plt.suptitle("Decision surfaces vs parameters")
_ = plt.axis("tight")
plt.savefig("knn_boundaries.svg")
plt.show()
