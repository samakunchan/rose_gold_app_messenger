import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/legal/legal_section_card.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const new({super.key});

  static const String _publisherName = 'Papangue Soft';
  static const String _contactEmail = 'cedric.badjah@gmail.com';
  static const String _termsFileName = 'terms-of-service.html';

  String _getPublicWebUrl() {
    final String baseUrl = dotenv.env['SUPABASE_APP_URL'] ?? 'http://localhost:8000';

    return '$baseUrl/functions/v1/public-pages/$_termsFileName';
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
        title: const Text('Conditions Générales d’Utilisation'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Copier le lien web public',
            icon: const Icon(Icons.link_outlined),
            onPressed: () => _copyToClipboard(
              context,
              publicUrl,
              'Lien public des CGU copié.',
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
            title: '1. Objet & Acceptation',
            paragraphs: <String>[
              "Les présentes Conditions Générales d'Utilisation (CGU) encadrent l'accès et l'utilisation de l'application mobile de messagerie privée Rose Gold App Messenger, éditée par $_publisherName.",
              "En créant un compte ou en utilisant l'application, vous reconnaissez avoir lu, compris et accepté sans réserve les présentes CGU.",
            ],
          ),
          const LegalSectionCard(
            title: '2. Création de compte & Sécurité',
            paragraphs: <String>[
              "L'accès aux fonctionnalités de messagerie privée nécessite la création d'un compte personnel :",
            ],
            bulletPoints: <String>[
              'Vous vous engagez à fournir des informations exactes lors de votre inscription et à maintenir votre profil à jour.',
              'Vous êtes seul responsable de la confidentialité de vos identifiants de connexion et de toutes les actions réalisées depuis votre compte.',
              "En cas d'utilisation non autorisée de votre compte, vous devez immédiatement modifier votre mot de passe ou nous contacter à $_contactEmail.",
            ],
          ),
          const LegalSectionCard(
            title: '3. Code de conduite & Tolérance zéro (Contenus Utilisateurs)',
            paragraphs: <String>[
              "$_publisherName applique une politique de tolérance zéro envers les contenus illicites et les comportements abusifs. En utilisant Rose Gold App Messenger, vous vous interdisez formellement de :",
            ],
            bulletPoints: <String>[
              "Harceler, menacer, intimider ou diffamer d'autres utilisateurs via des invitations ou au sein des salons privés.",
              'Diffuser des contenus haineux, discriminatoires, violents, pornographiques ou contraires aux lois en vigueur.',
              'Envoyer des invitations non sollicitées de manière répétée (spam), du phishing ou des logiciels malveillants.',
              "Usurper l'identité d'un tiers ou tenter de contourner les mécanismes de sécurité et d'isolation des salons.",
            ],
          ),
          const LegalSectionCard(
            title: '4. Modération, Blocage & Signalement',
            paragraphs: <String>[
              'Afin de garantir un environnement sûr et respectueux :',
            ],
            bulletPoints: <String>[
              "Chaque utilisateur dispose d'outils intégrés permettant de bloquer immédiatement un utilisateur et de signaler toute invitation ou comportement abusif.",
              'Vous pouvez consulter et gérer la liste des comptes bloqués à tout moment depuis Paramètres → Utilisateurs bloqués.',
              "Sanctions : En cas de violation des présentes CGU ou de signalements avérés, $_publisherName se réserve le droit de suspendre ou de supprimer définitivement le compte contrevenant, sans préavis ni indemnité.",
            ],
          ),
          const LegalSectionCard(
            title: '5. Propriété intellectuelle & Responsabilité',
            paragraphs: <String>[
              "L'application Rose Gold App Messenger, son architecture, son code source, sa charte graphique et ses marques sont la propriété exclusive de $_publisherName.",
              "Chaque utilisateur demeure seul propriétaire et responsable des messages et contenus qu'il échange dans ses salons privés. $_publisherName s'efforce d'assurer la disponibilité du service mais ne saurait être tenue responsable des interruptions liées à la maintenance ou aux réseaux de télécommunications.",
            ],
          ),
          const LegalSectionCard(
            title: '6. Résiliation & Contact',
            paragraphs: <String>[
              "Vous pouvez mettre fin à l'utilisation du service à tout moment en supprimant votre compte directement depuis Paramètres → Supprimer mon compte.",
              'Pour toute question relative aux présentes CGU ou pour signaler un abus, contactez-nous à : $_contactEmail.',
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
