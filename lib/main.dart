import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/splash_screen.dart';
import 'package:main/services/auth/auth_service.dart';
import 'package:main/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  
  runApp(
    ChangeNotifierProvider(create: (context)=>AuthService(),
    child:  const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      // primarySwatch: Colors.blue, // Set the primary color swatch
      // visualDensity: VisualDensity.adaptivePlatformDensity, // Set the visual density
    // ),
      home: SplashScreen(),
    );
}
}