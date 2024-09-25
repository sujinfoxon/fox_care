import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foxcare_app/core/theme/colors.dart';
import 'features/presentation/pages/login_page.dart';
import 'firebase_options.dart'; // Replace with your home page

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      // Navigate to the home page after 3 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size and scale dynamically using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Use these values to create a responsive splash screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adjust the image size based on screen width and height
            Container(
              width: screenWidth * 0.6, // 60% of screen width
              height: screenHeight * 0.3, // 30% of screen height
              child: Image.asset(AppImages.logo), // Add your splash image here
            ),
            SizedBox(height: screenHeight * 0.05), // 5% spacing
            // Responsive text that scales with screen size
            Text(
              'Health Care',
              style: TextStyle(
                fontSize: screenWidth * 0.06, // Font size is 8% of screen width
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Column(
              children: [
                Text('A Product By',style: TextStyle(color: AppColors.secondary,fontSize: screenWidth * 0.03),),
                Text('Foxton',style: TextStyle(color: AppColors.secondary,fontSize: screenWidth * 0.03),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
