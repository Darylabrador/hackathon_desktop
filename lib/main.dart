import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import './routes.dart';
import './layout/custom_theme.dart';

import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/dashboard_screen.dart';

import './providers/auth.dart';
import './services/providers_service.dart';

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
      providers: ProvidersService.providerList(),
      child: Consumer<Auth>(
        builder: (ctx, authData, child) {
          return MaterialApp(
            title: 'Hackathon',
            theme: CustomTheme.appTheme(),
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
                    },
                  ),
            routes: Routes.appRoutes(),
          );
        },
      ),
    );
  }
}
