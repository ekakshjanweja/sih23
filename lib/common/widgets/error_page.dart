import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ErrorPage extends StatelessWidget {
  static const routeName = '/error-page';
  final String errorText;
  const ErrorPage({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorText.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),

            // Close Button

            const SizedBox(
              height: 40,
            ),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.errorContainer,
              ),
              child: IconButton(
                onPressed: () {
                  Routemaster.of(context).popUntil((routeData) => false);
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
