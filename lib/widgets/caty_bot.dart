import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/coquette_theme.dart';
import '../services/caty_ai_service.dart';

class CatyBot extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback? onCorrected;

  const CatyBot({
    super.key,
    required this.textController,
    this.onCorrected,
  });

  @override
  State<CatyBot> createState() => _CatyBotState();
}

class _CatyBotState extends State<CatyBot> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _isThinking = false;
  String? _lastMessage;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Future<void> _askCaty() async {
    final text = widget.textController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _lastMessage = "Écris quelque chose d'abord, mon cœur 💖";
        _isOpen = true;
      });
      return;
    }

    setState(() {
      _isThinking = true;
      _isOpen = true;
      _lastMessage = "Caty réfléchit... 🐱✨";
    });

    final result = await CatyAiService.correctText(text);

    setState(() {
      _isThinking = false;
      _lastMessage = result.message;
      if (result.corrected != result.original) {
        widget.textController.text = result.corrected;
        widget.onCorrected?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Chat bubble
        if (_isOpen)
          Positioned(
            bottom: 70,
            right: 0,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(20),
              color: CoquetteColors.ivory,
              child: Container(
                width: 240,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CoquetteColors.softPink, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text('🐱', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          'Caty',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            color: CoquetteColors.deepRose,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _isOpen = false),
                          child: const Icon(Icons.close, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastMessage ?? "Salut ! Je suis Caty, je peux corriger tes fautes 🌸",
                      style: GoogleFonts.quicksand(fontSize: 13, color: CoquetteColors.textDark),
                    ),
                    if (!_isThinking) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CoquetteColors.blushPink,
                            foregroundColor: CoquetteColors.deepRose,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: _askCaty,
                          child: Text(
                            'Corriger mon texte ✨',
                            style: GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

        // Floating Caty button
        ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.08).animate(
            CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
          ),
          child: FloatingActionButton(
            heroTag: 'caty',
            backgroundColor: CoquetteColors.blushPink,
            onPressed: () {
              if (_isOpen) {
                _askCaty();
              } else {
                setState(() => _isOpen = true);
              }
            },
            child: const Text('🐱', style: TextStyle(fontSize: 28)),
          ),
        ),
      ],
    );
  }
}
