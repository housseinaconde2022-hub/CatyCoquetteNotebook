import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'theme/coquette_theme.dart';
import 'models/notebook.dart';
import 'models/note_page.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters (after running build_runner)
  // Hive.registerAdapter(NotebookAdapter());
  // Hive.registerAdapter(NotePageAdapter());

  await StorageService.init();

  runApp(const CatyApp());
}

class CatyApp extends StatelessWidget {
  const CatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StorageService()),
      ],
      child: MaterialApp(
        title: 'Caty Coquette Notebook',
        debugShowCheckedModeBanner: false,
        theme: CoquetteTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}
