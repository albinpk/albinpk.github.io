import 'package:flutter/material.dart';

import '../constants.dart';
import '../data/projects.dart';
import '../widgets/single_character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Remove this
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "This webpage is under development.",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.redAccent,
              ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Text(
                'Hi, I am',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            // ALBIN PK
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < kMyName.length; i++)
                  i < projects.length
                      ? SingleCharacter(i)
                      : Text(
                          kMyName[i],
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Colors.grey),
                        ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text('a passionate, self-taught Flutter developer.'),
            ),
          ],
        ),
      ),
    );
  }
}
