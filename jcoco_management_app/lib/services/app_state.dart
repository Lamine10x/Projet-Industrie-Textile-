import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class PieceBatik {
  final String id;
  final String nom;
  final String motif;
  final String longueur;
  final int stock;
  final int prixUnitaire;
  final String statut;
  final String imageUri;

  PieceBatik({
    required this.id,
    required this.nom,
    required this.motif,
    required this.longueur,
    required this.stock,
    required this.prixUnitaire,
    required this.statut,
    required this.imageUri,
  });
}

class LignePanier {
  final PieceBatik piece;
  int quantite;

  LignePanier({required this.piece, this.quantite = 1});

  int get total => piece.prixUnitaire * quantite;
}

class AppState extends ChangeNotifier {
  // Navigation active : 0 = Dashboard, 1 = Stocks, 2 = Atelier, 3 = Ventes, 4 = Vitrine
  int activeTab = 0;

  void setActiveTab(int index) {
    activeTab = index;
    notifyListeners();
  }

  // Étape sélectionnée dans le pipeline Atelier (1 à 5)
  int activePipelineStep = 3;

  void setActivePipelineStep(int step) {
    activePipelineStep = step;
    notifyListeners();
  }

  // Régime tarifaire Caisse : 'detail' ou 'gros' (-25%)
  String tarifRegime = 'detail';

  void setTarifRegime(String regime) {
    tarifRegime = regime;
    notifyListeners();
  }

  // Panier caisse
  final List<LignePanier> panier = [];

  void ajouterAuPanier(PieceBatik piece) {
    final idx = panier.indexWhere((p) => p.piece.id == piece.id);
    if (idx >= 0) {
      panier[idx].quantite++;
    } else {
      panier.add(LignePanier(piece: piece, quantite: 1));
    }
    notifyListeners();
  }

  void retirerDuPanier(PieceBatik piece) {
    final idx = panier.indexWhere((p) => p.piece.id == piece.id);
    if (idx >= 0) {
      if (panier[idx].quantite > 1) {
        panier[idx].quantite--;
      } else {
        panier.removeAt(idx);
      }
      notifyListeners();
    }
  }

  void viderPanier() {
    panier.clear();
    notifyListeners();
  }

  int get sousTotalCaisse => panier.fold(0, (sum, i) => sum + i.total);
  int get totalCaisse {
    if (tarifRegime == 'gros' && panier.fold(0, (sum, i) => sum + i.quantite) >= 3) {
      return (sousTotalCaisse * 0.75).round();
    }
    return sousTotalCaisse;
  }

  // Liste des pièces finies du catalogue (Format 4 Yards phare)
  final List<PieceBatik> pieces = [
    PieceBatik(
      id: '#BTK-GEO-01',
      nom: 'Batik Géométrique Bassam',
      motif: 'Liane d’Indigo brut',
      longueur: '4 yards',
      stock: 14,
      prixUnitaire: 35000,
      statut: 'Optimum',
      imageUri: AppAssets.pagneBatik,
    ),
    PieceBatik(
      id: '#BTK-OCR-02',
      nom: 'Terres d’Ivoire & Ocre',
      motif: 'Écorce & Cire chaude',
      longueur: '4 yards',
      stock: 5,
      prixUnitaire: 38000,
      statut: 'Seuil bas',
      imageUri: AppAssets.pagneBatik,
    ),
    PieceBatik(
      id: '#BTK-SAV-03',
      nom: 'Soleil de Sassandra',
      motif: 'Savane Dégradée',
      longueur: '4 yards',
      stock: 2,
      prixUnitaire: 42000,
      statut: 'Rupture proche',
      imageUri: AppAssets.pagneBatik,
    ),
    PieceBatik(
      id: '#BTK-PRE-04',
      nom: 'Coupon Prestige Bassam (6Y)',
      motif: 'Canting d’Or Royal',
      longueur: '6 yards',
      stock: 8,
      prixUnitaire: 55000,
      statut: 'Optimum',
      imageUri: AppAssets.pagneBatik,
    ),
  ];
}
