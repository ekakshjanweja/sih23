import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/features/home/controller/home_controller.dart';
import 'package:sih_chatbot/features/home/views/ticket_generation.dart';
import 'package:sih_chatbot/features/home/widgets/message_box.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';
import 'package:sih_chatbot/models/spam_model.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    bool isListening = ref.watch(isListeningProvider);

    SpamModel spamModel = ref.watch(spamModelProvider);

    String? speechToText = ref.watch(speechToTextProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'Hello, ${ref.read(userProvider.notifier).state!.name}',
          ),
          leading: Image.asset(
            Assets.images.orb.path,
            scale: 4,
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.watch(authControllerProvider.notifier).logout();
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
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
            child: Stack(
              children: [
                //Title

                if (isListening)
                  const Positioned(
                    top: 0,
                    child: SizedBox(),
                  )
                else
                  Positioned(
                    top: currentHeight * 0.01,
                    left: currentWidth / 5,
                    child: Text(
                      spamModel.spam
                          ? 'I\'m sorry, could you\nplease repeat that?'
                          : 'Talk About\nYour Grievance.....',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),

                //Icon

                if (isListening)
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          width: currentWidth,
                          height: currentWidth,
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
                        ),
                      ),

                      //Talk About Your Grievance

                      Positioned(
                        top: currentHeight * 0.04,
                        left: currentWidth * 0.08,
                        child: Text(
                          'Talk About \nYour Grievance......',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),

                      //Speech To Text

                      Positioned(
                        top: currentHeight * 0.14,
                        left: currentWidth * 0.08,
                        right: currentWidth * 0.08,
                        child: Text(
                          speechToText ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),

                      //Orb

                      Positioned(
                        bottom: currentHeight * 0.15,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          Assets.images.orb.path,
                          scale: 1.5,
                        ),
                      ),
                    ],
                  )
                else
                  Positioned(
                    top: currentHeight * 0.05,
                    left: 0,
                    right: 0,
                    child: Image.asset(Assets.images.orb.path),
                  ),

                //Mic

                Positioned(
                  top: currentHeight * 0.55,
                  left: currentWidth * 0.3,
                  right: currentWidth * 0.3,
                  child: Container(
                    width: currentWidth * 0.3,
                    height: currentWidth * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isListening
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(homeControllerProvider)
                            .startListening(context: context, ref: ref);
                      },
                      icon: Icon(
                        isListening ? Icons.mic : Icons.mic,
                        size: 64,
                        color: isListening
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),

                // Positioned(
                //   top: currentHeight * 0.6,
                //   left: 0,
                //   right: 0,
                //   child: FilledButton.icon(
                //     onPressed: startListening,
                //     icon: Icon(
                //       isListening ? Icons.record_voice_over : Icons.mic,
                //       size: 32,
                //       color: Theme.of(context).colorScheme.onPrimary,
                //     ),
                //     label: Text(
                //       isListening ? 'Submit' : 'Talk it out',
                //     ),
                //   ),
                // ),

                // //Type A Message

                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: FilledButton.tonal(
                //     onPressed: () {},
                //     child: const Text('Type a Message'),
                //   ),
                // ),

                //Message Box

                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MessageBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
