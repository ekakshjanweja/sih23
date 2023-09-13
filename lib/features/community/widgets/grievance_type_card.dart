import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrievanceTypeCard extends ConsumerWidget {
  final String title;
  final int number;

  const GrievanceTypeCard({
    super.key,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Container(
      width: currentWidth * 0.45,
      height: currentHeight * 0.2,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          transform: const GradientRotation(3.14 / 2),
          colors: [
            const Color(0xffB961FE).withOpacity(0.3),
            const Color(0xff0011E0),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Top

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title

              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              //Number

              Text(
                number.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),

          //Progress Bar

          Container(
            height: 10,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: currentWidth * 0.2,
              decoration: BoxDecoration(
                color: const Color(0xffF2FF53),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
