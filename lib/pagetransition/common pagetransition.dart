import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Common Page Transition")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CommonPageTransition(
                page: const SecondPage(),
                transitionType: TransitionType.scale,
              ),
            );
          },
          child: const Text("Go to Next Page"),
        ),
      ),
    );
  }
}


enum TransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  scale,
  rotation,
}

class CommonPageTransition extends PageRouteBuilder {
  final Widget page;
  final TransitionType transitionType;
  final Duration duration;

  CommonPageTransition({
    required this.page,
    this.transitionType = TransitionType.scale,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          print('fade');
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.slideFromRight:
          print('slideFromRight');
          return SlideTransition(
            position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        case TransitionType.slideFromLeft:
          print('SlideFromLeft');
          return SlideTransition(
            position: Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        case TransitionType.slideFromBottom:
          print('SliderFromBottom');
          return SlideTransition(
            position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        case TransitionType.scale:
          print('Scale');
          return ScaleTransition(scale: animation, child: child);
        case TransitionType.rotation:
          print('rotation');
          return RotationTransition(turns: animation, child: child);
      }
    },
  );
}


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
      body: const Center(child: Text("Welcome to the second page!")),
    );
  }
}
