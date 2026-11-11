import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../services/app_state.dart';
import 'auth_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final AppState _state = AppState();

  @override
  void initState() {
    super.initState();
    _state.addListener(() {
      if (mounted) setState(() {});
    });
  }

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Stocks';
      case 2:
        return 'Atelier';
      case 3:
        return 'Caisse & Ventes';
      case 4:
        return 'Vitrine';
      default:
        return 'J.COCO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // HEADER EXACT FIGMA / STITCH
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.95),
            boxShadow: const [
              BoxShadow(
                color: Color(0x101A2B4C),
                blurRadius: 8,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Titre
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35), width: 1.5),
                        ),
                        child: const Center(
                          child: Text(
                            'JC',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'J.COCO ATELIER · BASSAM',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: AppColors.secondary,
                            ),
                          ),
                          Text(
                            _getTabTitle(_state.activeTab),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Badge "Atelier" + Profil Maître Jean
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryFixed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Atelier',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF390C00),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showProfilMenu(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.secondaryFixed,
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'MJ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // CORPS MULTI-ONGETS
      body: IndexedStack(
        index: _state.activeTab,
        children: [
          _buildDashboardView(),
          _buildStocksView(),
          _buildAtelierView(),
          _buildCaisseView(),
          _buildVitrineView(),
        ],
      ),

      // BOTTOM NAVIGATION EXACTE FIGMA (5 ONGLETS)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x141A2B4C),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.dashboard_outlined, Icons.dashboard, 'Dashboard'),
                _buildNavItem(1, Icons.texture, Icons.texture, 'Stocks'),
                _buildNavItem(2, Icons.water_drop_outlined, Icons.water_drop, 'Atelier'),
                _buildNavItem(3, Icons.handshake_outlined, Icons.handshake, 'Ventes'),
                _buildNavItem(4, Icons.storefront_outlined, Icons.storefront, 'Vitrine'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconInactive, IconData iconActive, String label) {
    final isActive = _state.activeTab == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _state.setActiveTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? iconActive : iconInactive,
            color: isActive ? AppColors.secondary : AppColors.onSurfaceVariant,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
              color: isActive ? AppColors.secondary : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // VUE 1 : DASHBOARD & ALERTES ANTI-RUPTURE
  // ==========================================
  Widget _buildDashboardView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Carte Salutation & Météo
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryFixed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.waving_hand, color: AppColors.secondary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ATELIER J.COCO',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.secondary),
                      ),
                      Text(
                        'Salutation, Bienvenue !',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Ravi de vous retrouver, ceci est un nouveau jour pour l’atelier textile de Bassam.',
                  style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // SECTION ALERTES ANTI-RUPTURE (3 CARTES CRITIQUES)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 18),
                SizedBox(width: 6),
                Text(
                  'Alertes Anti-Rupture',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '3 alertes',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onErrorContainer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Alerte 1 : Tissu Coton Brut (Rouge critique)
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: const Border(left: BorderSide(color: AppColors.error, width: 4)),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CRITIQUE · STOCK ÉPUISÉ SOUS 48H',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.error),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Tissu Coton Brut Uniwax',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                            children: [
                              TextSpan(text: 'Reste : '),
                              TextSpan(text: '12 yards ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.error, fontSize: 13)),
                              TextSpan(text: '(Seuil sécurité : 50 yards)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withValues(alpha: 0.25)),
                    ),
                    child: const Icon(Icons.texture, color: AppColors.error, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.24,
                  minHeight: 6,
                  backgroundColor: AppColors.surfaceContainer,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Commande d’urgence émise vers fournisseur Adjamé !')),
                    );
                  },
                  icon: const Icon(Icons.local_shipping, size: 16),
                  label: const Text('Réapprovisionner fournisseur (Adjamé)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Alerte 2 : Cire d'abeille (Orange Urgent)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: const Border(left: BorderSide(color: AppColors.secondaryContainer, width: 4)),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('URGENT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.secondary)),
                    const Text('Cire d’abeille d’épargne', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                        children: [
                          TextSpan(text: 'Stock : '),
                          TextSpan(text: '3.5 kg ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                          TextSpan(text: '(Seuil : 8 kg)'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryContainer.withValues(alpha: 0.3)),
                ),
                child: const Icon(Icons.water_drop, color: AppColors.secondary, size: 22),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Alerte 3 : Indigo Naturel (Surveillance Ocre)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: const Border(left: BorderSide(color: AppColors.tertiaryFixedDim, width: 4)),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SURVEILLANCE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.tertiary)),
                    const Text('Pigments Indigo Naturel', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                        children: [
                          TextSpan(text: 'Stock : '),
                          TextSpan(text: '2 flacons ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          TextSpan(text: '(2 cuves max)'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixedDim.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.tertiaryFixedDim.withValues(alpha: 0.4)),
                ),
                child: const Icon(Icons.palette_outlined, color: AppColors.primary, size: 22),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // SECTION : PRODUCTION LIVE DE L'ATELIER (CYCLE BASSAM V4)
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.water_drop, color: AppColors.primary, size: 18),
                SizedBox(width: 6),
                Text(
                  'Atelier en cours (Live)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
              ],
            ),
            Text(
              'Cycle Bassam v4',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Grille 2x2 des métriques opérationnelles
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildLiveTile('04', 'Lots en cirage', 'Traçage motifs cire chaude', Icons.draw, AppColors.primary),
            _buildLiveTile('03', 'Cuves actives', '2 Indigo · 1 Ocre latérite', Icons.waves, AppColors.secondary),
            _buildLiveTile('05', 'Séchage soleil', '5 pièces de 4 yards en cours', Icons.wb_sunny, AppColors.tertiaryFixedDim),
            _buildLiveTile('14', 'Pièces prêtes', 'Disponibles showroom', Icons.check_circle, AppColors.emeraldSuccess),
          ],
        ),

        const SizedBox(height: 20),

        // SECTION : COMMANDES & PARTENAIRES (Styliste Awa K. & Atelier)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.handshake, color: AppColors.secondary, size: 18),
                SizedBox(width: 6),
                Text(
                  'Commandes & Partenaires',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
              ],
            ),
            TextButton(
              onPressed: () => _state.setActiveTab(3),
              child: const Text('Voir tout', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary)),
            ),
          ],
        ),

        // Carte Styliste Awa K.
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: const Text('AK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Styliste Awa K.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
                          Text('Abidjan Fashion Week 2025', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryFixed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'En attente WhatsApp',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF390C00)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Demande : 10 pièces (4 yards) motif géométrique "Liane de Bassam" sur indigo brut dégradé.',
                  style: TextStyle(fontSize: 11, color: AppColors.onSurface),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 38,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ouverture WhatsApp vers Styliste Awa K...')),
                    );
                  },
                  icon: const Icon(Icons.chat, size: 14),
                  label: const Text('Répondre sur WhatsApp', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // BARRE D'ACTIONS RAPIDES TACTILE (3 BOUTONS THUMB-ZONE)
        const Text(
          'ACTIONS RAPIDES D’ATELIER',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildThumbAction(Icons.playlist_add, '+ Nouveau lot', AppColors.primary, () {
                _showNouveauLotModal();
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThumbAction(Icons.point_of_sale, '+ Vente rapide', AppColors.secondary, () {
                _state.setActiveTab(3);
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThumbAction(Icons.add_a_photo, '+ Vitrine', AppColors.surfaceContainerHigh, () {
                _state.setActiveTab(4);
              }, textColor: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLiveTile(String number, String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Text(number, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
              Text(subtitle, style: const TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumbAction(IconData icon, String label, Color bg, VoidCallback onTap, {Color textColor = Colors.white}) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // VUE 2 : STOCKS & FORMAT PHARE 4 YARDS
  // ==========================================
  Widget _buildStocksView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Carte Métrique de Synthèse (48 pièces · 1 680 000 FCFA)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.inventory_2, color: AppColors.secondaryFixedDim, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'ATELIER BASSAM · STOCK PRÊT',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryFixedDim, letterSpacing: 0.8),
                      ),
                    ],
                  ),
                  Text('4 Yards Std', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    children: [
                      Text('48', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
                      SizedBox(width: 6),
                      Text('pièces disponibles', style: TextStyle(color: AppColors.surfaceContainerHighest, fontSize: 11)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('1 680 000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.secondaryFixed)),
                      Text('FCFA ESTIMÉS', style: TextStyle(fontSize: 9, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Barre tricolore de santé de stock
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 6,
                  child: Row(
                    children: [
                      Expanded(flex: 78, child: Container(color: AppColors.secondaryFixedDim)),
                      Expanded(flex: 15, child: Container(color: AppColors.secondaryContainer)),
                      Expanded(flex: 7, child: Container(color: AppColors.error)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('38 Optimum', style: TextStyle(fontSize: 9, color: Colors.white70)),
                  Text('7 Seuil Bas', style: TextStyle(fontSize: 9, color: Colors.white70)),
                  Text('3 Ruptures', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.secondaryFixedDim)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Filtres rapides format phare
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Text('Format Phare 4 Yards', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Icon(Icons.check, size: 14, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildFilterPill('Coton Uniwax'),
              const SizedBox(width: 8),
              _buildFilterPill('Grand-Bassam'),
              const SizedBox(width: 8),
              _buildFilterPill('Alertes Seuil'),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Liste des pièces finies (4 Yards)
        const Text(
          'PIÈCES FINIES EN RAYON (4 YARDS)',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.6),
        ),
        const SizedBox(height: 10),

        ..._state.pieces.map((p) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.style, color: AppColors.secondaryFixed, size: 20),
                    SizedBox(height: 2),
                    Text('4Y', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
                    Text('${p.longueur} · ${p.motif}', style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Text('${p.prixUnitaire} FCFA', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${p.stock} pcs', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: p.stock > 5 ? AppColors.emeraldSuccess.withValues(alpha: 0.12) : AppColors.errorContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p.statut,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: p.stock > 5 ? AppColors.emeraldSuccess : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildFilterPill(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
    );
  }

  // ==========================================
  // VUE 3 : ATELIER & PIPELINE DE FABRICATION
  // ==========================================
  Widget _buildAtelierView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Bannière Haute Saison (Jan – Juin)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wb_sunny, color: AppColors.secondaryFixed, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'HAUTE SAISON (JAN – JUIN)',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondaryFixed, letterSpacing: 0.8),
                      ),
                    ],
                  ),
                  Text('Cadence +18%', style: TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Objectif : 65 pièces', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
              const Text('42 pièces façonnées ce mois · 64% de complétion', style: TextStyle(fontSize: 11, color: AppColors.primaryFixedDim)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: const LinearProgressIndicator(
                  value: 0.64,
                  minHeight: 8,
                  backgroundColor: Color(0x33000000),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryContainer),
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bassam Atelier n°1', style: TextStyle(fontSize: 10, color: Colors.white60)),
                  Text('Reste 23 pièces', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondaryFixed)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // PIPELINE DE FABRICATION (5 ÉTAPES HORIZONTALES SCROLLABLES)
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.swap_calls, color: AppColors.secondary, size: 18),
                SizedBox(width: 6),
                Text(
                  'Pipeline de Fabrication',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
              ],
            ),
            Text('5 Étapes Clés', style: TextStyle(fontSize: 11, color: AppColors.outline)),
          ],
        ),
        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPipelineStep(1, '01 · Prépa', 'Tissus Reçus', '6 rouleaux en attente', '6'),
              _buildPipelineStep(2, '02 · Cirage', 'Cire d’Abeille', 'Motifs à la main', '4'),
              _buildPipelineStep(3, '03 · Cuves', 'Teinture Indigo', 'Cuves #2 et #3 actives', '3'),
              _buildPipelineStep(4, '04 · Séchage', 'Déparaffinage', 'Étendoir plein air', '5'),
              _buildPipelineStep(5, '05 · Fini', 'Stock & 4 Yards', 'Prêt expédition', '24'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // SURVEILLANCE DES CUVES
        const Text(
          'ÉTAT DES CUVES D’INDIGO & DE TEINTURE',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.6),
        ),
        const SizedBox(height: 10),

        _buildCuveCard('Cuve #1 · Indigo Végétal Naturel', 85, 32, AppColors.primary, 'Fermentation active'),
        _buildCuveCard('Cuve #2 · Ocre Latérite & Acacia', 42, 28, AppColors.secondary, 'Bain à recompléter'),
        _buildCuveCard('Cuve #3 · Vert Savane & Écorces', 92, 30, AppColors.emeraldSuccess, 'Prête pour immersion'),
      ],
    );
  }

  Widget _buildPipelineStep(int step, String number, String title, String sub, String badge) {
    final isActive = _state.activePipelineStep == step;
    return GestureDetector(
      onTap: () => _state.setActivePipelineStep(step),
      child: Container(
        width: 150,
        height: 100,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isActive ? [const BoxShadow(color: Colors.black26, blurRadius: 6)] : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.secondaryFixed : AppColors.onSurfaceVariant,
                  ),
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: isActive ? AppColors.secondary : AppColors.surfaceContainerHighest,
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : AppColors.primary,
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 9,
                    color: isActive ? AppColors.primaryFixedDim : AppColors.outline,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuveCard(String nom, int niveau, int temp, Color couleur, String statut) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: couleur, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Text(nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primary)),
                ],
              ),
              Text('$temp°C', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Niveau du bain : $niveau%', style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
              Text(statut, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: couleur)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: niveau / 100,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(couleur),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // VUE 4 : CAISSE & VENTES DIRECTES (POS)
  // ==========================================
  Widget _buildCaisseView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Carte Recette du Jour (485 000 FCFA)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryContainer, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.storefront, color: AppColors.tertiaryFixedDim, size: 16),
                      SizedBox(width: 6),
                      Text('RECETTE DU JOUR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                    ],
                  ),
                  Text('+14% vs hier', style: TextStyle(color: Color(0xFF6EE7B7), fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('485 000 FCFA', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
              const Text('7 transactions enregistrées au terminal atelier', style: TextStyle(fontSize: 10, color: AppColors.primaryFixedDim)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Grossistes', style: TextStyle(fontSize: 10, color: AppColors.secondaryFixed)),
                          Text('8 pièces', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('32 yards métrés', style: TextStyle(fontSize: 9, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Détail Boutique', style: TextStyle(fontSize: 10, color: AppColors.tertiaryFixedDim)),
                          Text('11 pièces', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('44 yards vendus', style: TextStyle(fontSize: 9, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Sélecteur de Tarification Hybride (Détail vs Grossistes -25%)
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _state.setTarifRegime('detail'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _state.tarifRegime == 'detail' ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: _state.tarifRegime == 'detail' ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
                    ),
                    child: Center(
                      child: Text(
                        'Tarif Détail (1 - 2 pcs)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _state.tarifRegime == 'detail' ? AppColors.secondary : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _state.setTarifRegime('gros'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _state.tarifRegime == 'gros' ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: _state.tarifRegime == 'gros' ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
                    ),
                    child: Center(
                      child: Text(
                        'Tarif Gros (-25% dès 3y)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _state.tarifRegime == 'gros' ? AppColors.secondary : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Catalogue d'Articles & Ajout Panier
        ..._state.pieces.map((piece) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(piece.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primary)),
                    Text('${piece.longueur} · Stock: ${piece.stock} pcs', style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                    Text('${piece.prixUnitaire} FCFA', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                onPressed: () => _state.ajouterAuPanier(piece),
                child: const Text('+ Ajouter', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        )),

        // Panier d'encaissement actif
        if (_state.panier.isNotEmpty) ...[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_state.panier.length} article(s) au panier', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                    Text('${_state.totalCaisse} FCFA', style: const TextStyle(color: AppColors.secondaryFixed, fontWeight: FontWeight.w900, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => _showPaiementModal(),
                    child: const Text('ENCAISSER (CASH / MOBILE MONEY)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _showPaiementModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx2, setModalState) {
            String modePaiement = 'especes';
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Règlement Caisse', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primary)),
                      IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                    ],
                  ),
                  const Divider(),
                  // Récap panier
                  ..._state.panier.map((ligne) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('${ligne.piece.nom} × ${ligne.quantite}', style: const TextStyle(fontSize: 12, color: AppColors.onSurface), overflow: TextOverflow.ellipsis)),
                        Text('${ligne.total} FCFA', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                  )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TOTAL À PAYER', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('${_state.totalCaisse} FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.secondary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('MODE DE PAIEMENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8, color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setModalState(() => modePaiement = 'especes'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: modePaiement == 'especes' ? AppColors.emeraldSuccess : AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: modePaiement == 'especes' ? AppColors.emeraldSuccess : Colors.transparent, width: 2),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.money, color: modePaiement == 'especes' ? Colors.white : AppColors.onSurfaceVariant, size: 22),
                                const SizedBox(height: 4),
                                Text('Espèces', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: modePaiement == 'especes' ? Colors.white : AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setModalState(() => modePaiement = 'wave'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: modePaiement == 'wave' ? AppColors.secondary : AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: modePaiement == 'wave' ? AppColors.secondary : Colors.transparent, width: 2),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.phone_android, color: modePaiement == 'wave' ? Colors.white : AppColors.onSurfaceVariant, size: 22),
                                const SizedBox(height: 4),
                                Text('Wave / Orange', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: modePaiement == 'wave' ? Colors.white : AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setModalState(() => modePaiement = 'moov'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: modePaiement == 'moov' ? AppColors.primary : AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: modePaiement == 'moov' ? AppColors.primary : Colors.transparent, width: 2),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.wifi, color: modePaiement == 'moov' ? Colors.white : AppColors.onSurfaceVariant, size: 22),
                                const SizedBox(height: 4),
                                Text('Moov Money', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: modePaiement == 'moov' ? Colors.white : AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        final panierSnapshot = List.from(_state.panier);
                        final totalSnapshot = _state.totalCaisse;
                        Navigator.pop(ctx);
                        _state.viderPanier();
                        _showTicketCaisse(panierSnapshot, totalSnapshot, modePaiement);
                      },
                      icon: const Icon(Icons.check_circle, size: 18),
                      label: const Text('VALIDER ET ÉMETTRE LE REÇU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================
  // VUE 5 : VITRINE & SITE WEB
  // ==========================================
  Widget _buildVitrineView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const Text(
          'VITRINE & SITE WEB J.COCO',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.6),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.public, color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text('www.jcoco-batik.ci', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldSuccess.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('En Ligne', style: TextStyle(color: AppColors.emeraldSuccess, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Plateforme vitrine de l’atelier de Grand-Bassam présentant les créations textiles, les réservations d’ateliers d’initiation et les demandes de partenariats de mode.',
                style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, height: 1.4),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ouverture du site web J.COCO...')));
                      },
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const Text('VISITER LE SITE WEB', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerHigh,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lien copié dans le presse-papiers !')));
                    },
                    icon: const Icon(Icons.share, color: AppColors.primary, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // MENU PROFIL & DÉCONNEXION
  // ==========================================
  void _showProfilMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Poignée
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
              // Avatar & infos
              Row(
                children: [
                  Container(
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondaryFixed, width: 2),
                    ),
                    child: const Center(
                      child: Text('MJ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Maître Jean Kouadio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary)),
                      const Text('Gérant · Atelier J.COCO Bassam', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldSuccess.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('● Session Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emeraldSuccess)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.person_outline, color: AppColors.primary, size: 20),
                ),
                title: const Text('Mon Profil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: const Text('+225 07 88 44 22 10', style: TextStyle(fontSize: 11)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil Maître Jean Kouadio')));
                },
              ),
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
                ),
                title: const Text('Changer le Code PIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modification du PIN...')));
                },
              ),
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.errorContainer, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.logout, color: AppColors.error, size: 20),
                ),
                title: const Text('Se Déconnecter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.error)),
                subtitle: const Text("Fermer la session de l'atelier", style: TextStyle(fontSize: 11)),
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmerDeconnexion();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _confirmerDeconnexion() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Fermer l'Atelier ?", style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary)),
        content: const Text(
          'Vous allez fermer la session de Maître Jean.\nToutes les données non sauvegardées seront perdues.',
          style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler', style: TextStyle(color: AppColors.onSurfaceVariant)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
            child: const Text('Se Déconnecter', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MODALE NOUVEAU LOT DE BATIK
  // ==========================================
  void _showNouveauLotModal() {
    final motifs = ['Liane de Bassam', 'Géométrique Kente', 'Soleil Sassandra', 'Écorce & Cire', 'Prestige Royal', 'Dégradé Savane'];
    final artisans = ['Kouamé Brou · Chef teinturier', 'Awa Diallo · Tisserande', 'Yao Kouassi · Cirage cire', 'Fatou Koné · Finition'];
    final cuves = ['Cuve #1 · Indigo Végétal (85%)', 'Cuve #2 · Ocre Latérite (42%)', 'Cuve #3 · Vert Savane (92%)'];

    String? motifSelectionne;
    String? artisanSelectionne;
    String? cuveSelectionnee;
    final longueurController = TextEditingController(text: '4');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx2, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(ctx2).viewInsets.bottom + 24),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40, height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36, height: 36,
                                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.playlist_add, color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ATELIER J.COCO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.secondary, letterSpacing: 0.6)),
                                  Text('Nouveau Lot Batik', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary)),
                                ],
                              ),
                            ],
                          ),
                          IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('MOTIF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: motifSelectionne,
                        decoration: InputDecoration(
                          hintText: 'Choisir un motif batik...',
                          prefixIcon: const Icon(Icons.palette_outlined, size: 18),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: motifs.map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (v) => setModalState(() => motifSelectionne = v),
                        validator: (v) => v == null ? 'Sélectionnez un motif' : null,
                      ),
                      const SizedBox(height: 14),
                      const Text('LONGUEUR (YARDS)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: longueurController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.straighten, size: 18),
                                suffixText: 'yards',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              validator: (v) => (v == null || v.isEmpty) ? 'Requis' : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ...['4', '6', '8'].map((y) => GestureDetector(
                            onTap: () => setModalState(() => longueurController.text = y),
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: longueurController.text == y ? AppColors.secondary : AppColors.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('$y Y', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: longueurController.text == y ? Colors.white : AppColors.onSurfaceVariant)),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text('ARTISAN ASSIGNÉ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: artisanSelectionne,
                        decoration: InputDecoration(
                          hintText: 'Assigner un artisan...',
                          prefixIcon: const Icon(Icons.person_outline, size: 18),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: artisans.map((a) => DropdownMenuItem(value: a, child: Text(a, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (v) => setModalState(() => artisanSelectionne = v),
                        validator: (v) => v == null ? 'Assignez un artisan' : null,
                      ),
                      const SizedBox(height: 14),
                      const Text("CUVE D'IMMERSION", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: cuveSelectionnee,
                        decoration: InputDecoration(
                          hintText: 'Sélectionner la cuve...',
                          prefixIcon: const Icon(Icons.water_drop_outlined, size: 18),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: cuves.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)))).toList(),
                        onChanged: (v) => setModalState(() => cuveSelectionnee = v),
                        validator: (v) => v == null ? 'Choisissez une cuve' : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final motif = motifSelectionne!;
                              final longueur = longueurController.text;
                              final artisan = artisanSelectionne!;
                              Navigator.pop(ctx);
                              _state.setActiveTab(2);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('✅ Lot "$motif" ($longueur yards) lancé par $artisan !'),
                                  backgroundColor: AppColors.primary,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.rocket_launch, size: 18),
                          label: const Text('LANCER LA PRODUCTION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================
  // TICKET DE CAISSE NUMÉRIQUE
  // ==========================================
  void _showTicketCaisse(List<dynamic> panier, int total, String modePaiement) {
    final now = DateTime.now();
    final dateStr = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    final heureStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final modeLabel = modePaiement == 'especes' ? 'Espèces (Cash)' : modePaiement == 'wave' ? 'Wave / Orange Money' : 'Moov Money';
    final numRecu = 'JC-${now.millisecondsSinceEpoch.toString().substring(7)}';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (ctx2, scrollCtrl) {
            return SingleChildScrollView(
              controller: scrollCtrl,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
                child: Column(
                  children: [
                    Container(
                      width: 40, height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Reçu de Vente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primary)),
                          IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: Column(
                          children: [
                            // En-tête ticket (fond primary)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                              ),
                              child: Column(
                                children: [
                                  const Text('★ J.COCO ATELIER BATIK ★', style: TextStyle(color: AppColors.secondaryFixed, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.0)),
                                  const SizedBox(height: 2),
                                  const Text("Grand-Bassam, Côte d'Ivoire", style: TextStyle(color: Colors.white70, fontSize: 11)),
                                  const Text('Tél : +225 07 88 44 22 10', style: TextStyle(color: Colors.white60, fontSize: 10)),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('N° $numRecu', style: const TextStyle(color: AppColors.primaryFixedDim, fontSize: 10, fontWeight: FontWeight.bold)),
                                      Text('$dateStr  $heureStr', style: const TextStyle(color: AppColors.primaryFixedDim, fontSize: 10)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Découpe zigzag simulée
                            Row(
                              children: List.generate(20, (i) => Expanded(
                                child: Container(height: 6, color: i.isEven ? const Color(0xFFFFFBF4) : AppColors.primary),
                              )),
                            ),
                            // Corps du ticket
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('ARTICLES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8, color: AppColors.onSurfaceVariant)),
                                  const SizedBox(height: 8),
                                  const Divider(height: 1),
                                  const SizedBox(height: 8),
                                  ...panier.map((ligne) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 3, child: Text(ligne.piece.nom, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary), overflow: TextOverflow.ellipsis)),
                                        Expanded(flex: 1, child: Text('× ${ligne.quantite}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant))),
                                        Expanded(flex: 2, child: Text('${ligne.total} F', textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary))),
                                      ],
                                    ),
                                  )),
                                  const SizedBox(height: 8),
                                  const Divider(height: 1, color: Colors.black26),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('TOTAL PAYÉ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.primary)),
                                      Text('$total FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.secondary)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Mode de paiement', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                      Text(modeLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Center(child: Text('- - - - - - - - - - - - - - -', style: TextStyle(color: Colors.grey, letterSpacing: 2, fontSize: 10))),
                                  const SizedBox(height: 8),
                                  const Center(
                                    child: Text(
                                      'Merci pour votre confiance !\nArtisanat authentique de Grand-Bassam',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant, height: 1.5),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Center(
                                    child: Text('www.jcoco-batik.ci', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📲 Partage WhatsApp en cours...')));
                              },
                              icon: const Icon(Icons.share, size: 16),
                              label: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primary, width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () => Navigator.pop(ctx),
                              icon: const Icon(Icons.add_shopping_cart, size: 16, color: AppColors.primary),
                              label: const Text('Nouvelle Vente', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
