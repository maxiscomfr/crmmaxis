# CRM MAXIS

CRM interne de MAXIS : entreprises et contacts, pipeline, affaires, devis et factures (acompte 30 %, solde 70 %), documents et impression.

Une seule page (`index.html`), sans serveur ni installation.

## Mise en ligne sur Netlify

1. Sur netlify.com : « Add new site » → « Import an existing project » → GitHub → `crmmaxis`.
2. Paramètres de build : laisser vides. Dossier de publication : `/` (racine).
3. Déployer. Le site est alors accessible à l'adresse Netlify.

## Où sont enregistrées les données

- **En ligne sur Netlify** : les fiches sont stockées dans le navigateur de l'appareil utilisé (localStorage), les fichiers joints dans IndexedDB. Rien n'est partagé entre appareils ou navigateurs.
- **Dans l'espace Claude** (page publiée depuis Claude) : les données sont dans la base partagée de l'espace.

Dans les deux cas, fais régulièrement une **sauvegarde** : Réglages → « Exporter (JSON) ». Pour restaurer sur un autre navigateur, utilise « Importer une sauvegarde ». Les fichiers joints ne sont pas inclus dans l'export.

## Réglages à compléter

Onglet **Réglages** : raison sociale, statut juridique, SIRET, immatriculation, adresse, email, téléphone et mention TVA. Ces informations apparaissent sur les devis et factures imprimés.

## Sécurité

Un site Netlify est public : toute personne qui connaît l'adresse peut ouvrir la page. Les données restent dans le navigateur, mais la page elle-même est visible. Pour la protéger, active le mot de passe du site dans Netlify (Site settings → Visitor access → Password protection, offre payante) ou garde le dépôt et le site en privé.

## Fonctionnalités

- Tableau de bord : relances dues, encaissé sur 6 mois, taux de conversion.
- Pipeline en colonnes : glisser-déposer ou changement d'étape depuis la carte.
- Fiches entreprises : contacts, échanges, affaires, devis et factures, documents.
- Devis et factures : numérotation automatique, lignes détaillées (désignation, détail, quantité, prix HT), remise client en pourcentage, acompte et solde calculés depuis l'affaire, impression au format du devis MAXIS.
- Remise client : pourcentage saisi sur la fiche entreprise, repris automatiquement sur chaque nouveau devis ou facture (modifiable).
- Icônes : favicon, icône d'application (écran d'accueil iPhone et Android) et manifeste web.
- Documents : bibliothèque par catégorie, rattachement à une entreprise.
- Raccourcis : Échap ferme une fiche ; le bouton Thème règle clair, sombre ou automatique.

## Tests

Le fonctionnement a été vérifié sur 34 parcours (création, modification, suppression, pipeline, facturation, documents, impression, export) dans un navigateur headless.
