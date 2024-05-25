import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:whackmole/pages/home.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Wait until the window is ready
    doWhenWindowReady(() {
      // Set the initial size of the window
      const initialSize = Size(450, 750);
      appWindow.maxSize = initialSize;
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;

      // Show the window
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whack A Mole',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
