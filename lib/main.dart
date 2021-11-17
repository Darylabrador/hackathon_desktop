import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/dashboard_screen.dart';
import './screens/forgotten_password_screen.dart';

import './providers/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Hackathon');
    setWindowMinSize(const Size(900, 700));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'Hackathon',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  headline3: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          ),
          home: authData.isAuth
              ? const DashboardScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ct, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const LoginScreen(),
                ),
          routes: {
            ForgottenPasswordScreen.routeName: (ctx) =>
                const ForgottenPasswordScreen(),
          },
        ),
      ),
    );
  }
}
