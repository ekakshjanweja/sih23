import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';

class TicketGeneration extends ConsumerWidget {
  static const routeName = '/ticket-generation';

  const TicketGeneration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Image.asset(
          Assets.images.orb.path,
          scale: 4,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.test.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: currentHeight * 0.035,
            horizontal: currentWidth * 0.06,
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  width: currentHeight / 3,
                  height: currentHeight / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.onBackground,
                          Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                        ],
                      ),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title

                      Text.rich(
                        TextSpan(
                          text: 'Ticket ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                          children: [
                            TextSpan(
                              text: 'Generated',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      //Ticket Id

                      Text(
                        'Ticket ID',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      Text(
                        '123456789',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),

                      SizedBox(
                        height: currentHeight * 0.01,
                      ),

                      //POC

                      Text(
                        'POC: Arun Bisht',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),

                      Text(
                        'Ministry of Jal Shakti',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: currentHeight * 0.1,
                ),

                //Ministry Details
                FilledButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(30),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Ministry of Jal Shakti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
