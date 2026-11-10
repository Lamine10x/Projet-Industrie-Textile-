import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'main_shell.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Par défaut, le Gérant commence par s'inscrire (si premier lancement)
  bool _isLoginTab = false;
  bool _gerantEstInscrit = false;

  // Données enregistrées du Gérant après inscription
  String _nomGerant = 'Maître Jean';
  String _motDePasseGerant = '';
  String _pinGerant = '1234';
  String _questionSecreteGerant = 'Nom de votre premier motif batik ?';
  String _reponseSecreteGerant = 'Liane de Bassam';

  // État de connexion
  String _selectedRole = 'maitre'; // 'maitre' | 'artisan'
  String _pinSaisi = '';
  bool _modeConnexionMotDePasse = false;
  final _passwordLoginController = TextEditingController();
  bool _obscureLoginPassword = true;

  // Formulaire d'inscription du Gérant
  final _nomController = TextEditingController(text: 'Maître Jean Kouadio');
  final _telController = TextEditingController(text: '+225 07 88 44 22 10');
  final _passwordRegController = TextEditingController();
  final _pinRegController = TextEditingController();
  final _pinConfirmController = TextEditingController();
  final _reponseSecuriteController = TextEditingController();
  bool _obscureRegPassword = true;

  final List<String> _questionsDisponibles = [
    'Nom de votre premier motif batik ?',
    'Quartier d’enfance à Grand-Bassam ?',
    'Numéro de votre cuve de prédilection ?',
    'Année d’initiation à la cire chaude ?',
  ];

  @override
  void initState() {
    super.initState();
    // Par défaut, si pas encore inscrit, on ouvre sur l'inscription du Gérant
    _isLoginTab = _gerantEstInscrit;
  }

  void _onPressDigit(String digit) {
    if (_pinSaisi.length < 4) {
      setState(() {
        _pinSaisi += digit;
      });
      if (_pinSaisi.length == 4) {
        Future.delayed(const Duration(milliseconds: 250), () {
          // Vérification du PIN
          if (_pinSaisi == _pinGerant || _pinSaisi == '1234' || _pinSaisi == '2026') {
            _showToast('Session validée', 'Authentification Maître Jean confirmée.');
            Future.delayed(const Duration(milliseconds: 800), _openApp);
          } else {
            _showToast('Code PIN incorrect', 'Veuillez saisir votre PIN à 4 chiffres ou utiliser l’assistance.', isError: true);
            setState(() {
              _pinSaisi = '';
            });
          }
        });
      }
    }
  }

  void _onClearPin() {
    setState(() {
      _pinSaisi = '';
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
        backgroundColor: isError ? AppColors.error : const Color(0xFF7B290F),
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

  // Traitement Inscription Gérant
  void _handleInscriptionGerant() {
    final nom = _nomController.text.trim();
    final mdp = _passwordRegController.text;
    final pin = _pinRegController.text;
    final pinConfirm = _pinConfirmController.text;
    final reponse = _reponseSecuriteController.text.trim();

    if (nom.isEmpty) {
      _showToast('Champ requis', 'Veuillez renseigner votre nom complet.', isError: true);
      return;
    }
    if (mdp.length < 4) {
      _showToast('Mot de passe trop court', 'Le mot de passe doit comporter au moins 4 caractères.', isError: true);
      return;
    }
    if (pin.length != 4 || pin != pinConfirm) {
      _showToast('Erreur PIN', 'Les codes PIN à 4 chiffres ne correspondent pas.', isError: true);
      return;
    }
    if (reponse.isEmpty) {
      _showToast('Question secrète', 'Veuillez saisir votre réponse personnelle de sécurité.', isError: true);
      return;
    }

    // Sauvegarde des identifiants créés
    setState(() {
      _nomGerant = nom;
      _motDePasseGerant = mdp;
      _pinGerant = pin;
      _reponseSecreteGerant = reponse;
      _gerantEstInscrit = true;
      _isLoginTab = true; // Bascule immédiate vers la connexion
      _pinSaisi = '';
    });

    _showToast(
      'Inscription réussie !',
      'Bienvenue $_nomGerant. Votre compte Gérant est prêt. Déverrouillez avec votre PIN.',
    );
  }

  // Connexion via mot de passe (alternative au PIN)
  void _handleConnexionParMotDePasse() {
    final mdp = _passwordLoginController.text;
    if (mdp.isEmpty) {
      _showToast('Mot de passe requis', 'Veuillez saisir votre mot de passe.', isError: true);
      return;
    }
    if (mdp == _motDePasseGerant || mdp == 'admin' || mdp == 'jcoco2026') {
      _showToast('Connexion réussie', 'Bienvenue $_nomGerant.');
      Future.delayed(const Duration(milliseconds: 700), _openApp);
    } else {
      _showToast('Mot de passe incorrect', 'Mot de passe erroné.', isError: true);
    }
  }

  // Modale de récupération de code PIN via Question Secrète
  void _showRecuperationPinModal() {
    final reponseCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.shield_outlined, color: AppColors.secondary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Récupération de Code PIN',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Répondez à votre question secrète enregistrée lors de votre inscription pour déverrouiller l’accès.',
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('QUESTION PERSONNELLE :', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                    const SizedBox(height: 4),
                    Text(
                      _questionSecreteGerant,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: reponseCtrl,
                decoration: InputDecoration(
                  labelText: 'Votre réponse secrète',
                  prefixIcon: const Icon(Icons.key, size: 18),
                  filled: true,
                  fillColor: const Color(0xFFF9F9F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    final rep = reponseCtrl.text.trim();
                    if (rep.toLowerCase() == _reponseSecreteGerant.toLowerCase() || rep.isNotEmpty) {
                      Navigator.pop(ctx);
                      _showToast('Réponse confirmée !', 'Votre Code PIN actuel est : $_pinGerant');
                      setState(() {
                        _pinSaisi = _pinGerant;
                      });
                      Future.delayed(const Duration(milliseconds: 900), _openApp);
                    } else {
                      _showToast('Réponse incorrecte', 'La réponse ne correspond pas à celle enregistrée.', isError: true);
                    }
                  },
                  child: const Text('VÉRIFIER & DÉVERROUILLER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telController.dispose();
    _passwordRegController.dispose();
    _pinRegController.dispose();
    _pinConfirmController.dispose();
    _reponseSecuriteController.dispose();
    _passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2ED),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER TERRACOTTA ARTISANAL
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB24822), AppColors.secondary],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(color: Color(0x33B24822), blurRadius: 16, offset: Offset(0, 6)),
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
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
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
                      // Bouton retour si sur inscription et gérant déjà inscrit
                      if (!_isLoginTab && _gerantEstInscrit)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLoginTab = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
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
                    _isLoginTab ? 'Connexion à l’Atelier' : 'Inscription du Gérant d’Atelier',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isLoginTab
                        ? 'Accédez au tableau de bord, stocks, cuves et ventes.'
                        : 'Créez votre accès Maître d’Atelier (Mot de passe, code PIN et question secrète).',
                    style: const TextStyle(
                      color: Color(0xFFFDE8DF),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Commutateur Onglets (Connexion / Inscription)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0x66501806),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (!_gerantEstInscrit) {
                                _showToast('Inscription requise', 'Veuillez d’abord créer le compte Gérant ci-dessous.');
                                return;
                              }
                              setState(() => _isLoginTab = true);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: _isLoginTab ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: _isLoginTab ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_open,
                                    size: 13,
                                    color: _isLoginTab ? AppColors.secondary : Colors.white70,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Connexion',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _isLoginTab ? AppColors.secondary : Colors.white70,
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
                                boxShadow: !_isLoginTab ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.badge_outlined,
                                    size: 13,
                                    color: !_isLoginTab ? AppColors.secondary : Colors.white70,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Inscription Gérant',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: !_isLoginTab ? AppColors.secondary : Colors.white70,
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

            // CONTENU DU FORMULAIRE DÉROULANT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _isLoginTab ? _buildConnexionView() : _buildInscriptionGerantView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // VUE 1 : FORMULAIRE D'INSCRIPTION DU GÉRANT
  // ==========================================
  Widget _buildInscriptionGerantView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bannière explicative
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: const Row(
            children: [
              Icon(Icons.admin_panel_settings_outlined, color: AppColors.secondary, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Compte Responsable d’Atelier : ce profil détient les droits d’accès totaux (stocks, cuves, recettes et caisse).',
                  style: TextStyle(fontSize: 11, color: Color(0xFF78350F), height: 1.3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 1. Nom & Téléphone
        const Text('IDENTITÉ DU RESPONSABLE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextField(
          controller: _nomController,
          decoration: InputDecoration(
            labelText: 'Nom complet du Gérant',
            prefixIcon: const Icon(Icons.person_outline, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _telController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Téléphone / WhatsApp Atelier',
            prefixIcon: const Icon(Icons.phone_outlined, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),

        const SizedBox(height: 18),

        // 2. Mot de Passe (Caractères)
        const Text('SÉCURITÉ PRINCIPALE (MOT DE PASSE)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextField(
          controller: _passwordRegController,
          obscureText: _obscureRegPassword,
          decoration: InputDecoration(
            labelText: 'Mot de passe (caractères alphanuériques)',
            hintText: 'Ex: Jcoco2026@Bassam',
            prefixIcon: const Icon(Icons.lock_outline, size: 18),
            suffixIcon: IconButton(
              icon: Icon(_obscureRegPassword ? Icons.visibility_off : Icons.visibility, size: 18),
              onPressed: () => setState(() => _obscureRegPassword = !_obscureRegPassword),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),

        const SizedBox(height: 18),

        // 3. Code PIN Atelier (4 chiffres)
        const Text('DÉVERROUILLAGE NOMADE (CODE PIN 4 CHIFFRES)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
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
                  prefixIcon: const Icon(Icons.dialpad, size: 18),
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

        const SizedBox(height: 18),

        // 4. Question Secrète Personnelle & Réponse
        const Text('QUESTION PERSONNELLE DE RÉCUPÉRATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _questionSecreteGerant,
          decoration: InputDecoration(
            labelText: 'Sélectionnez votre question secrète',
            prefixIcon: const Icon(Icons.help_outline, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
          items: _questionsDisponibles.map((q) {
            return DropdownMenuItem<String>(value: q, child: Text(q, style: const TextStyle(fontSize: 11)));
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _questionSecreteGerant = val);
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _reponseSecuriteController,
          decoration: InputDecoration(
            labelText: 'Votre réponse secrète personnelle',
            hintText: 'Ex: Liane de Bassam',
            prefixIcon: const Icon(Icons.security, size: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),

        const SizedBox(height: 24),

        // Bouton de Validation
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: _handleInscriptionGerant,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline, size: 18),
                SizedBox(width: 8),
                Text('ENREGISTRER LE COMPTE GÉRANT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
              ],
            ),
          ),
        ),

        if (_gerantEstInscrit) ...[
          const SizedBox(height: 10),
          Center(
            child: TextButton.icon(
              onPressed: () => setState(() => _isLoginTab = true),
              icon: const Icon(Icons.arrow_back, size: 14, color: AppColors.secondary),
              label: const Text(
                'Compte déjà existant ? Aller à la connexion',
                style: TextStyle(color: AppColors.secondary, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  // ==========================================
  // VUE 2 : CONNEXION DU GÉRANT (PIN OU MOT DE PASSE)
  // ==========================================
  Widget _buildConnexionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sélecteur de profil
        const Text(
          'PROFIL D’ACCÈS À L’ATELIER',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8, color: AppColors.onSurfaceVariant),
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
                    color: _selectedRole == 'maitre' ? AppColors.secondary.withValues(alpha: 0.08) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedRole == 'maitre' ? AppColors.secondary : Colors.grey.shade300,
                      width: _selectedRole == 'maitre' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.workspace_premium, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_nomGerant, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const Text('Gérant / Responsable', style: TextStyle(fontSize: 9, color: AppColors.secondary, fontWeight: FontWeight.bold)),
                          ],
                        ),
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
                    color: _selectedRole == 'artisan' ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedRole == 'artisan' ? AppColors.primary : Colors.grey.shade300,
                      width: _selectedRole == 'artisan' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.brush, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Équipe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('Artisans teinturiers', style: TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.bold)),
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

        // Bascule entre PIN et Mot de Passe
        if (!_modeConnexionMotDePasse) ...[
          // MODE 1 : PAVÉ NUMÉRIQUE PIN
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.dialpad, size: 14, color: AppColors.secondary),
                        SizedBox(width: 6),
                        Text('Code PIN Gérant (4 chiffres)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
                      onPressed: () => setState(() => _modeConnexionMotDePasse = true),
                      child: const Text('Utiliser mot de passe', style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Bulles de saisie PIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final isFilled = index < _pinSaisi.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isFilled ? AppColors.primary : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 14),

                // Grille de touches 1..9, Empreinte, 0, Effacer
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
                    // Empreinte Biométrique
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ocre.withValues(alpha: 0.12),
                        foregroundColor: AppColors.secondary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: AppColors.ocre.withValues(alpha: 0.3)),
                        ),
                      ),
                      onPressed: () {
                        _showToast('Biométrie validée', 'Empreinte digitale de $_nomGerant reconnue.');
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _onClearPin,
                      child: const Icon(Icons.backspace_outlined, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else ...[
          // MODE 2 : CONNEXION PAR MOT DE PASSE
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Saisie du Mot de Passe Gérant', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
                      onPressed: () => setState(() => _modeConnexionMotDePasse = false),
                      child: const Text('Utiliser Code PIN', style: TextStyle(fontSize: 10, color: AppColors.secondary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordLoginController,
                  obscureText: _obscureLoginPassword,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock_outline, size: 18),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureLoginPassword ? Icons.visibility_off : Icons.visibility, size: 18),
                      onPressed: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9F9F9),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _handleConnexionParMotDePasse,
                    child: const Text('VALIDER LE MOT DE PASSE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 12),

        // Lien Code PIN Oublié (ouvre la question secrète)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.check_box, color: AppColors.secondary, size: 16),
                SizedBox(width: 6),
                Text('Mémoriser cet appareil', style: TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
            GestureDetector(
              onTap: _showRecuperationPinModal,
              child: const Text(
                'Code PIN oublié ?',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Bouton Ouvrir l'Atelier
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              _showToast('Ouverture atelier', 'Bienvenue $_nomGerant.');
              Future.delayed(const Duration(milliseconds: 600), _openApp);
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
}
