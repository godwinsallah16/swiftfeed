import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // You might want to replace the Future.delayed duration with your actual splash screen duration
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/swift_logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'SwiftFeed',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Personalized News App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
