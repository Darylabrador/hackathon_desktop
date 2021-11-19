import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/dashboard_screen.dart';
import './screens/account_setting_screen.dart';
import './screens/forgotten_password_screen.dart';
import './screens/account_delete_confirm_screen.dart';

import './providers/auth.dart';
import './providers/password_reset.dart';
import './providers/stats.dart';
import './providers/account_setting.dart';
import './utils/palette.dart';

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
        ChangeNotifierProxyProvider<Auth, PasswordReset>(
          create: (ctx) => PasswordReset(),
          update: (ct, auth, prevState) => PasswordReset(authToken: auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, Stats>(
          create: (ctx) => Stats(),
          update: (ct, auth, prevState) => Stats(authToken: auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, AccountSetting>(
          create: (ctx) => AccountSetting(),
          update: (ct, auth, prevState) =>
              AccountSetting(authToken: auth.token),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, authData, child) {
        return MaterialApp(
          title: 'Hackathon',
          theme: ThemeData(
            primarySwatch: Palette.bluePostale,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Palette.yellowPostale[200]),
            ),
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
                  headline4: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
          home: authData.isAuth
              ? const DashboardScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ct, authSnapshot) {
                    if (authSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SplashScreen();
                    }
                    return const LoginScreen();
                  }),
          routes: {
            ForgottenPasswordScreen.routeName: (ctx) =>
                const ForgottenPasswordScreen(),
            DashboardScreen.routeName: (ctx) => const DashboardScreen(),
            AccountSettingScreen.routeName: (ctx) =>
                const AccountSettingScreen(),
            AccountDeleteConfirmScreen.routeName: (ctx) =>
                const AccountDeleteConfirmScreen(),
          },
        );
      }),
    );
  }
}
