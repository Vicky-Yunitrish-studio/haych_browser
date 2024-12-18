import 'package:flutter/material.dart';
import 'package:haych_browser/common/fetch_and_parse.dart';
import 'package:haych_browser/screen/slide_page.dart';
import 'package:html/dom.dart' as dom; // Ensure this import uses the alias

class DisplayPage extends StatefulWidget {
  final String url;

  const DisplayPage(this.url, {super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  late Future<dom.Document> _documentFuture;

  @override
  void initState() {
    super.initState();
    _documentFuture = fetchAndParseHTML(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Page'), // Flutter Text widget
      ),
      body: FutureBuilder<dom.Document>(
        future: _documentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Flutter Text widget
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Text('No data found')); // Flutter Text widget
          }
          final links = extractLinks(snapshot.data!);

          if (isImageLink(links.first.attributes['href'] ?? '')) {
            return SlidePage(
              widget.url,
              links.map((link) => link.attributes['href'] ?? '').toList(),
            );
          } else {
            return ListView(
              children: [
                ...links.map((link) {
                  String path = link.attributes['href'] ?? '';
                  String name = path.split(".").first;
                  if (isImageLink(path)) {
                    return Image.network("${widget.url}$path");
                  } else {
                    return ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPage(
                                'http://blissfield.4hotel.tw/vod2/$path'),
                          ),
                        )
                      },
                      child: Text(name),
                    );
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
