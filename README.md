
## Migrate the local Postgres database to AWS RDS :

Pour migrer la base de données PostgreSQL locale vers AWS RDS implique plusieurs étapes importante pour assurer que toutes les données, schémas, utilisateurs et configurations
sont transférés correctement.

1. Préparer la base de données AWS RDS
 - Créer une instance RDS PostgresSql via la console de gestion AWS 
 - Choisir les spécifications comme  la version PostgreSQL, les ressources (CPU, mémoire), et la taille du stockage
 - Configurer les paramètres de sécurite, notamment en créant un groupe de sécurite qui permet au serveur local d'accéder à l'instance RDS


2. Préparer la base de données locale

créer une sauvegarde de la base de données. 
> pg_dump -h localhost -U username -F c -b -v -f /path_to_backup/backupfile.dump dbname
> 
- -F c spécifie le format compressé.
- -b inclut les blobs (objets binaires).
- -f est le fichier où la sauvegarde sera stockée.

3. Transférer la base de données sur AWS RDS

 Option 1 : Utiliser pg_dump et pg_restore

- exporter la base de données locale en utilisant pg_dump
- restaurer la base de données sur RDS avec pg_restore
> pg_restore -h your-rds-endpoint.rds.amazonaws.com -U username -d dbname -v /path_to_backup/backupfile.dump


Remplacer your-rds-endpoint.rds.amazonaws.com par l'endpoint RDS

- -U username spécifie l'utilisateur PostgreSQL
- -d dbname est le nom de la base de données cible sur RDS

Option 2 : Utiliser pg_dumpall

migrer plusieurs Base de données 
> pg_dumpall -h localhost -U username > all_db_dump.sql
Puis, restaurer sur AWS RDS avec psql 
> psql -h your-rds-endpoint.rds.amazonaws.com -U username -f all_db_dump.sql
4. Vérification et post-migration
   - vérifier l’intégrité des données
   - Réindexation : il est souvent  utile de réindexer certaines tables pour optimiser les perfomances après la migration
> REINDEX DATABASE dbname;
> 
Migration Postgres
1. installer flyway
> brew install flyway
UPDATE-DB
> lancer la migration
flyway -configFiles=/migrate-database/flyway/conf/flyway-local.conf migrate -outOfOrder=true
> 
par défaut, flyway va récupérer tous les fichiers présents dans le répertoire migration et les exécuter selon leur nommage.

### stratégie de retour en arrière (rollback) 

est défini dans le fichier gitlab

### SQL avancée

1️⃣ Fonctions de fenêtrage (Window Functions) : 
 
permettre d'effectuer des calculs sur un ensemble de lignes liées à la ligne actuelle.
Exemple : SUM(ventes) OVER (PARTITION BY produit ORDER BY date)

💡 Utilité : Idéal pour les calculs de classement, les moyennes mobiles, ou les totaux cumulatifs sans avoir à utiliser de sous-requêtes complexes.

2️⃣ Expressions de table communes (CTEs) : 

aider à simplifier des requêtes complexes en les décomposant en blocs plus gérables.
Exemple : WITH ventes_moy AS (SELECT AVG(ventes) FROM...)

💡 Utilité : Parfait pour améliorer la lisibilité du code et faciliter la maintenance des requêtes complexes.

3️⃣ Opérations de pivotement : 

transformer vos données de lignes en colonnes pour une meilleure visualisation et analyse.
Exemple : PIVOT (SUM(ventes) FOR categorie IN [Électronique, Vêtements, Livres])

💡 Utilité : Essentiel pour créer des rapports croisés dynamiques ou pour préparer les données pour une visualisation.

4️⃣ Expressions régulières : 

utiliser la puissance des regex directement dans les requêtes SQL pour un traitement avancé des chaînes de caractères.
Exemple : WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Z|a-z]{2,}$'

💡 Utilité : Indispensable pour la validation des données, l'extraction de motifs complexes ou le nettoyage de texte à grande échelle.

5️⃣ Requêtes temporelles : 

Manipuler et analyser efficacement les données basées sur le temps.
Exemple : DATEDIFF(jour, date_commande, date_livraison) AS delai_livraison

💡 Utilité : Crucial pour l'analyse de séries temporelles, le calcul de KPIs basés sur le temps, ou l'identification de tendances saisonnières.

#### Pourquoi ces techniques sont-elles si importantes ?

- permettre d'extraire des insights plus profonds de données.
- améliorer considérablement la performance des requêtes sur de grands ensembles de données.

### Améliorer la performance de base de données 

1. index (Indexing)

Créer les bons index en fonction des modèles de requête pour accélérer la récupération des données.
2. Vue matérialisée (Materialized Views)

   Stocker les résultats de requête pré-calculés pour un accès rapide, réduisant ainsi le besoin de traiter des requêtes complexes de manière répétée.
3. (Vertical Scaling)
4. Denormalization

Réduiser les jointures complexes en restructurant les données, ce qui peut améliorer les performances des requêtes.

5. Database Caching

  Stocker les données fréquemment consultées dans une couche de stockage plus rapide pour réduire la charge sur la base de données.

6. Replication
7. Sharding
8. Partitioning
9. Query Optimization
10. Use of Appropriate Data Types
11. Limiting Indexes
12. Archiving Old Data