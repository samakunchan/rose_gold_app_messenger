import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/legal/legal_section_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const new({super.key});

  static const String _publisherName = 'Papangue Soft';
  static const String _contactEmail = 'cedric.badjah@gmail.com';
  static const String _privacyFileName = 'privacy-policy.html';

  String _getPublicWebUrl() {
    final String baseUrl = dotenv.env['SUPABASE_APP_URL'] ?? 'http://localhost:8000';

    return '$baseUrl/functions/v1/public-pages/$_privacyFileName';
  }

  Future<void> _copyToClipboard(BuildContext context, String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    final String publicUrl = _getPublicWebUrl();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de confidentialité'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Copier le lien web public',
            icon: const Icon(Icons.link_outlined),
            onPressed: () => _copyToClipboard(
              context,
              publicUrl,
              'Lien public de la politique de confidentialité copié.',
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const .fromLTRB(16, 16, 16, 32),
        children: <Widget>[
          Padding(
            padding: const .only(bottom: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                Text(
                  'Rose Gold App Messenger',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: .w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Éditée par $_publisherName • Dernière mise à jour : 27 octobre 2026',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const LegalSectionCard(
            title: '1. Responsable du traitement & Contact',
            paragraphs: <String>[
              "L'application Rose Gold App Messenger est éditée par $_publisherName.",
              'Pour toute question relative à la protection de vos données personnelles ou pour exercer vos droits (RGPD), vous pouvez nous contacter à : $_contactEmail.',
            ],
          ),
          const LegalSectionCard(
            title: '2. Données collectées',
            paragraphs: <String>[
              'Nous appliquons le principe de minimisation des données et ne collectons que les informations strictement nécessaires au fonctionnement de la messagerie privée :',
            ],
            bulletPoints: <String>[
              'Compte & Profil : adresse e-mail, mot de passe chiffré (Supabase Auth), pseudonyme (username), identifiant unique de recherche (user_tag), photo de profil optionnelle (avatar_url), numéro de téléphone optionnel (phone) et clé publique de chiffrement (public_key).',
              'Salons privés & Invitations : salons créés ou rejoints, rôle au sein du salon (propriétaire, administrateur, membre) et statut des invitations envoyées ou reçues.',
              'Messages & Chiffrement : vos clés privées et jetons de session sont stockés exclusivement dans le trousseau sécurisé de votre appareil (Keychain iOS / Keystore Android).',
              "Modération & Sécurité : liste des utilisateurs bloqués et signalements d'abus transmis à des fins de sécurité (UGC Safety).",
              "Rapports de bugs volontaires : uniquement lorsque vous utilisez volontairement l'outil « Signaler un bug / Envoyer un retour » dans les paramètres (capture d'écran annotée, description, modèle de l'appareil, système d'exploitation et version de l'application).",
              "Préférences locales : choix du thème (clair/sombre/système), langue de l'interface et cache local sur votre appareil.",
            ],
          ),
          const LegalSectionCard(
            title: '3. Finalités du traitement & Absence de publicité',
            paragraphs: <String>[
              'Vos données sont traitées exclusivement pour :',
              "Engagement strict : $_publisherName ne vend, ne loue et ne partage aucune donnée personnelle à des courtiers de données ou à des régies publicitaires. L'application ne contient aucun traceur publicitaire tiers.",
            ],
            bulletPoints: <String>[
              "Assurer l'authentification, la création de salons privés et l'acheminement sécurisé de vos invitations et messages.",
              'Protéger les utilisateurs contre les comportements abusifs (blocage et signalement).',
              'Diagnostiquer et corriger les anomalies techniques que vous nous signalez volontairement.',
            ],
          ),
          const LegalSectionCard(
            title: '4. Hébergement & Sous-traitants techniques',
            paragraphs: <String>[
              'Les données nécessaires au fonctionnement du service sont hébergées de manière sécurisée auprès des sous-traitants techniques suivants :',
            ],
            bulletPoints: <String>[
              'Infrastructure Backend & Base de données : Supabase (PostgreSQL avec isolation stricte par Row Level Security et stockage sécurisé).',
              "Suivi technique des bugs : GitHub (uniquement pour les rapports de bugs envoyés volontairement par l'utilisateur).",
            ],
          ),
          const LegalSectionCard(
            title: '5. Conservation & Suppression des données',
            paragraphs: <String>[
              'Vos données sont conservées uniquement tant que votre compte demeure actif.',
              'Vous pouvez à tout moment supprimer votre compte directement depuis l’application via Paramètres → Supprimer mon compte. Cette action entraîne la suppression immédiate et définitive de votre profil et de vos accès associés.',
            ],
          ),
          const LegalSectionCard(
            title: '6. Vos droits (RGPD)',
            paragraphs: <String>[
              'Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez des droits suivants :',
            ],
            bulletPoints: <String>[
              "Droit d'accès et de rectification : modifiable directement dans Paramètres → Modifier le profil.",
              'Droit à la portabilité : via la fonctionnalité Exporter mes données dans les paramètres.',
              "Droit à l'effacement (droit à l'oubli) : directement via Paramètres → Supprimer mon compte ou par e-mail à $_contactEmail.",
            ],
          ),
          OutlinedButton.icon(
            onPressed: () => _copyToClipboard(
              context,
              _contactEmail,
              'Adresse e-mail $_contactEmail copiée.',
            ),
            icon: const Icon(Icons.email_outlined, size: 18),
            label: const Text('Copier le contact ($_contactEmail)'),
          ),
        ],
      ),
    );
  }
}
