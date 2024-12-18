import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:haych_browser/screen/display_page.dart';
import 'package:provider/provider.dart';
import 'package:haych_browser/common/combined_notifier.dart';
import 'package:haych_browser/common/components.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Components().defaultPage(
      context,
      AppLocalizations.of(context)!.title_main,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Provider.of<CombinedNotifier>(context)
                .currentLocale
                .toString()),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DisplayPage('http://blissfield.4hotel.tw/vod2/'),
                  ),
                )
              },
              child: const Text("Disaplay Page"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
