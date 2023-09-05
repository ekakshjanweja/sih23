import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/common/widgets/error_page.dart';
import 'package:sih_chatbot/common/widgets/loader.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/firebase_options.dart';
import 'package:sih_chatbot/common/theme/app_theme.dart';
import 'package:sih_chatbot/models/user_model.dart';
import 'package:sih_chatbot/router.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getUserData({
    required WidgetRef ref,
    required User data,
  }) async {
    userModel = await ref.read(authControllerProvider.notifier).getUserData();
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(
          data: (data) => MaterialApp.router(
            title: 'SIH ChatBot',
            theme: ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
              textTheme: lightTextTheme(context),
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
              useMaterial3: true,
              textTheme: darkTextTheme(context),
            ),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getUserData(ref: ref, data: data);
                  if (userModel != null) {
                    return loggedInRoute;
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorPage(
            errorText: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
