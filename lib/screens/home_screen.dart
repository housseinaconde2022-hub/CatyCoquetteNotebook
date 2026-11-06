import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/coquette_theme.dart';
import '../services/storage_service.dart';
import '../widgets/notebook_cover.dart';
import 'notebook_screen.dart';
import 'cover_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StorageService>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<StorageService>();

    return Scaffold(
      backgroundColor: CoquetteColors.cream,
      appBar: AppBar(
        title: Text(
          'Caty Notebook 🐱',
          style: GoogleFonts.pinyonScript(
            fontSize: 30,
            color: CoquetteColors.deepRose,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Soft header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: CoquetteColors.babyPink.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Text(
              'Mes jolis cahiers ✨',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CoquetteColors.deepRose,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
              ),
              itemCount: storage.notebooks.length + 1, // +1 for "New"
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _NewNotebookCard(
                    onTap: () => _showCreateDialog(context),
                  );
                }
                final notebook = storage.notebooks[index - 1];
                return NotebookCoverWidget(
                  notebook: notebook,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotebookScreen(notebookId: notebook.id),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CoverPickerScreen(notebookId: notebook.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: CoquetteColors.ivory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Nouveau cahier 🌸',
          style: GoogleFonts.pinyonScript(fontSize: 26, color: CoquetteColors.deepRose),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Titre du cahier...',
            prefixIcon: Icon(Icons.book_outlined),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CoquetteColors.blushPink,
              foregroundColor: CoquetteColors.deepRose,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<StorageService>().addNotebook(controller.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Créer ✨'),
          ),
        ],
      ),
    );
  }
}

class _NewNotebookCard extends StatelessWidget {
  final VoidCallback onTap;
  const _NewNotebookCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CoquetteColors.softPink,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: CoquetteColors.babyPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, size: 32, color: CoquetteColors.deepRose),
            ),
            const SizedBox(height: 12),
            Text(
              'Nouveau',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                color: CoquetteColors.deepRose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
