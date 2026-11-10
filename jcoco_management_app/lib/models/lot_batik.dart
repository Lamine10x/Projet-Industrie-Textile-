enum EtapeProduction {
  preparation,
  cirage,
  teinture,
  rincage,
  sechage,
  termine,
}

extension EtapeProductionExt on EtapeProduction {
  String get label {
    switch (this) {
      case EtapeProduction.preparation:
        return 'Prépa Coton';
      case EtapeProduction.cirage:
        return 'Cire & Tampons';
      case EtapeProduction.teinture:
        return 'Cuves Indigo';
      case EtapeProduction.rincage:
        return 'Déparaffinage';
      case EtapeProduction.sechage:
        return 'Séchage Soleil';
      case EtapeProduction.termine:
        return 'Pièce Finie (4y)';
    }
  }

  int get stepIndex => index + 1;
}

class LotBatik {
  final String id;
  final String motif;
  final int metrage; // Format standard 4 yards ou total en mètres
  final String artisan;
  final String cuve;
  EtapeProduction etape;
  final String statutAlerte;
  final DateTime dateLancement;

  LotBatik({
    required this.id,
    required this.motif,
    required this.metrage,
    required this.artisan,
    required this.cuve,
    required this.etape,
    required this.statutAlerte,
    required this.dateLancement,
  });
}
