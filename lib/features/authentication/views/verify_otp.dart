import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';

class VerifyOTP extends ConsumerStatefulWidget {
  static const routeName = '/verify-otp';

  const VerifyOTP({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends ConsumerState<VerifyOTP> {
  bool isOtpSent = false;

  //Text Editing Controllers

  TextEditingController otpController = TextEditingController();

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
          title: Image.asset(
            Assets.images.orb.path,
            scale: 4,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: currentHeight * 0.035,
            horizontal: currentWidth * 0.06,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Mobile Number Verificationn

                Text(
                  'Mobile Number Verification',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(
                  height: currentHeight * 0.03,
                ),

                //Phone Number Inputfield

                TextField(
                  keyboardType: TextInputType.phone,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: ref
                        .read(newUserOnboardingProvider.notifier)
                        .state!
                        .phone,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(
                  height: currentHeight * 0.03,
                ),

                //Enter OTP

                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  enabled: isOtpSent,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(
                  height: currentHeight * 0.1,
                ),

                //Request OTP

                isOtpSent
                    ? SizedBox(
                        width: currentWidth,
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              isOtpSent = true;
                            });

                            ref
                                .watch(authControllerProvider.notifier)
                                .verifyOTP(
                                  context: context,
                                  ref: ref,
                                  userOTP: otpController.text.trim(),
                                );

                                
                          },
                          child: const Text('Confirm OTP'),
                        ),
                      )
                    : SizedBox(
                        width: currentWidth,
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              isOtpSent = true;
                            });

                            ref
                                .watch(authControllerProvider.notifier)
                                .signInWithPhone(
                                  context: context,
                                  ref: ref,
                                  phoneNumber: ref
                                      .watch(newUserOnboardingProvider.notifier)
                                      .state!
                                      .phone,
                                );
                          },
                          child: const Text('Request OTP'),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
