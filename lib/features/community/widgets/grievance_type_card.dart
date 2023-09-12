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
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          transform: GradientRotation(3.14 / 2),
          colors: [
            Colors.transparent,
            Color(0xff0011E0),
          ],
        ),
      ),
    );
  }
}
