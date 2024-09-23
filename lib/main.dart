import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:attendance_qr_system/Screens/AttendanceScreen.dart';
import 'package:attendance_qr_system/Screens/CreateStudentScreen.dart';
import 'package:attendance_qr_system/Screens/CreateUserScreen.dart';
import 'package:attendance_qr_system/Screens/QRPage.dart';
import 'package:attendance_qr_system/Screens/QrScanner.dart';
import 'package:attendance_qr_system/Screens/SignUpPage.dart';
import 'package:attendance_qr_system/Screens/UserScreen.dart';
import 'package:attendance_qr_system/Screens/LoginPage.dart';
import 'package:attendance_qr_system/NavigationMenu/MainController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DatabaseController/FirebaseRun.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRun.run();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(title: 'QR CODE MANAGEMENT SYSTEM'),
      ),
      GoRoute(
        path: '/Loginpage',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/Signuppage',
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        path: '/QRPage',
        builder: (context, state) => const Qrpage(username: 'username'),
      ),
      GoRoute(
        path: '/Attendance',
        builder: (context, state) => const Attendancescreen(),
      ),
      GoRoute(
        path: '/Scanner',
        builder: (context, state) => const QrScanner(),
      ),
      GoRoute(
        path: '/UserScreen',
        builder: (context, state) => const Userscreen(),
      ),
      GoRoute(
        path: '/CreateUser',
        builder: (context, state) => const CreateUserScreen(),
      ),
      GoRoute(
        path: '/CreateStudent',
        builder: (context, state) => const CreateStudentScreen(),
      ),
      GoRoute(
        path: '/MainController',
        builder: (context, state) => Maincontroller(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    LoadingEnable();
  }

  void LoadingEnable() {
    setState(() {
      _isLoading = true;
    });
    // Simulate a delay for demonstration purposes
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;

        if (Firebase.apps.isEmpty) {
          Fluttertoast.showToast(
              msg: "Firebase initialization failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else {
          Fluttertoast.showToast(
              msg: "Firebase is already initialized",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
          //  Go to navigation
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          showToast();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image:AssetImage('Assets/logos.png'),
                width: 200,
                height: 200,
              ),
              const Text(
                'QR CODE MANAGEMENT SYSTEM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,

                ),
              ),
              const SizedBox(height: 20), // Add some space between the text and the loading bar
              _isLoading
                  ? const SizedBox(
                width: 50, // Adjust the width
                height: 50, // Adjust the height
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
  void closeActivity() {
    Navigator.pop(context);
    context.go('/Loginpage');
  }
  void showToast() {
    Fluttertoast.showToast(
      msg: "This is a toast message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}