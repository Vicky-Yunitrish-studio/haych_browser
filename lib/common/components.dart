import 'package:haych_browser/common/theme_sets.dart';
import 'package:haych_browser/common/combined_notifier.dart';
import 'package:haych_browser/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Components {
  Widget kit(BuildContext context, Widget header, DropdownButton optionList) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(4),
              child: header,
            ),
            optionList,
          ],
        ));
  }

  Widget languageKit(BuildContext context, CombinedNotifier notifier) {
    return kit(
      context,
      const Icon(Icons.language),
      DropdownButton(
        value: notifier.currentLocale,
        items: const [
          DropdownMenuItem(value: Locale("en", "US"), child: Text("English")),
          DropdownMenuItem(value: Locale("zh", "TW"), child: Text("繁體中文")),
        ],
        onChanged: (value) =>
            Provider.of<CombinedNotifier>(context, listen: false)
                .updateLocale(value),
      ),
    );
  }

  Widget darkThemeKit(BuildContext context, CombinedNotifier notifier) {
    return kit(
      context,
      const Icon(Icons.color_lens_outlined),
      DropdownButton(
        value: notifier.darkTheme,
        items: [
          DropdownMenuItem(
              value: ThemeData.dark(),
              child: Text(AppLocalizations.of(context)!.default_value)),
          DropdownMenuItem(value: Themes.grey.end, child: const Text("#Grey")),
          DropdownMenuItem(value: Themes.blue.end, child: const Text("#Blue")),
          DropdownMenuItem(
              value: Themes.brown.end, child: const Text("#Brown")),
        ],
        onChanged: (value) =>
            Provider.of<CombinedNotifier>(context, listen: false)
                .updateDarkTheme(value),
      ),
    );
  }

  Widget lightThemeKit(BuildContext context, CombinedNotifier notifier) {
    return kit(
      context,
      const Icon(Icons.color_lens_outlined),
      DropdownButton(
        value: notifier.lightTheme,
        items: [
          DropdownMenuItem(
              value: ThemeData.light(),
              child: Text(AppLocalizations.of(context)!.default_value)),
          DropdownMenuItem(
              value: Themes.grey.begin, child: const Text("#Grey")),
          DropdownMenuItem(
              value: Themes.blue.begin, child: const Text("#Blue")),
          DropdownMenuItem(
              value: Themes.brown.begin, child: const Text("#Brown")),
        ],
        onChanged: (value) =>
            Provider.of<CombinedNotifier>(context, listen: false)
                .updateLightTheme(value),
      ),
    );
  }

  Widget colorThemeKit(BuildContext context, CombinedNotifier notifier) {
    return kit(
      context,
      const Icon(Icons.color_lens_outlined),
      DropdownButton(
          value: notifier.colorTheme,
          items: [
            DropdownMenuItem(
                value: Themes.defaultValue,
                child: Text(AppLocalizations.of(context)!.default_value)),
            DropdownMenuItem(value: Themes.grey, child: const Text("#Grey")),
            DropdownMenuItem(value: Themes.blue, child: const Text("#Blue")),
            DropdownMenuItem(value: Themes.brown, child: const Text("#Brown")),
          ],
          onChanged: (value) {
            Provider.of<CombinedNotifier>(context, listen: false)
                .updateColorTheme(value);
          }),
    );
  }

  Widget themeModeKit(BuildContext context, CombinedNotifier notifier) {
    return kit(
      context,
      const Icon(Icons.dark_mode_outlined),
      DropdownButton(
        value: notifier.themeMode,
        items: [
          DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(AppLocalizations.of(context)!.dark)),
          DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(AppLocalizations.of(context)!.light)),
          DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(AppLocalizations.of(context)!.system)),
        ],
        onChanged: (value) =>
            Provider.of<CombinedNotifier>(context, listen: false)
                .toggleThemeMode(value),
      ),
    );
  }

  Drawer drawer(BuildContext context) {
    CombinedNotifier notifier = Provider.of<CombinedNotifier>(context);
    return Drawer(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: GridTile(
          footer: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(FirebaseAuth.instance.currentUser!.displayName!),
                        Text(
                            '電子郵件驗證: ${FirebaseAuth.instance.currentUser!.emailVerified ? "是" : "否"}'),
                        const Text('一般使用者'),
                      ],
                    ),
                  ],
                ),
              ),
              languageKit(context, notifier),
              themeModeKit(context, notifier),
              colorThemeKit(context, notifier),
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          child: Container(),
        ),
      ),
    );
  }

  Scaffold defaultPage(BuildContext context, String title,
      {Widget? body, Widget? floatingActionButton}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: drawer(context),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
