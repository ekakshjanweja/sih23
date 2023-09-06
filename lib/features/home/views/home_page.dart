import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  //static const routeName = '/home';

  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
