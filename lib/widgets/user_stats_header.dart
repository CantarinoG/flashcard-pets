import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserStatsHeader extends StatelessWidget {
  //Mocked Data
  final _level = 10;
  final _gold = 200;
  final _progress = 0.67;

  const UserStatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Lvl $_level",
              style: h3,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/coin.svg",
                  width: 30,
                  height: 30,
                ),
                Text(
                  "$_gold",
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
                primaryColor,
                secondaryColor,
                const Color.fromARGB(255, 201, 201, 201),
              ], stops: [
                _progress / 2,
                _progress,
                _progress,
              ])),
          child: const SizedBox(height: 8),
        ),
      ],
    );
  }
}
