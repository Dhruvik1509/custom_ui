import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: MediaQueryExamplePage());
  }
}

class MediaQueryExamplePage extends StatelessWidget {
  const MediaQueryExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = CommonMediaQuery(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Common MediaQuery Example")),
      body: Center(
        child: Column(
          children: [
            Container(
              width: media.widthPercent(80),   // 80% of screen width
              height: media.heightPercent(20), // 20% of screen height
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                '80% width\n20% height',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CommonMediaQuery {
  final BuildContext context;
  late MediaQueryData _mediaQueryData;

  late double screenWidth;
  late double screenHeight;
  late Orientation orientation;

  CommonMediaQuery(this.context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  double heightPercent(double percent) => screenHeight * percent / 100;
  double widthPercent(double percent) => screenWidth * percent / 100;
}
