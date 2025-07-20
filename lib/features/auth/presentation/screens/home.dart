import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const Home());

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home"),
    );
  }
}
