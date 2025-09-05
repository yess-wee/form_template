
import 'package:flutter/material.dart';
import 'package:example/homepage.dart';

Map<int, Color> color = <int, Color>{
  50: const Color.fromRGBO(24, 68, 107, .1),
  100: const Color.fromRGBO(24, 68, 107, .2),
  200: const Color.fromRGBO(24, 68, 107, .3),
  300: const Color.fromRGBO(24, 68, 107, .4),
  400: const Color.fromRGBO(24, 68, 107, .5),
  500: const Color.fromRGBO(24, 68, 107, .6),
  600: const Color.fromRGBO(24, 68, 107, .7),
  700: const Color.fromRGBO(24, 68, 107, .8),
  800: const Color.fromRGBO(24, 68, 107, .9),
  900: const Color.fromRGBO(24, 68, 107, 1),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MaterialApp(
      title: "SAFEinvest SARATHI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        dividerColor: Colors.transparent,

        scaffoldBackgroundColor: Colors.white,
        primarySwatch: MaterialColor(0xFF18446B, color),

        cardColor: Colors.white,
        dialogBackgroundColor: Colors.white,

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF18446B),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF18446B),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF18446B),
          textTheme: ButtonTextTheme.primary,
        ),

        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF18446B)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF18446B).withOpacity(0.6)),
          ),
        ),

        checkboxTheme: CheckboxThemeData(

          fillColor: MaterialStateProperty.all(Color(0xFF18446B)),
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF18446B),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF18446B),
        ),

        // // Set the divider color globally
        // dividerColor: Color(0xFF18446B),


        fontFamily: 'Montserrat',
      ),
      home: Homepage(title: "TESTING"),
    ),
  );
}
