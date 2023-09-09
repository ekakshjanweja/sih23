import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sih_chatbot/core/api.dart';
import 'package:sih_chatbot/core/failure.dart';
import 'package:sih_chatbot/core/type_defs.dart';
import 'package:sih_chatbot/features/home/controller/home_controller.dart';
import 'package:sih_chatbot/models/spam_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(),
);

class HomeRepository {
  final Api _api = Api();

  //Start Listening

  void startListening({
    required WidgetRef ref,
  }) async {
    try {
      SpeechToText speechToTextInstance = SpeechToText();

      if (!ref.read(isListeningProvider.notifier).state) {
        bool available = await speechToTextInstance.initialize();

        if (available) {
          ref.read(isListeningProvider.notifier).update((state) => true);

          speechToTextInstance.listen(
            onResult: (result) =>
                ref.read(speechToTextProvider.notifier).update(
                      (state) => result.recognizedWords,
                    ),
          );
        }
      } else {
        speechToTextInstance.stop();

        ref.read(isListeningProvider.notifier).update(
              (state) => false,
            );
      }
    } catch (e) {
      rethrow;
    }
  }

  //Check Spam

  FutureEither<SpamModel> checkSpam({
    required WidgetRef ref,
    required String message,
  }) async {
    try {
      final accessToken = dotenv.env['ACCESS_TOKEN'];

      Response response = await _api.sendRequest.post('/spam-detector/', data: {
        "access": accessToken,
        "message": message,
      });

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      SpamModel spamModel = SpamModel.fromMap(apiResponse.data);

      return right(spamModel);
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }
}
