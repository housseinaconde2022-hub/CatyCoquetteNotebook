/// Caty AI Service - the cute bot that corrects writing mistakes
/// Currently a smart local corrector + ready for real API (OpenAI / xAI / Gemini)

class CatyAiService {
  // Simple French + English common typos dictionary (extendable)
  static final Map<String, String> _corrections = {
    // French
    'je suis': 'je suis',
    'j ai': "j'ai",
    'jai': "j'ai",
    'ca': 'ça',
    'cest': "c'est",
    'c est': "c'est",
    'etes': 'êtes',
    'etre': 'être',
    'meme': 'même',
    'tres': 'très',
    'a': 'à',
    'ou': 'où',
    'deja': 'déjà',
    'voila': 'voilà',
    'apres': 'après',
    'avant': 'avant',
    'parceque': 'parce que',
    'parce que': 'parce que',
    'quelquechose': 'quelque chose',
    'aujourdhui': "aujourd'hui",
    'maintenant': 'maintenant',
    // English
    'teh': 'the',
    'recieve': 'receive',
    'seperate': 'separate',
    'definately': 'definitely',
    'occured': 'occurred',
    'wich': 'which',
    'thier': 'their',
    'alot': 'a lot',
    'cant': "can't",
    'dont': "don't",
    'wont': "won't",
    'im': "I'm",
  };

  /// Correct text using local rules. Returns corrected text + list of changes.
  static Future<CatyCorrectionResult> correctText(String text) async {
    // Simulate thinking time for cute effect
    await Future.delayed(const Duration(milliseconds: 600));

    String corrected = text;
    List<String> changes = [];

    // Simple word-by-word + phrase replacement
    final words = text.split(RegExp(r'(\s+)'));
    final buffer = StringBuffer();

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final lower = word.toLowerCase().replaceAll(RegExp(r'[^a-zà-ÿ]'), '');

      if (_corrections.containsKey(lower)) {
        final fixed = _corrections[lower]!;
        // Preserve original case roughly
        final newWord = word.replaceAll(RegExp(r'[a-zA-Zà-ÿ]+'), fixed);
        if (newWord != word) {
          changes.add('"$word" → "$newWord"');
        }
        buffer.write(newWord);
      } else {
        buffer.write(word);
      }
    }

    corrected = buffer.toString();

    // Extra nice rules
    corrected = corrected
        .replaceAllMapped(RegExp(r'\bje suis\b', caseSensitive: false), (m) => 'je suis')
        .replaceAllMapped(RegExp(r"\bj'ai\b", caseSensitive: false), (m) => "j'ai")
        .replaceAllMapped(RegExp(r'\bc\'?est\b', caseSensitive: false), (m) => "c'est");

    return CatyCorrectionResult(
      original: text,
      corrected: corrected,
      changes: changes,
      message: changes.isEmpty
          ? "Tout est parfait ! ✨ Caty est fière de toi 🐱"
          : "Caty a trouvé ${changes.length} petite(s) correction(s) 🌸",
    );
  }

  /// Ready for real API later
  static Future<CatyCorrectionResult> correctWithApi(String text, {String? apiKey}) async {
    // Placeholder: just call local for now
    // Later you can add:
    // - OpenAI gpt-4o-mini
    // - xAI Grok API
    // - Google Gemini
    return correctText(text);
  }
}

class CatyCorrectionResult {
  final String original;
  final String corrected;
  final List<String> changes;
  final String message;

  CatyCorrectionResult({
    required this.original,
    required this.corrected,
    required this.changes,
    required this.message,
  });
}
