import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:authapp/init_dependencies.dart';

class Home extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const Home());

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Get supabase client from dependency injection
  final _supabase = sl<SupabaseClient>();
  final greetings = (DateTime.now().hour < 12
      ? 'Good Morning'
      : DateTime.now().hour < 17
      ? 'Good Afternoon'
      : 'Good Evening');

  @override
  Widget build(BuildContext context) {
    // Access current user from supabase
    final currentUser = _supabase.auth.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 30,
          children: [
            Text(
              '$greetings\n${currentUser?.email}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              '${currentUser?.id}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
