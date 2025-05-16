import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'src/features/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);
  } else {
    await Hive.initFlutter();
  }

  final characterBox = await Hive.openBox('characterBox');

  if (characterBox.isEmpty) {
    await characterBox.addAll([
      {
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        "species": "Human",
        "gender": "Male",
        "locationName": "Earth (C-137)",
      },
      {
        "id": 2,
        "name": "Morty Smith",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        "species": "Human",
        "gender": "Male",
        "locationName": "Earth (Replacement Dimension)",
      },
    ]);
  }

  runApp(const RickAndMortyTask());
}

class RickAndMortyTask extends StatelessWidget {
  const RickAndMortyTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Rick & Morty', home: const HomeScreen());
  }
}
