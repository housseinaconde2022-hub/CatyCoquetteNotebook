import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/coquette_theme.dart';
import '../services/storage_service.dart';
import 'page_editor.dart';
import 'cover_picker.dart';

class NotebookScreen extends StatelessWidget {
  final String notebookId;

  const NotebookScreen({super.key, required this.notebookId});

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<StorageService>();
    final notebook = storage.getNotebook(notebookId);

    if (notebook == null) {
      return Scaffold(
        body: Center(child: Text('Cahier introuvable 😢')),
      );
    }

    return Scaffold(
      backgroundColor: CoquetteColors.cream,
      appBar: AppBar(
        title: Text(
          notebook.title,
          style: GoogleFonts.pinyonScript(fontSize: 28, color: CoquetteColors.deepRose),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Changer la couverture',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CoverPickerScreen(notebookId: notebookId),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Cover preview
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color(int.parse('FF${notebook.coverColor.replaceAll('#', '')}', radix: 16)),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: CoquetteColors.dustyRose.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                notebook.title,
                style: GoogleFonts.pinyonScript(
                  fontSize: 36,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Pages',
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CoquetteColors.deepRose,
            ),
          ),
          const SizedBox(height: 12),
          // Simple page list for now
          _PageTile(
            title: 'Page 1 - Notes',
            subtitle: 'Lignée',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PageEditorScreen(
                    notebookId: notebookId,
                    pageTitle: 'Page 1',
                  ),
                ),
              );
            },
          ),
          _PageTile(
            title: 'Page 2 - Idées',
            subtitle: 'Grille',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PageEditorScreen(
                    notebookId: notebookId,
                    pageTitle: 'Page 2',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PageEditorScreen(
                    notebookId: notebookId,
                    pageTitle: 'Nouvelle page',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Nouvelle page'),
            style: OutlinedButton.styleFrom(
              foregroundColor: CoquetteColors.deepRose,
              side: BorderSide(color: CoquetteColors.blushPink),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PageTile({required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: CoquetteColors.babyPink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.notes_rounded, color: CoquetteColors.deepRose),
        ),
        title: Text(title, style: GoogleFonts.quicksand(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
