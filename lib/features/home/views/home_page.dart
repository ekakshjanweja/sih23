import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
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

  String? speechToText;

  SpeechToText speechToTextInstance = SpeechToText();

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
        body: Padding(
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

              //Icon

              isListening
                  ? Positioned(
                      top: currentHeight * 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: currentWidth,
                        height: currentHeight * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Text(
                          speechToText!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    )
                  : Positioned(
                      top: currentHeight * 0.05,
                      left: 0,
                      right: 0,
                      child: Image.asset(Assets.images.orb.path),
                    ),

              //Mic

              Positioned(
                top: currentHeight * 0.55,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    if (!isListening) {
                      bool available = await speechToTextInstance.initialize();

                      if (available) {
                        setState(() {
                          isListening = true;
                        });
                        setState(() {
                          speechToTextInstance.listen(
                            onResult: (result) => setState(() {
                              speechToText = result.recognizedWords;
                            }),
                          );
                        });
                      }
                    } else {
                      setState(() {
                        isListening = false;
                        speechToTextInstance.stop();
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isListening ? Icons.record_voice_over : Icons.mic,
                      size: 48,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),

              //Message Box

              Positioned(
                bottom: currentHeight * 0.01,
                left: 0,
                right: 0,
                child: const MessageBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
