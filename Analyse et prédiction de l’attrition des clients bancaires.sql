CREATE DATABASE bank_churn_analysis;
USE bank_churn_analysis;
##Création de la table
USE bank_churn_analysis;

CREATE TABLE bank_clients (
    CustomerId BIGINT PRIMARY KEY,
    Surname VARCHAR(100),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    Tenure INT,
    Balance DECIMAL(12,2),
    Num_Of_Products INT,
    Has_Credit_Card INT,
    Is_Active_Member INT,
    Estimated_Salary DECIMAL(12,2),
    Churn INT
);
## Vérifier que la table existe
SHOW TABLES;
DESCRIBE bank_clients;

SELECT COUNT(*) AS nombre_clients
FROM bank_clients;

SELECT *
FROM bank_clients
LIMIT 10;

SELECT 
    Churn,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY Churn;

##Nombre de clients dans chaque catégorie
SELECT 
    Churn,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY Churn;

##Calculer le pourcentage
SELECT
    Churn,
    COUNT(*) AS nombre_clients,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_clients), 2) AS pourcentage
FROM bank_clients
GROUP BY Churn;

##Première analyse par genre
SELECT
    Gender,
    Churn,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY Gender, Churn
ORDER BY Gender, Churn;

#porcentage
SELECT
    Gender,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Gender;

##Attrition selon le pays
SELECT
    Geography,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Geography
ORDER BY taux_attrition DESC;

##Âge moyen selon l'attrition
SELECT 
    Churn,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(Age), 2) AS age_moyen
FROM
    bank_clients
GROUP BY Churn;

##Situation financière( Balance moyenne selon l'attrition)
SELECT
    Churn,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(Balance), 2) AS balance_moyenne
FROM bank_clients
GROUP BY Churn;

##Salaire moyen selon l'attrition
SELECT
    Churn,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(Estimated_Salary), 2) AS salaire_moyen
FROM bank_clients
GROUP BY Churn;

##Credit Score moyen
SELECT
    Churn,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(CreditScore), 2) AS credit_score_moyen
FROM bank_clients
GROUP BY Churn;

##Relation avec les produits bancaires (Attrition selon le nombre de produits)
SELECT
    Num_Of_Products,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Num_Of_Products
ORDER BY Num_Of_Products;

##Attrition selon la carte bancaire
SELECT
    Has_Credit_Card,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Has_Credit_Card;

##Attrition selon l'activité du client
SELECT
    Is_Active_Member,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Is_Active_Member;

## Ancienneté (Attrition selon la durée de relation avec la banque)
SELECT
    Tenure,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY Tenure
ORDER BY Tenure;

# Catégories d'âge
SELECT
    CASE
        WHEN Age < 30 THEN 'Moins de 30 ans'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39 ans'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49 ans'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59 ans'
        ELSE '60 ans et plus'
    END AS categorie_age,
    
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition

FROM bank_clients

GROUP BY
    CASE
        WHEN Age < 30 THEN 'Moins de 30 ans'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39 ans'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49 ans'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59 ans'
        ELSE '60 ans et plus'
    END

ORDER BY taux_attrition DESC;

##Segmentation financière
SELECT
    CASE
        WHEN Balance = 0 THEN 'Solde nul'
        WHEN Balance < 50000 THEN 'Solde faible'
        WHEN Balance < 100000 THEN 'Solde moyen'
        ELSE 'Solde élevé'
    END AS categorie_balance,

    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition

FROM bank_clients

GROUP BY
    CASE
        WHEN Balance = 0 THEN 'Solde nul'
        WHEN Balance < 50000 THEN 'Solde faible'
        WHEN Balance < 100000 THEN 'Solde moyen'
        ELSE 'Solde élevé'
    END

ORDER BY taux_attrition DESC;

## Identifier les profils à forte attrition
SELECT
    Geography,
    Gender,
    Is_Active_Member,
    Num_Of_Products,
    COUNT(*) AS nombre_clients,
    SUM(Churn) AS clients_partis,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition
FROM bank_clients
GROUP BY
    Geography,
    Gender,
    Is_Active_Member,
    Num_Of_Products
HAVING COUNT(*) >= 50
ORDER BY taux_attrition DESC;

##Synthèse finale
SELECT
    COUNT(*) AS total_clients,
    SUM(Churn) AS clients_partis,
    COUNT(*) - SUM(Churn) AS clients_restes,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS taux_attrition,
    ROUND(AVG(Age), 2) AS age_moyen,
    ROUND(AVG(Balance), 2) AS balance_moyenne,
    ROUND(AVG(CreditScore), 2) AS credit_score_moyen,
    ROUND(AVG(Estimated_Salary), 2) AS salaire_moyen
FROM bank_clients;