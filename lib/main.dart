import 'package:attendance_qr_system/Screens/EditStudentScreen.dart';
import 'package:attendance_qr_system/Screens/EventAttendanceScreen.dart';
import 'package:attendance_qr_system/Screens/UpdateProfileScreen.dart';
import 'package:attendance_qr_system/Screens/ViewStudentQR.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:attendance_qr_system/Screens/AttendanceScreen.dart';
import 'package:attendance_qr_system/Screens/GenerateQR.dart';
import 'package:attendance_qr_system/Screens/CreateUserScreen.dart';
import 'package:attendance_qr_system/Screens/QRPage.dart';
import 'package:attendance_qr_system/Screens/QrScanner.dart';
import 'package:attendance_qr_system/Screens/SignUpPage.dart';
import 'package:attendance_qr_system/Screens/UserScreen.dart';
import 'package:attendance_qr_system/Screens/LoginPage.dart';
import 'package:attendance_qr_system/Component/MainController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DatabaseController/FirebaseRun.dart';
import 'Function/SessionManager.dart';
import 'Screens/CreateRoomEvent.dart';
import 'Screens/EditEmailScreen.dart';
import 'Screens/EditPasswordScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/OTPScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRun.run();
  final SessionManager sessionManager = SessionManager();
  final userInfo = await sessionManager.getUserInfo();
  runApp(MyApp(userInfo: userInfo));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? userInfo;
  const MyApp({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MyHomePage(title: 'QR CODE MANAGEMENT SYSTEM', userInfo: userInfo),
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
          builder: (context, state) {
            final firstname = state.extra as String;
            return Qrpage(firstname: firstname);
          },
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
          builder: (context, state){
            final username = state.extra as String;
            return Userscreen(username: username);
          },
        ),
        GoRoute(
          path: '/CreateUser',
          builder: (context, state) => const CreateUserScreen(),
        ),
        GoRoute(
          path: '/GenerateQr',
          builder: (context, state) => const GenerateQr(),
        ),
        GoRoute(
          path: '/MainController',
          builder: (context, state) {
            final userInfo = state.extra as Map<String, dynamic>;
            return Maincontroller(userInfo: userInfo);
          },
        ),
        GoRoute(
          path: '/Otp',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return OTPScreen(extra: extra);
          },
        ),
        GoRoute(path: '/EditPassword',
            builder: (context, state) {
          final username = state.extra as String;
          return EditPasswordScreen(username: username);
    },
        ),
        GoRoute(path: '/EditEmail',
            builder: (context, state) {
              final username = state.extra as String;
              return EditEmailScreen(username: username);
            },
        ),
        GoRoute(
          path: '/ChangeProfile',
          builder: (context, state) {
            final profileData = state.extra as Map<String, dynamic>;
            return UpdateProfileScreen(profileData:profileData);
          },
        ),
        GoRoute(
          path: '/Map',
          builder: (context, state){
            final data = state.extra as Map<String, dynamic>;
            return MapScreen(data: data);
          },
        ),
        GoRoute(
          path:'/CreateEventRoom',
          builder: (context, state) => const CreateEventRoomScreen(),
        ),
        GoRoute(
          path:'/GoToEvent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return EventAttendanceScreen(data: data);
          },
        ),
        GoRoute(
          path:'/EditStudent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return EditStudentScreen(data: data);
          },
        ),
        GoRoute(
          path:'/ViewStudent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ViewStudentQr(data: data);
          },
        )
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
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
  final Map<String, dynamic>? userInfo;
  final String title;

  const MyHomePage({super.key, required this.title, this.userInfo});

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
          if (widget.userInfo != null) {
            context.go('/MainController', extra: widget.userInfo);
          } else {
            context.go('/Loginpage');
            Fluttertoast.showToast(
                msg: "userinfo is null",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
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
                image: AssetImage('Assets/logos.png'),
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
              const SizedBox(height: 20),
              _isLoading
                  ? const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Text(''),
              const Text(
                'Made by: WenDEVLIFE @2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
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