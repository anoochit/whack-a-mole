import 'dart:io'; // Provides access to I/O for non-web applications
import 'package:bitsdojo_window/bitsdojo_window.dart'; // Package for customizing window size and behavior
import 'package:flutter/material.dart'; // Flutter framework
import 'package:google_fonts/google_fonts.dart'; // Package for using Google Fonts
import 'package:whackmole/pages/home.dart'; // Importing the HomePage from your project

void main() {
  // Starts the Flutter application by running MyApp
  runApp(const MyApp());

  // Check if the platform is Windows, Linux, or MacOS
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Wait until the window is ready
    doWhenWindowReady(() {
      // Set the initial size of the window
      const initialSize = Size(450, 750);
      // Set the maximum size of the window
      appWindow.maxSize = initialSize;
      // Set the minimum size of the window
      appWindow.minSize = initialSize;
      // Set the initial size of the window
      appWindow.size = initialSize;
      // Show the window
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  // Constructor for MyApp
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hides the debug banner
      debugShowCheckedModeBanner: false,
      // Title of the application
      title: 'Whack A Mole',
      theme: ThemeData(
        // Theme color scheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        // Use Material 3 design
        useMaterial3: true,
        textTheme: TextTheme(
          // Custom font for large headlines
          displayMedium:
              GoogleFonts.permanentMarker(fontWeight: FontWeight.w400),
          // Custom font for large headlines
          headlineLarge:
              GoogleFonts.permanentMarker(fontWeight: FontWeight.w400),
          // Custom font for medium headlines
          headlineMedium:
              GoogleFonts.permanentMarker(fontWeight: FontWeight.w300),
        ),
      ),
      // Sets the HomePage as the home screen of the app
      home: const HomePage(),
    );
  }
}
