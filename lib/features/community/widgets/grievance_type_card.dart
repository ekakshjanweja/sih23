import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrievanceTypeCard extends ConsumerWidget {
  const GrievanceTypeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Container(
      width: currentWidth * 0.8,
      height: currentHeight * 0.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          transform: const GradientRotation(120),
          colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          ],
        ),
      ),
    );
  }
}
