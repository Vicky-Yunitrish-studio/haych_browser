import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_network/image_network.dart';

class SlidePage extends StatefulWidget {
  final String url;
  final List<String> paths;
  const SlidePage(this.url, this.paths, {super.key});
  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  @override
  void initState() {
    initPpts();
    super.initState();
  }

  Widget x(String url) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ImageNetwork(
        image: url,
        height: 1080 * 2,
        width: 1920 * 2,
        fullScreen: true,
      ),
    );
  }

  List<Widget> ppts = [];

  void initPpts() {
    for (String path in widget.paths) {
      ppts.add(x("http://blissfield.4hotel.tw/vod2/$path"));
      debugPrint("http://blissfield.4hotel.tw/vod2/$path");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 56,
          child: Container(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height),
            child: ImageSlideshow(
              // height: double.infinity,
              children: ppts,
            ),
          ),
        ),
      ],
    );
  }
}
