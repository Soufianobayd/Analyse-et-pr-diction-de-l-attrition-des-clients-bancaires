# Analyse-et-prédiction-de-l'attrition-des-clients-bancaires
Analyse et prédiction de l’attrition des clients bancaires avec SQL, Python, Machine Learning et Power BI

##  Description

Projet de "Data Analytics et Machine Learning" appliqué au secteur bancaire, visant à analyser et prédire l’attrition (*Customer Churn*) des clients.

L’objectif est d’identifier les profils à risque et les principaux facteurs associés au départ des clients afin de proposer des recommandations de fidélisation.

## Technologies

* **SQL / MySQL** — gestion et exploration des données
* **Python / Pandas / NumPy** — analyse et préparation
* **Statistiques** — Chi², t-test, ANOVA
* **ACP / PCA** — analyse multidimensionnelle
* **Scikit-learn** — Machine Learning
* **Power BI / DAX** — dashboard interactif

##  Machine Learning

Modèles testés :

* Régression Logistique
* Arbre de Décision
* Random Forest
* KNN
* SVM

###  Meilleur résultat

**Random Forest — AUC = 0,8942**


| Modèle                |        AUC |
| --------------------- | ---------: |
| Random Forest         | **0,8942** |
| SVM                   |     0,8898 |
| Régression Logistique |     0,8830 |
| KNN                   |     0,8634 |
| Arbre de Décision     |     0,7426 |

## 📊 Variables importantes

Les principales variables identifiées par le modèle sont :

* Âge
* Salaire estimé
* Score de crédit
* Solde bancaire
* Nombre de produits
* Ancienneté

##  Dashboard Power BI

Le dashboard contient **5 pages** :

1. Executive Overview
2. Profil et comportement des clients
3. Segmentation et risque d’attrition
4. Machine Learning
5. Recommandations Business

##  Structure

```text
├── data/
├── sql/
├── notebooks/
├── powerbi/
├── docs/
└── README.md
```

## Résultat

Ce projet permet de passer d’une **analyse descriptive** à une **prédiction du risque d’attrition**, puis à une interprétation business à travers Power BI.

**Projet réalisé dans le cadre de mon parcours en Économie Appliquée / Data Analytics.**
