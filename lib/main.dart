import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxcare_app/bloc/auth/auth_bloc.dart';
import 'package:foxcare_app/bloc/patient/patient_bloc.dart';
import 'package:foxcare_app/features/presentation/pages/admission_status.dart';
import 'package:foxcare_app/features/presentation/pages/op_counters.dart';
import 'package:foxcare_app/features/presentation/receeption/op_ticket_generate.dart';
import 'package:foxcare_app/repository/auth_repository.dart';
import 'package:foxcare_app/core/theme/colors.dart';
import 'package:foxcare_app/features/presentation/pages/doctors_dashboard.dart';
import 'package:foxcare_app/features/presentation/pages/reception_dashboard.dart';
import 'package:foxcare_app/features/presentation/pages/login_page.dart';
import 'features/presentation/pages/doctor/doctor_dashboard.dart';
import 'features/presentation/pages/doctor/rx_prescription.dart';
import 'features/presentation/pages/doctor_schedule.dart';
import 'features/presentation/pages/ip_admission.dart';
import 'features/presentation/pages/op_ticket.dart';
import 'firebase_options.dart'; // Import firebase config options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepository = AuthRepository();  // Initialize your AuthRepository

  runApp(MyApp(authRepository: authRepository));  // Pass the repository to the app
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => PatientFormBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoxCare App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/doctorHome': (context) => DoctorsDashboard(),
          '/receptionHome': (context) => ReceptionDashboard(),
        },
        initialRoute: '/',  // Define the initial route
      home: RxPrescription(),  // Starting screen is the splash screen

     //  home: PdfPage(),
      ),
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
      // Navigate to the login page after 2 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash logo image with responsive size
            Container(
              width: screenWidth * 0.6,
              height: screenHeight * 0.3,
              child: Image.asset(AppImages.logo), // Your splash logo
            ),
            SizedBox(height: screenHeight * 0.05),
            // Responsive text
            Text(
              'Health Care',
              style: TextStyle(
                fontSize: screenWidth * 0.06,  // Adjust font size
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              children: [
                Text(
                  'A Product By',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                Text(
                  'Foxton',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
