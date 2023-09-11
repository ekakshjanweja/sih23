import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/features/home/controller/home_controller.dart';

class MessageBox extends ConsumerStatefulWidget {
  const MessageBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageBoxState();
}

class _MessageBoxState extends ConsumerState<MessageBox> {
  bool showSendButton = false;

  final TextEditingController messageController = TextEditingController();

  FocusNode focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
          //TextField

          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a message';
                }

                return null;
              },
              controller: messageController,
              focusNode: focusNode,
              onChanged: (value) {
                if (kDebugMode) {
                  print('value is: $value');
                }
                if (value.isNotEmpty) {
                  setState(() {
                    showSendButton = true;
                  });
                } else {
                  setState(() {
                    showSendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                filled: true,
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.only(
                  top: 25,
                  bottom: 25,
                  left: 28,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ref.read(homeControllerProvider).checkSpam(
                              context: context,
                              ref: ref,
                              message: messageController.text.trim(),
                            );

                        messageController.clear();
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
