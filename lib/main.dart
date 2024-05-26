import 'package:flutter/material.dart';
import 'package:flutter_notepad_app_sqflite/view/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

          textTheme: TextTheme(

          //display
            displaySmall:
            GoogleFonts.montserrat(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.black),
     

            //Body Small
            bodySmall:
                GoogleFonts.montserrat(fontSize: 11,fontWeight: FontWeight.w400, color: Colors.black),
                
            //Body Medium
            bodyMedium: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
            //Body Large
            bodyLarge: GoogleFonts.aBeeZee(fontSize: 17,  fontWeight: FontWeight.w600, color: Colors.black),
            // //
            titleMedium: GoogleFonts.aBeeZee(fontSize: 23, color: Colors.black , fontWeight: FontWeight.bold),
            titleLarge: GoogleFonts.aBeeZee(fontSize: 35, color: Colors.black , fontWeight: FontWeight.bold),


        ),
          appBarTheme:  const  AppBarTheme(
            backgroundColor: Color.fromARGB(255, 250, 157, 150), foregroundColor: Colors.yellow),

      
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
