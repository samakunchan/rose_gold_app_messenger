class EmojiData {
  const new({
    required this.emoji,
    required this.name,
    required this.shortcode,
    required this.keywords,
  });

  final String emoji;
  final String name;
  final String shortcode;
  final List<String> keywords;

  static const List<EmojiData> catalog = <EmojiData>[
    EmojiData(
      emoji: '❤️',
      name: 'Coeur rouge',
      shortcode: 'heart',
      keywords: <String>['coeur', 'love', 'amour', 'heart'],
    ),
    EmojiData(
      emoji: '👍',
      name: 'Pouce vers le haut',
      shortcode: '+1',
      keywords: <String>['pouce', 'ok', 'yes', 'super', 'cool', 'like'],
    ),
    EmojiData(
      emoji: '😂',
      name: 'Visage qui rit aux larmes',
      shortcode: 'joy',
      keywords: <String>['rire', 'mdr', 'lol', 'larmes', 'drole'],
    ),
    EmojiData(
      emoji: '😮',
      name: 'Visage bouche bée',
      shortcode: 'open_mouth',
      keywords: <String>['surprise', 'choc', 'ouah', 'wow'],
    ),
    EmojiData(
      emoji: '😢',
      name: 'Visage qui pleure',
      shortcode: 'cry',
      keywords: <String>['triste', 'pleur', 'larme', 'sad'],
    ),
    EmojiData(
      emoji: '🔥',
      name: 'Feu',
      shortcode: 'fire',
      keywords: <String>['feu', 'flamme', 'chaud', 'hot', 'lit'],
    ),
    EmojiData(
      emoji: '🎉',
      name: 'Cotillons',
      shortcode: 'tada',
      keywords: <String>['fete', 'bravo', 'party', 'celebration'],
    ),
    EmojiData(
      emoji: '👏',
      name: 'Applaudissements',
      shortcode: 'clap',
      keywords: <String>['bravo', 'applaudir', 'clap'],
    ),
    EmojiData(
      emoji: '🙏',
      name: 'Mains jointes',
      shortcode: 'pray',
      keywords: <String>['merci', 'priere', 'svp', 'svp', 'please', 'thanks'],
    ),
    EmojiData(
      emoji: '💯',
      name: '100 points',
      shortcode: '100',
      keywords: <String>['cent', 'parfait', 'top', 'score'],
    ),
    EmojiData(
      emoji: '😍',
      name: 'Yeux en coeur',
      shortcode: 'heart_eyes',
      keywords: <String>['love', 'amour', 'craque', 'fan'],
    ),
    EmojiData(
      emoji: '🥰',
      name: 'Visage souriant avec coeurs',
      shortcode: 'smiling_face_with_3_hearts',
      keywords: <String>['amour', 'mignon', 'affection'],
    ),
    EmojiData(
      emoji: '😘',
      name: 'Bisou',
      shortcode: 'kissing_heart',
      keywords: <String>['bisou', 'bise', 'kiss'],
    ),
    EmojiData(
      emoji: '🤩',
      name: 'Yeux étoiles',
      shortcode: 'star_struck',
      keywords: <String>['etoile', 'magique', 'fan', 'incroyable'],
    ),
    EmojiData(
      emoji: '🥳',
      name: 'Visage festif',
      shortcode: 'partying_face',
      keywords: <String>['fete', 'anniversaire', 'soiree'],
    ),
    EmojiData(
      emoji: '😎',
      name: 'Visage avec lunettes',
      shortcode: 'sunglasses',
      keywords: <String>['cool', 'lunettes', 'soleil', 'swag'],
    ),
    EmojiData(
      emoji: '🤔',
      name: 'Visage pensif',
      shortcode: 'thinking',
      keywords: <String>['penser', 'reflexion', 'doute', 'hmm'],
    ),
    EmojiData(
      emoji: '🤫',
      name: 'Visage avec doigt sur la bouche',
      shortcode: 'shushing_face',
      keywords: <String>['secret', 'silence', 'chut'],
    ),
    EmojiData(
      emoji: '🙄',
      name: 'Yeux au ciel',
      shortcode: 'roll_eyes',
      keywords: <String>['agace', 'bof', 'yeux'],
    ),
    EmojiData(
      emoji: '😴',
      name: 'Visage qui dort',
      shortcode: 'sleeping',
      keywords: <String>['dodo', 'fatigue', 'nuit', 'sleep'],
    ),
    EmojiData(
      emoji: '🤯',
      name: 'Tête qui explose',
      shortcode: 'exploding_head',
      keywords: <String>['choc', 'ouf', 'mindblown'],
    ),
    EmojiData(
      emoji: '😱',
      name: 'Visage qui crie de peur',
      shortcode: 'scream',
      keywords: <String>['peur', 'effroi', 'cri'],
    ),
    EmojiData(
      emoji: '😡',
      name: 'Visage en colère',
      shortcode: 'rage',
      keywords: <String>['colere', 'enerve', 'fache', 'angry'],
    ),
    EmojiData(
      emoji: '💩',
      name: 'Crotte souriante',
      shortcode: 'poop',
      keywords: <String>['crotte', 'caca', 'poop'],
    ),
    EmojiData(
      emoji: '👻',
      name: 'Fantôme',
      shortcode: 'ghost',
      keywords: <String>['fantome', 'ghost', 'halloween'],
    ),
    EmojiData(
      emoji: '💀',
      name: 'Crâne',
      shortcode: 'skull',
      keywords: <String>['mort', 'crane', 'dead'],
    ),
    EmojiData(
      emoji: '👀',
      name: 'Yeux',
      shortcode: 'eyes',
      keywords: <String>['regard', 'yeux', 'look', 'voir'],
    ),
    EmojiData(
      emoji: '🚀',
      name: 'Fusée',
      shortcode: 'rocket',
      keywords: <String>['fusee', 'espace', 'decollage', 'fast', 'moon'],
    ),
    EmojiData(
      emoji: '✨',
      name: 'Étincelles',
      shortcode: 'sparkles',
      keywords: <String>['etoile', 'magie', 'brillant', 'clean'],
    ),
    EmojiData(
      emoji: '🤝',
      name: 'Poignée de main',
      shortcode: 'handshake',
      keywords: <String>['accord', 'deal', 'bienvenue', 'partenaire'],
    ),
  ];

  static const Map<String, String> emoticons = <String, String>{
    '<3': '❤️',
    ':)': '😊',
    ':-)': '😊',
    '(:': '😊',
    ':D': '😃',
    ':-D': '😃',
    ';)': '😉',
    ';-)': '😉',
    ':P': '😋',
    ':-P': '😋',
    ':p': '😋',
    ':-p': '😋',
    ':(': '🙁',
    ':-(': '🙁',
    ":'(": '😢',
    ":'-(": '😢',
    ":'‑(": '😢',
    ':O': '😮',
    ':-O': '😮',
    ':o': '😮',
    ':-o': '😮',
    ':|': '😐',
    ':-|': '😐',
    ':/': '😕',
    ':-/': '😕',
    r':\': '😕',
    r':-\': '😕',
    '>:(': '😡',
    '>:-(': '😡',
    'B)': '😎',
    'B-)': '😎',
  };

  static String convertEmoticons(String text) {
    if (text.isEmpty) {
      return text;
    }

    String result = text;
    // Trier par longueur décroissante pour matcher les variantes plus longues d'abord (ex: ':-D' avant ':D')
    final List<String> sortedKeys = emoticons.keys.toList()..sort((String a, String b) => b.length.compareTo(a.length));

    for (final String token in sortedKeys) {
      final String emoji = emoticons[token]!;
      // Remplacement en s'assurant que l'émoticône est soit au début/fin de chaîne soit délimité par des espaces
      final String escaped = RegExp.escape(token);
      final RegExp pattern = RegExp('(?<=^|\\s)$escaped(?=\$|\\s)');
      result = result.replaceAllMapped(pattern, (Match m) => emoji);
    }

    return result;
  }

  /// Détecte les séquences de caractères emoji Unicode (y compris modifiers de couleur, zwj, etc.)
  static final RegExp emojiRegex = RegExp(
    r'(?:\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]|\uD83D[\uDE80-\uDEFF]|\uD83E[\uDD00-\uDDFF]|[\u2600-\u26FF]|[\u2700-\u27BF]|[\uFE00-\uFE0F]|\u200D)+',
  );

  /// Vérifie si une chaîne est composée exclusivement d'emojis (et d'espaces éventuels)
  static bool isOnlyEmojis(String text) {
    final String trimmed = text.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    final String withoutEmojis = trimmed.replaceAll(emojiRegex, '').replaceAll(RegExp(r'\s+'), '');
    return withoutEmojis.isEmpty;
  }

  /// Compte le nombre d'occurrences d'emojis dans un texte
  static int countEmojis(String text) {
    return emojiRegex.allMatches(text).length;
  }

  static List<EmojiData> search(String query) {
    final String clean = query.trim().toLowerCase().replaceAll(RegExp(r'^:'), '');
    if (clean.isEmpty) {
      return catalog.take(8).toList();
    }
    return catalog.where((EmojiData item) {
      return item.shortcode.toLowerCase().contains(clean) ||
          item.name.toLowerCase().contains(clean) ||
          item.keywords.any((String k) => k.toLowerCase().contains(clean));
    }).toList();
  }
}
