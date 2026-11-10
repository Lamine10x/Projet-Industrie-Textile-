import 'package:flutter/material.dart';

class CompteGerant {
  String nom;
  String telephone;
  String motDePasse;
  String pinCode;
  String questionSecrete;
  String reponseSecrete;

  CompteGerant({
    required this.nom,
    this.telephone = '',
    required this.motDePasse,
    required this.pinCode,
    required this.questionSecrete,
    required this.reponseSecrete,
  });
}

class MatiereStock {
  final String id;
  final String nom;
  final String reference;
  final String categorie;
  double quantite;
  final double seuilAlerte;
  final String unite;

  MatiereStock({
    required this.id,
    required this.nom,
    required this.reference,
    required this.categorie,
    required this.quantite,
    required this.seuilAlerte,
    required this.unite,
  });

  bool get estCritique => quantite <= seuilAlerte;
  double get ratio => (quantite / (seuilAlerte * 2.5)).clamp(0.0, 1.0);
}

class CuveTeinture {
  final String id;
  final String nom;
  final Color couleurRef;
  int niveau; // %
  int temperature; // °C
  String statut;

  CuveTeinture({
    required this.id,
    required this.nom,
    required this.couleurRef,
    required this.niveau,
    required this.temperature,
    required this.statut,
  });
}

class Artisan {
  final String id;
  final String nom;
  final String specialite;
  final String pin;
  String statut; // Présent, En pause, Absent
  String heureArrivee;

  Artisan({
    required this.id,
    required this.nom,
    required this.specialite,
    required this.pin,
    required this.statut,
    required this.heureArrivee,
  });
}

class ArticleVente {
  final String id;
  final String nom;
  final int prixFCFA;
  int stock;
  final String dimensions; // ex: "4 yards", "6 yards"
  final String motif;

  ArticleVente({
    required this.id,
    required this.nom,
    required this.prixFCFA,
    required this.stock,
    required this.dimensions,
    required this.motif,
  });
}

class PanierItem {
  final ArticleVente article;
  int quantite;

  PanierItem({
    required this.article,
    this.quantite = 1,
  });

  int get totalFCFA => article.prixFCFA * quantite;
}
