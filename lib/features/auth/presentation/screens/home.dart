import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => Home());

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home', style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
