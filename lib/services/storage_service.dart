import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/notebook.dart';
import '../models/note_page.dart';

class StorageService extends ChangeNotifier {
  static const String notebooksBoxName = 'notebooks';
  static const String pagesBoxName = 'pages';

  late Box _notebooksBox;
  late Box _pagesBox;

  List<Notebook> notebooks = [];

  static Future<void> init() async {
    // For simplicity we use dynamic boxes until adapters are generated
    // Run: flutter pub run build_runner build
  }

  Future<void> load() async {
    // Placeholder - in real app open Hive boxes
    // For demo we keep in-memory list
    if (notebooks.isEmpty) {
      // Seed with cute example notebooks
      notebooks = [
        Notebook(
          id: const Uuid().v4(),
          title: 'Ethics',
          coverColor: '#FADADD',
          coverPattern: 'solid',
          character: 'mymelody',
        ),
        Notebook(
          id: const Uuid().v4(),
          title: 'Geography',
          coverColor: '#F7C6CE',
          coverPattern: 'gingham',
        ),
        Notebook(
          id: const Uuid().v4(),
          title: 'English',
          coverColor: '#FFF8E8',
          coverPattern: 'dots',
        ),
        Notebook(
          id: const Uuid().v4(),
          title: 'Study Plan',
          coverColor: '#F8D7DE',
          coverPattern: 'stripes',
        ),
        Notebook(
          id: const Uuid().v4(),
          title: 'Art',
          coverColor: '#E8B4B8',
          coverPattern: 'lace',
        ),
        Notebook(
          id: const Uuid().v4(),
          title: 'Doodles',
          coverColor: '#D4A5A5',
          coverPattern: 'solid',
        ),
      ];
    }
    notifyListeners();
  }

  Future<void> addNotebook(String title, {String color = '#FADADD', String pattern = 'solid'}) async {
    final nb = Notebook(
      id: const Uuid().v4(),
      title: title,
      coverColor: color,
      coverPattern: pattern,
    );
    notebooks.add(nb);
    notifyListeners();
  }

  Future<void> updateNotebookCover(String id, String color, String pattern, {String? character}) async {
    final index = notebooks.indexWhere((n) => n.id == id);
    if (index != -1) {
      notebooks[index].coverColor = color;
      notebooks[index].coverPattern = pattern;
      if (character != null) notebooks[index].character = character;
      notebooks[index].updatedAt = DateTime.now();
      notifyListeners();
    }
  }

  Future<void> deleteNotebook(String id) async {
    notebooks.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  Notebook? getNotebook(String id) {
    try {
      return notebooks.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }
}
