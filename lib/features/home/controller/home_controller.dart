import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/common/utils/utils.dart';
import 'package:sih_chatbot/features/home/repository/home_repository.dart';
import 'package:sih_chatbot/features/home/views/ticket_generation.dart';
import 'package:sih_chatbot/models/spam_model.dart';

final isListeningProvider = StateProvider<bool>((ref) => false);

final spamModelProvider = StateProvider<SpamModel>(
  (ref) => SpamModel(spam: false, probability: 0),
);

final speechToTextProvider = StateProvider<String?>((ref) => null);

final grievanceProvider = StateProvider<String?>((ref) => null);

final homeControllerProvider = Provider<HomeController>(
  (ref) => HomeController(
    homeRepository: ref.read(homeRepositoryProvider),
  ),
);

class HomeController {
  final HomeRepository _homeRepository;

  HomeController({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  //Start Listening

  void startListening({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      _homeRepository.startListening(
        ref: ref,
      );

      checkSpam(
        message: ref.read(speechToTextProvider)!,
        ref: ref,
        context: context,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //Check Spam

  void checkSpam({
    required BuildContext context,
    required WidgetRef ref,
    required String message,
  }) async {
    final res = await _homeRepository.checkSpam(
      message: message,
      ref: ref,
    );

    res.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) {
        ref.read(spamModelProvider.notifier).update((state) => r);

        if (!ref.read(spamModelProvider).spam) {
          ref
              .read(grievanceProvider.notifier)
              .update((state) => ref.read(speechToTextProvider));
          Routemaster.of(context).push(TicketGeneration.routeName);
        }

        ref.read(speechToTextProvider.notifier).update((state) => null);
      },
    );
  }
}
