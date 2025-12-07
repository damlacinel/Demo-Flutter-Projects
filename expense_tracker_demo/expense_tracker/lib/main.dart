import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

//global variables usually starts with a 'k'
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181)
);

//Dark mode
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark, //adjust colors for dark mode
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    //MaterialApp -> setting the theme of the application
    //with theme argument
    MaterialApp(
      //ThemeData(...) -> creates a whole new theme
      //ThemeData().copyWith(...) -> copies the existing theme and
      //developer can change some settings
      //Light mode theme
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    )
  );
}

/*
TextTheme().copyWith(...) creates a brand-new, empty TextTheme and only applies 
the styles you provide. This means all default Material typography is lost. In 
contrast, ThemeData().textTheme.copyWith(...) takes Flutter’s existing Material 
text theme and overrides only the properties you specify, keeping all other default 
text styles intact. For this reason, using ThemeData().textTheme.copyWith(...) is the 
recommended and safer approach.
*/

/*
import 'package:flutter/services.dart';
-> To run the application on only the portrait mode
  /WidgetsFlutterBinding.ensureInitialized() makes sure that the Flutter 
  /engine and all system channels are fully initialized before you call 
  /any code that depends on them (such as SystemChrome, SharedPreferences,
  / PathProvider, or async native calls).
  WidgetsFlutterBinding.ensureInitialized();
  /the app is run only if the device is in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((fn) {
    /move runApp() here
  });
  */