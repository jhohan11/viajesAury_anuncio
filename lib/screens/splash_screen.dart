import 'package:flutter/material.dart';
import '../theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onComplete});
  final VoidCallback onComplete;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500))..forward();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(fit: StackFit.expand, children: [
      Image.asset('assets/images/splash.png', fit: BoxFit.cover),
      Container(decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Color(0x13006977), Color(0xD8006175)],
      ))),
      SafeArea(child: Center(child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: Curves.easeIn.transform(_controller.value),
          child: Transform.scale(
            scale: 0.82 + _controller.value * 0.18,
            child: child,
          ),
        ),
        child: const Column(mainAxisSize: MainAxisSize.min, children: [
          CircleAvatar(radius: 48, backgroundColor: Colors.white,
              child: Icon(Icons.flight_takeoff, size: 55, color: coral)),
          SizedBox(height: 17),
          Text('ViajesAury', style: TextStyle(
            color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text('Tu próxima aventura comienza aquí',
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ]),
      ))),
      const Positioned(bottom: 25, left: 0, right: 0,
        child: Center(child: Text('EXPLORA · DESCUBRE · VIAJA',
            style: TextStyle(color: Colors.white, letterSpacing: 2,
                fontWeight: FontWeight.w700, fontSize: 11)))),
    ]),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
