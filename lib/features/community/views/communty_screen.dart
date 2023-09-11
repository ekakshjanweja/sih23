import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/features/community/widgets/grievance_type_card.dart';
import 'package:sih_chatbot/features/home/views/home_page.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';

class CommunityScreen extends ConsumerWidget {
  static const routeName = '/community';
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              Assets.images.orb.path,
              scale: 4,
            ),
            Text(ref.watch(userProvider)!.name)
          ],
        ),
        centerTitle: false,
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
          child: Center(
            child: Column(
              children: [
                //Title

                Text(
                  'Total Cases Filled',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: currentWidth * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 5,
                      width: currentWidth * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  '50,203',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //Bottom Container

                Container(
                  width: currentWidth,
                  height: currentHeight * 0.68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        transform: const GradientRotation(45),
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //Top Row

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Goals',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Routemaster.of(context)
                                  .popUntil((routeData) => false);

                              Routemaster.of(context).push(HomePage.routeName);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('File Greivance'),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: currentHeight * 0.03,
                      ),

                      //Top Grievances this week

                      Text(
                        'Top Grievances this week',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      //Cards

                      GrievanceTypeCard()
                    ],
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
