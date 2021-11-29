import 'package:flutter/material.dart';

import './screens/dashboard_screen.dart';
import './screens/account_setting_screen.dart';
import './screens/forgotten_password_screen.dart';
import './screens/account_delete_confirm_screen.dart';
import './screens/project_details_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      ForgottenPasswordScreen.routeName: (ctx) =>
          const ForgottenPasswordScreen(),
      DashboardScreen.routeName: (ctx) => const DashboardScreen(),
      AccountSettingScreen.routeName: (ctx) => const AccountSettingScreen(),
      AccountDeleteConfirmScreen.routeName: (ctx) =>
          const AccountDeleteConfirmScreen(),
      ProjectDetailsScreen.routeName: (ctx) => const ProjectDetailsScreen(),
    };
  }
}
