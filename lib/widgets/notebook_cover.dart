import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/notebook.dart';
import '../theme/coquette_theme.dart';

class NotebookCoverWidget extends StatelessWidget {
  final Notebook notebook;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const NotebookCoverWidget({
    super.key,
    required this.notebook,
    required this.onTap,
    this.onLongPress,
  });

  Color _parseColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(notebook.coverColor);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CoquetteColors.dustyRose.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
              ),
              child: Stack(
                children: [
                  // Pattern overlay
                  if (notebook.coverPattern == 'gingham')
                    CustomPaint(
                      painter: _GinghamPainter(),
                      size: Size.infinite,
                    ),
                  if (notebook.coverPattern == 'dots')
                    CustomPaint(
                      painter: _DotsPainter(),
                      size: Size.infinite,
                    ),
                  if (notebook.coverPattern == 'stripes')
                    CustomPaint(
                      painter: _StripesPainter(),
                      size: Size.infinite,
                    ),

                  // Label
                  Positioned(
                    top: 20,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        notebook.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: CoquetteColors.textDark,
                        ),
                      ),
                    ),
                  ),

                  // Cute character hint
                  if (notebook.character == 'mymelody')
                    const Positioned(
                      bottom: 12,
                      right: 10,
                      child: Text('🐰', style: TextStyle(fontSize: 28)),
                    ),

                  // Star
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.star_rounded, size: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            notebook.title,
            style: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: CoquetteColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Aujourd\'hui',
            style: GoogleFonts.quicksand(
              fontSize: 11,
              color: CoquetteColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _GinghamPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 1;
    const step = 12.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.35);
    const step = 14.0;
    for (double x = 6; x < size.width; x += step) {
      for (double y = 6; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 6;
    for (double y = 0; y < size.height; y += 14) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
