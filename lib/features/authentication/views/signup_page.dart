import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/features/authentication/views/verify_otp.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';
import 'package:sih_chatbot/models/user_model.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static const routeName = '/signup';
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  //Text Editing Controllers

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Details',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.03,
                  ),

                  //First Name Inputfield

                  TextFormField(
                    controller: firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
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

                  //Last Name Inputfield

                  TextFormField(
                    controller: lastNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
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

                  //Phone Inputfield

                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number must not be empty.';
                      }
                      if (value.length != 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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

                  //Birthday

                  Text(
                    'Bitrhday',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.03,
                  ),

                  //Day & Month

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: currentWidth * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Day',
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: currentWidth * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Month',
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: currentHeight * 0.03,
                  ),

                  //Year

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Year',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.08,
                  ),

                  //Continue Button

                  SizedBox(
                    width: currentWidth,
                    child: FilledButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final uid = const Uuid().v1();
                          String phoneNumber =
                              '+91${phoneController.text.trim()}';
                          UserModel userModel = UserModel(
                            name:
                                '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                            uid: uid,
                            phone: phoneNumber,
                          );

                          ref
                              .watch(newUserOnboardingProvider.notifier)
                              .update((state) => userModel);

                          Routemaster.of(context).push(VerifyOTP.routeName);
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
