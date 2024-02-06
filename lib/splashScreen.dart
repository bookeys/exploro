import 'package:flutter/material.dart';
import 'package:exploro/StartupPageView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loaded = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const StartupPageView(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CenteredText();
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFEBD2F),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "exploro",
          style: TextStyle(
              color: Colors.white, fontSize: 36, fontFamily: "ColabBold"),
        ),
      ),
    );
  }
}
