import 'package:haych_browser/common/combined_notifier.dart';
import 'package:haych_browser/firebase_options.dart';
import 'package:haych_browser/screen/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CombinedNotifier(),
      child: Consumer<CombinedNotifier>(
        builder: (context, notifier, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.colorTheme.begin,
            darkTheme: notifier.colorTheme.end,
            themeMode: notifier.themeMode,
            locale: notifier.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
