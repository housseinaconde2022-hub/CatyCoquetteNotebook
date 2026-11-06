import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/coquette_theme.dart';
import '../services/storage_service.dart';

class CoverPickerScreen extends StatefulWidget {
  final String notebookId;

  const CoverPickerScreen({super.key, required this.notebookId});

  @override
  State<CoverPickerScreen> createState() => _CoverPickerScreenState();
}

class _CoverPickerScreenState extends State<CoverPickerScreen> {
  late String selectedColor;
  late String selectedPattern;
  String? selectedCharacter;

  final List<String> colors = [
    '#FADADD', // baby pink
    '#F7C6CE', // blush
    '#F8D7DE', // soft
    '#FFF8E8', // cream
    '#E8B4B8', // rose gold
    '#D4A5A5', // dusty rose
    '#FFB6C1', // light pink
    '#FFE4E1', // misty rose
  ];

  final List<String> patterns = ['solid', 'gingham', 'dots', 'stripes', 'lace'];

  @override
  void initState() {
    super.initState();
    final nb = context.read<StorageService>().getNotebook(widget.notebookId);
    selectedColor = nb?.coverColor ?? '#FADADD';
    selectedPattern = nb?.coverPattern ?? 'solid';
    selectedCharacter = nb?.character;
  }

  Color _parse(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoquetteColors.cream,
      appBar: AppBar(
        title: Text(
          'Changer la couverture 🎀',
          style: GoogleFonts.pinyonScript(fontSize: 26, color: CoquetteColors.deepRose),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Preview
          Center(
            child: Container(
              width: 160,
              height: 220,
              decoration: BoxDecoration(
                color: _parse(selectedColor),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: CoquetteColors.dustyRose.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Center(
                child: Text(
                  'Aperçu',
                  style: GoogleFonts.pinyonScript(
                    fontSize: 28,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text('Couleur', style: GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((c) {
              final isSelected = selectedColor == c;
              return GestureDetector(
                onTap: () => setState(() => selectedColor = c),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _parse(c),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? CoquetteColors.deepRose : Colors.white,
                      width: isSelected ? 3 : 2,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: CoquetteColors.deepRose.withOpacity(0.4),
                          blurRadius: 8,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),
          Text('Motif', style: GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: patterns.map((p) {
              final isSelected = selectedPattern == p;
              return ChoiceChip(
                label: Text(p),
                selected: isSelected,
                selectedColor: CoquetteColors.blushPink,
                onSelected: (_) => setState(() => selectedPattern = p),
                labelStyle: GoogleFonts.quicksand(
                  color: isSelected ? CoquetteColors.deepRose : CoquetteColors.textDark,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),
          Text('Personnage (optionnel)', style: GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              _CharChip(emoji: '🐰', label: 'My Melody', value: 'mymelody', selected: selectedCharacter, onTap: (v) => setState(() => selectedCharacter = v)),
              _CharChip(emoji: '🐱', label: 'Caty', value: 'caty', selected: selectedCharacter, onTap: (v) => setState(() => selectedCharacter = v)),
              _CharChip(emoji: '✨', label: 'Aucun', value: null, selected: selectedCharacter, onTap: (v) => setState(() => selectedCharacter = v)),
            ],
          ),

          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CoquetteColors.blushPink,
              foregroundColor: CoquetteColors.deepRose,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              context.read<StorageService>().updateNotebookCover(
                    widget.notebookId,
                    selectedColor,
                    selectedPattern,
                    character: selectedCharacter,
                  );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Couverture mise à jour ✨', style: GoogleFonts.quicksand()),
                  backgroundColor: CoquetteColors.roseGold,
                ),
              );
            },
            child: Text(
              'Enregistrer 🎀',
              style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharChip extends StatelessWidget {
  final String emoji;
  final String label;
  final String? value;
  final String? selected;
  final ValueChanged<String?> onTap;

  const _CharChip({
    required this.emoji,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? CoquetteColors.blushPink : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? CoquetteColors.deepRose : CoquetteColors.softPink,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(label, style: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
