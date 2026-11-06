import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/coquette_theme.dart';
import '../widgets/caty_bot.dart';

class PageEditorScreen extends StatefulWidget {
  final String notebookId;
  final String pageTitle;

  const PageEditorScreen({
    super.key,
    required this.notebookId,
    required this.pageTitle,
  });

  @override
  State<PageEditorScreen> createState() => _PageEditorScreenState();
}

class _PageEditorScreenState extends State<PageEditorScreen> {
  final TextEditingController _controller = TextEditingController();
  String _pageType = 'lined'; // lined, grid, blank

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoquetteColors.ivory,
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: GoogleFonts.pinyonScript(fontSize: 26, color: CoquetteColors.deepRose),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.grid_on_rounded),
            onSelected: (v) => setState(() => _pageType = v),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'lined', child: Text('Lignée')),
              const PopupMenuItem(value: 'grid', child: Text('Quadrillée')),
              const PopupMenuItem(value: 'blank', child: Text('Vierge')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.save_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sauvegardé ✨', style: GoogleFonts.quicksand()),
                  backgroundColor: CoquetteColors.blushPink,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Paper background with lines/grid
          CustomPaint(
            painter: _PaperPainter(type: _pageType),
            size: Size.infinite,
          ),
          // Text editor
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                height: 1.8,
                color: CoquetteColors.textDark,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Écris ici ton joli texte...',
                hintStyle: TextStyle(color: Colors.black26),
              ),
              cursorColor: CoquetteColors.deepRose,
            ),
          ),
          // Caty bot
          Positioned(
            bottom: 20,
            right: 20,
            child: CatyBot(
              textController: _controller,
              onCorrected: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Caty a corrigé ton texte 🐱✨', style: GoogleFonts.quicksand()),
                    backgroundColor: CoquetteColors.roseGold,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PaperPainter extends CustomPainter {
  final String type;
  _PaperPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CoquetteColors.softPink.withOpacity(0.35)
      ..strokeWidth = 1;

    if (type == 'lined') {
      const lineHeight = 28.0;
      for (double y = 40; y < size.height; y += lineHeight) {
        canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), paint);
      }
      // Margin line
      final marginPaint = Paint()
        ..color = CoquetteColors.blushPink.withOpacity(0.4)
        ..strokeWidth = 1.5;
      canvas.drawLine(const Offset(48, 0), Offset(48, size.height), marginPaint);
    } else if (type == 'grid') {
      const step = 24.0;
      for (double x = 20; x < size.width - 20; x += step) {
        canvas.drawLine(Offset(x, 20), Offset(x, size.height - 20), paint);
      }
      for (double y = 20; y < size.height - 20; y += step) {
        canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PaperPainter oldDelegate) => oldDelegate.type != type;
}
