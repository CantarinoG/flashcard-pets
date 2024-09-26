import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserStatsHeader extends StatelessWidget {
  const UserStatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return FutureBuilder<User?>(
      future: Provider.of<IJsonDataProvider<User>>(context).readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: double.infinity,
            height: 80,
            child: Loading(),
          );
        } else if (snapshot.hasError) {
          return const Text("Ocorreu algum erro. Tente novamente mais tarde.");
        } else if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          final int currentLevelXp = user.currentLevelXp;
          final int nextLevelXp = user.nextLevelXp;
          final double progress = ((currentLevelXp / nextLevelXp) > 1)
              ? 1
              : (currentLevelXp / nextLevelXp);

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Lvl ',
                          style: h4.copyWith(
                            color: secondary,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${user.level}', // Use user's level or fallback to mocked data
                          style: h3,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/custom_icons/coin.svg",
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        "${user.gold}", // Use user's gold or fallback to mocked data
                        style: h3,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: [
                      primary,
                      secondary,
                      const Color.fromARGB(255, 201, 201, 201),
                    ], stops: [
                      progress / 2,
                      progress,
                      progress,
                    ])),
                child: const SizedBox(height: 8),
              ),
            ],
          );
        } else {
          return const Text('No user data available.');
        }
      },
    );
  }
}
