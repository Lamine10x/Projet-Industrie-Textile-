import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'main_shell.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginTab = true;
  String _selectedRole = 'maitre'; // 'maitre' | 'artisan'
  String _pin = '';

  // Formulaire inscription
  final _nomController = TextEditingController();
  final _pinRegController = TextEditingController();
  final _pinConfirmController = TextEditingController();
  final _reponseSecuriteController = TextEditingController();
  String _specialiteReg = 'Cuves Indigo & Fermentation';

  void _onPressDigit(String digit) {
    if (_pin.length < 4) {
      setState(() {
        _pin += digit;
      });
      if (_pin.length == 4) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _showToast('Session validée', 'Authentification Maître Jean confirmée.');
          Future.delayed(const Duration(milliseconds: 900), _openApp);
        });
      }
    }
  }

  void _onClearPin() {
    setState(() {
      _pin = '';
    });
  }

  void _openApp() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }

  void _showToast(String title, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? AppColors.hibiscusAlert : const Color(0xFF7B290F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(
              isError ? Icons.warning_amber_rounded : Icons.check_circle_outline,
              color: AppColors.ocreGold,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegisterSubmit() {
    if (_nomController.text.trim().isEmpty) {
      _showToast('Champs requis', 'Veuillez saisir votre nom complet.', isError: true);
      return;
    }
    if (_pinRegController.text != _pinConfirmController.text || _pinRegController.text.length != 4) {
      _showToast('Erreur PIN', 'Les codes PIN à 4 chiffres ne correspondent pas.', isError: true);
      return;
    }

    _showToast(
      'Demande transmise',
      'Bienvenue ${_nomController.text} ! Votre profil a été transmis à Maître Jean pour validation.',
    );
    Future.delayed(const Duration(milliseconds: 1600), () {
      setState(() {
        _isLoginTab = true;
      });
    });
  }

  @override
  void dispose() {
    _nomController.dispose();
    _pinRegController.dispose();
    _pinConfirmController.dispose();
    _reponseSecuriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2ED),
      body: SafeArea(
        child: Column(
          children: [
            // Header Terracotta avec bascule et bouton retour
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB24822), AppColors.terracotta],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33B24822),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ligne supérieure avec Badge et Bouton Retour Inscription
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white.withOpacity(0.35)),
                            ),
                            child: const Center(
                              child: Text(
                                'JC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'J.COCO ATELIER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                'Manufacture Grand-Bassam',
                                style: TextStyle(
                                  color: Color(0xFFFFEAD9),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Bouton retour si sur inscription
                      if (!_isLoginTab)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLoginTab = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.22),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white.withOpacity(0.4)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_back, size: 12, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'Connexion',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _isLoginTab ? 'Connexion Maître & Artisan' : 'Inscription Nouvel Artisan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isLoginTab
                      ? 'Accédez à la gestion mobile des cuves, stocks et ventes.'
                      : 'Rejoignez l’équipe textile de Grand-Bassam.',
                    style: const TextStyle(
                      color: Color(0xFFFDE8DF),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Commutateur Onglets
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0x66501806),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isLoginTab = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: _isLoginTab ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: _isLoginTab
                                    ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_open,
                                    size: 13,
                                    color: _isLoginTab ? AppColors.terracotta : Colors.white70,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Connexion',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _isLoginTab ? AppColors.terracotta : Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isLoginTab = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: !_isLoginTab ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: !_isLoginTab
                                    ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_add_alt_1,
                                    size: 13,
                                    color: !_isLoginTab ? AppColors.terracotta : Colors.white70,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Inscription',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: !_isLoginTab ? AppColors.terracotta : Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Contenu du Formulaire Déroulant
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _isLoginTab ? _buildLoginForm() : _buildRegisterForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PROFIL D’ACCÈS À L’ATELIER',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: Color(0xFF555555),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedRole = 'maitre'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _selectedRole == 'maitre'
                        ? AppColors.terracotta.withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedRole == 'maitre'
                          ? AppColors.terracotta
                          : Colors.grey.shade300,
                      width: _selectedRole == 'maitre' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.terracotta,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.workspace_premium, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Maître Jean', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('Responsable', style: TextStyle(fontSize: 9, color: AppColors.terracotta, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedRole = 'artisan'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _selectedRole == 'artisan'
                        ? AppColors.indigo900.withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedRole == 'artisan'
                          ? AppColors.indigo900
                          : Colors.grey.shade300,
                      width: _selectedRole == 'artisan' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.indigo900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.brush, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Équipe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('Teinturiers', style: TextStyle(fontSize: 9, color: AppColors.indigo900, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Pavé PIN & Indicateur
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.key, size: 14, color: AppColors.terracotta),
                      SizedBox(width: 6),
                      Text(
                        'Code PIN Atelier (4 chiffres)',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    'Déverrouillage rapide',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Bulles d'indicateur PIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? AppColors.indigo900 : Colors.transparent,
                      border: Border.all(
                        color: isFilled ? AppColors.indigo900 : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 14),

              // Grille de touches
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 2.1,
                mainAxisSpacing: 6,
                crossAxisSpacing: 8,
                children: [
                  ...['1', '2', '3', '4', '5', '6', '7', '8', '9'].map(
                    (d) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F7F7),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      onPressed: () => _onPressDigit(d),
                      child: Text(d, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  // Empreinte biométrique
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ocre.withOpacity(0.12),
                      foregroundColor: AppColors.terracotta,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.ocre.withOpacity(0.3)),
                      ),
                    ),
                    onPressed: () {
                      _showToast('Biométrie validée', 'Empreinte digitale reconnue.');
                      Future.delayed(const Duration(milliseconds: 700), _openApp);
                    },
                    child: const Icon(Icons.fingerprint, size: 20),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7F7F7),
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    onPressed: () => _onPressDigit('0'),
                    child: const Text('0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F0F0),
                      foregroundColor: Colors.grey.shade700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _onClearPin,
                    child: const Icon(Icons.backspace_outlined, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.check_box, color: AppColors.terracotta, size: 16),
                SizedBox(width: 6),
                Text('Mémoriser cet appareil', style: TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
            GestureDetector(
              onTap: () => _showToast('Assistance code', 'Consultez Maître Jean à l’atelier.'),
              child: const Text(
                'Code oublié ?',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.terracotta),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.terracotta,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              _showToast('Ouverture atelier', 'Redirection vers le tableau de bord...');
              Future.delayed(const Duration(milliseconds: 700), _openApp);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, size: 16, color: AppColors.ocreGold),
                SizedBox(width: 8),
                Text('OUVRIR L’ATELIER MOBILE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: const Row(
            children: [
              Icon(Icons.verified_user_outlined, color: AppColors.terracotta, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Nouvel artisan ? Votre compte sera approuvé par Maître Jean avant l’accès complet.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF78350F)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _nomController,
          decoration: InputDecoration(
            labelText: 'Nom complet & Prénom',
            prefixIcon: const Icon(Icons.person_outline, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _specialiteReg,
          decoration: InputDecoration(
            labelText: 'Spécialité Atelier',
            prefixIcon: const Icon(Icons.work_outline, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
          items: const [
            DropdownMenuItem(value: 'Cuves Indigo & Fermentation', child: Text('Cuves Indigo & Fermentation')),
            DropdownMenuItem(value: 'Cire chaude & Tampons bois', child: Text('Cire chaude & Tampons bois')),
            DropdownMenuItem(value: 'Caisse & Boutique Grand-Bassam', child: Text('Caisse & Boutique Bassam')),
            DropdownMenuItem(value: 'Apprenti en formation', child: Text('Apprenti en formation')),
          ],
          onChanged: (val) {
            if (val != null) setState(() => _specialiteReg = val);
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _pinRegController,
                obscureText: true,
                maxLength: 4,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Code PIN (4)',
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _pinConfirmController,
                obscureText: true,
                maxLength: 4,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Confirmer PIN',
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _reponseSecuriteController,
          decoration: InputDecoration(
            labelText: 'Question secrète (ex: premier motif)',
            prefixIcon: const Icon(Icons.security, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.terracotta,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: _handleRegisterSubmit,
            child: const Text('CRÉER MON ACCÈS ARTISAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: TextButton.icon(
            onPressed: () => setState(() => _isLoginTab = true),
            icon: const Icon(Icons.arrow_back, size: 14, color: AppColors.terracotta),
            label: const Text(
              'Déjà membre de l’atelier ? Se connecter',
              style: TextStyle(color: AppColors.terracotta, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
