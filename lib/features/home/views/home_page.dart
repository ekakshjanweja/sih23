import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/features/home/views/ticket_generation.dart';
import 'package:sih_chatbot/features/home/widgets/message_box.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isListening = false;
  bool isSpam = false;

  String? speechToText;

  SpeechToText speechToTextInstance = SpeechToText();

  void startListening() async {
    if (!isListening) {
      bool available = await speechToTextInstance.initialize();

      if (available) {
        setState(() {
          isListening = true;
        });
        setState(
          () {
            speechToTextInstance.listen(
              onResult: (result) => setState(() {
                speechToText = result.recognizedWords;
              }),
            );
          },
        );
      }
    } else {
      setState(() {
        speechToTextInstance.stop();
      });

      //Give Call to django to get response for whether spam or not

      setState(() {
        isListening = false;
      });

      if (!isSpam) {
        print('Send Text to Django');
        Routemaster.of(context).push(TicketGeneration.routeName);
      } else {
        print('Spam Detected');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
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
                ref.read(authControllerProvider.notifier).logout();
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
                      'Talk About\nYour Grievance.....',
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
                          isSpam
                              ? 'Sorry did\'nt get that could you try again?'
                              : speechToText ?? '',
                          style: isSpam
                              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  )
                              : Theme.of(context).textTheme.bodyLarge,
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
                  top: currentHeight * 0.6,
                  left: 0,
                  right: 0,
                  child: FilledButton.icon(
                    onPressed: startListening,
                    icon: Icon(
                      isListening ? Icons.record_voice_over : Icons.mic,
                      size: 32,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    label: Text(
                      isListening
                          ? isSpam
                              ? 'Try Again'
                              : 'Submit'
                          : 'Talk it out',
                    ),
                  ),
                ),

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
