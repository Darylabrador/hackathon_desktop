import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/auth.dart';
import '../providers/password_reset.dart';
import '../providers/stats.dart';
import '../providers/account_setting.dart';
import '../providers/phase_provider.dart';
import '../providers/pdf_provider.dart';

class ProvidersService {
  static List<SingleChildWidget> providerList() {
    return [
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
        update: (ct, auth, prevState) => AccountSetting(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<Auth, PhaseProvider>(
        create: (ctx) => PhaseProvider(),
        update: (ct, auth, prevState) => PhaseProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<Auth, PDFProvider>(
        create: (ctx) => PDFProvider(),
        update: (ct, auth, prevState) => PDFProvider(authToken: auth.token),
      ),
    ];
  }
}
