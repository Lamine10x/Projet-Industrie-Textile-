# 🧵 J.COCO Atelier Batik – Application mobile de gestion et site vitrine

Projet réalisé dans le cadre du module **Atelier de Génie Logiciel** (domaine n°28 : industrie textile), Licence 3 Génie Logiciel, **Institut Ivoirien de Technologie (IIT)**.

**Auteur :** Touré Lamine · **Année académique :** 2026-2027

---

## Sommaire

1. [Présentation de l'entreprise](#1-présentation-de-lentreprise)
2. [Présentation du projet](#2-présentation-du-projet)

---

# 1. Présentation de l'entreprise

## 1.1 Identité

| Rubrique | Information |
| :--- | :--- |
| Nom de la structure | J.COCO Atelier Batik (CI) |
| Secteur d'activité | Industrie textile, artisanat d'art et confection semi-industrielle |
| Localisation | Centre Artisanal de Grand-Bassam, Côte d'Ivoire |
| Canaux de vente | Modèle hybride : vente en gros (grossistes) et vente directe (au détail) |
| Partenariats | Collaborations avec des structures et maisons de mode professionnelles ; ambition de développer ces partenariats |

## 1.2 Vision et positionnement

J.COCO se distingue par une double identité sur le marché ivoirien. Le promoteur souhaite que sa structure soit pleinement reconnue à la fois comme :

1. **Un producteur** : un atelier technique maîtrisant la teinture artisanale et semi-industrielle (technique du batik).
2. **Un vendeur** : un distributeur textile capable de fournir le marché local et les créateurs de mode.

## 1.3 Processus opérationnel et cycle de production

- **Approvisionnement :** la matière première principale (tissu brut en coton ou pagne blanc) provient d'**Uniwax**, leader industriel national.
- **Activité technique :** l'atelier applique la cire chaude, trace les motifs et réalise des bains de teinture successifs pour créer des pièces uniques ou des séries.
- **Standard du marché :** la production est calibrée sur le format **4 yards**, taille de coupe la plus demandée et la plus vendue de l'atelier.
- **Saisonnalité :** l'activité est fortement cyclique ; le pic de production se concentre sur la saison de **janvier à juin**.

## 1.4 Problématiques de l'entreprise

L'analyse de l'activité de J.COCO met en évidence quatre difficultés organisationnelles.

### 1. Les ruptures de stock récurrentes (problème principal)

L'atelier subit des interruptions de production et des pertes de ventes à cause d'une mauvaise visibilité sur ses stocks. Les ruptures concernent deux niveaux :

- **En amont (intrants) :** manque de réactivité sur l'achat des tissus blancs chez Uniwax et des consommables de teinture (cires, pigments).
- **En aval (produits finis) :** difficulté à satisfaire la demande immédiate sur le format phare de 4 yards, faute d'alerte de seuil critique.

### 2. La complexité de la gestion hybride et des tarifs

Le client doit jongler manuellement entre les commandes des grossistes, les ventes au détail et les réservations des structures de mode. Sans outil centralisé, l'application des grilles tarifaires différenciées et le suivi des stocks promis aux partenaires peuvent générer des erreurs.

### 3. La pression logistique saisonnière (janvier à juin)

Pendant la haute saison, le volume de tissu à traiter augmente fortement. Sans suivi des étapes de teinture (cirage, bain, séchage), l'atelier peine à planifier sa charge de travail, ce qui met en risque les délais de livraison des collections des structures de mode partenaires.

### 4. Le déficit de visibilité statistique

Pour asseoir sa notoriété de « producteur-vendeur », l'entreprise manque de données chiffrées centralisées. Elle ne peut pas mesurer précisément la part de sa production absorbée par les grossistes par rapport au détail, ni évaluer la performance de son atelier à l'issue de la haute saison.

---

# 2. Présentation du projet

> Cette section résume le **cahier des charges** du projet (`Cahier_des_charges_JCOCO.docx`).

## 2.1 Contexte et objectifs

Le client ne dispose pas d'ordinateur : la gestion de l'atelier doit se faire entièrement **sur smartphone**. Il souhaite aussi gagner en visibilité et recevoir plus de demandes de collaboration, au-delà de ses collaborations actuelles avec des groupes de dames de l'église.

La solution comprend :

- une **application mobile Flutter** de gestion, réservée à l'atelier ;
- un **site web vitrine** public, lié à cette application.

**Objectifs :**

1. Réduire les ruptures de stock (tissu Uniwax, intrants de teinture, pièces finies en 4 yards).
2. Suivre la production de teinture, en particulier de janvier à juin.
3. Distinguer les ventes en gros et au détail.
4. Augmenter la visibilité de l'atelier et faciliter les demandes de collaboration et les réservations d'ateliers.

## 2.2 Besoins exprimés par le client

| Thème | Besoin |
| :--- | :--- |
| Matériel | Pas d'ordinateur portable : solution mobile |
| Positionnement | Être connu en tant que producteur et vendeur |
| Visibilité | Plus de visibilité et plus de demandes de collaboration |
| Canaux de vente | Grossistes et vente au détail |
| Produit phare | Format 4 yards, taille la plus demandée |
| Fournisseur | Tissu acheté chez Uniwax |
| Production | Teinture ; saison de janvier à juin |
| Partenariats | Ambition de collaborer avec des structures de mode |
| Problème principal | Les ruptures de stock |
| Déploiement | Possibilité de déployer l'application |

> Les modules, rôles et technologies ci-dessous sont des propositions de l'auteur, déjà soumises à la validation du client.

## 2.3 Fonctionnalités

### Application mobile de gestion (Flutter)

| Module | Exigences |
| :--- | :--- |
| **Stocks et alertes** | STK-01 inventaire du tissu brut, des pigments et des cires · STK-02 inventaire des pièces finies par format (priorité 4 yards) · STK-03 notification sous un seuil défini par le client |
| **Production (teinture)** | PRO-01 suivi de chaque lot : `Tissu reçu` → `Cirage` → `Teinture` → `Séchage` → `Stocké` · PRO-02 vue de planification de la saison janvier-juin |
| **Ventes et partenaires** | VEN-01 clients par catégorie (grossistes, détail, structures de mode) · VEN-02 tarif de gros et tarif de détail · VEN-03 suivi des commandes et collaborations |
| **Ateliers et vitrine** | ATE-01 créneaux d'ateliers · ATE-02 validation des rendez-vous · ATE-03 gestion des photos du site · ATE-04 traitement des demandes de collaboration (`Nouvelle` → `En discussion` → `Acceptée` / `Refusée`) |
| **Tableau de bord** | TDB-01 stocks critiques, ventes par canal, lots en cours, rendez-vous et demandes à traiter |

### Site web vitrine (public)

Le site utilise les mêmes données que l'application : une photo ajoutée ou un créneau ouvert depuis le téléphone apparaît directement sur le site.

- **SIT-01** : prendre rendez-vous pour un atelier (créneau, nom, nombre de participants, contact).
- **SIT-02** : accéder au contact WhatsApp de J.COCO atelier Batik.
- **SIT-03** : admirer les réalisations dans une galerie de photos.
- **SIT-04** : envoyer une demande de collaboration (structure de mode, boutique, institution, grossiste).

## 2.4 Acteurs et droits

| Acteur | Application de gestion | Site vitrine |
| :--- | :---: | :---: |
| Responsable de l'atelier (propriétaire) | Accès complet | Gère le contenu |
| Collaborateur de l'atelier (optionnel) | Stocks et production | Lecture |
| Visiteur, client potentiel ou partenaire | Aucun accès | Consulte, réserve, envoie une demande |

## 2.5 Choix techniques

- **Application de gestion :** Flutter (Android en priorité, iOS possible).
- **Site vitrine :** site web responsive (Flutter Web ou front web classique), connecté à la même API.
- **Backend :** API REST (Laravel ou Node.js) avec MySQL ou PostgreSQL, ou alternative Firebase.
- **Notifications :** alertes de rupture de stock sur le téléphone.
- **Connectivité :** à discuter avec le client (connexion limitée possible à l'atelier).
- **Déploiement :** API et site sur un VPS ou un service cloud ; application distribuée en APK.
- **Sécurité :** authentification et accès séparés par rôle.

## 2.6 Livrables

- [x] Cahier des charges
- [ ] Recette des besoins validée par le client
- [ ] Diagramme de cas d'utilisation (UML)
- [ ] Maquettes de l'écran (application)
- [ ] Prototype de l'application Flutter
- [ ] Prototype du site vitrine

---

## Auteur

**Touré Lamine** – Licence 3 Génie Logiciel, Institut Ivoirien de Technologie (IIT)