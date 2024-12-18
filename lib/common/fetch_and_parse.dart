import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

Future<Document> fetchAndParseHTML(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return html_parser.parse(response.body);
  } else {
    throw Exception('Failed to load HTML');
  }
}

// List<Element> extractButtons(Document document) {
//   return document.querySelectorAll('button');
// }

// List<Element> extractImages(Document document) {
//   return document.querySelectorAll('img');
// }

bool isImageLink(String url) {
  final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
  return imageExtensions.any((ext) => url.toLowerCase().endsWith(ext));
}

List<Element> extractLinks(Document document) {
  return document.querySelectorAll('a[href]');
}
