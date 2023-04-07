import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pro_area/main/data/repositories/model/character_model.dart';
import 'package:pro_area/main/presentation/screen/character_screen.dart';

void main() async {
  await Hive.initFlutter();
 // Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox <CharacterModel>('history');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DisplayCharacterScreen(),
      },
    );
  }
}
