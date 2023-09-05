import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOTP extends ConsumerStatefulWidget {
  static const routeName = '/verify-otp';
  final String verificationId;

  const VerifyOTP({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends ConsumerState<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Verify OTP',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
