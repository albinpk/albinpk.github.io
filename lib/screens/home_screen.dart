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
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                'Hi, I am',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
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

            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Text(
                'a passionate, self-taught Flutter developer.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            // Online profiles
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: const [
                  _ContactCard(
                    title: 'LinkedIn',
                    color: Colors.blue,
                    url: '',
                  ),
                  _ContactCard(
                    title: 'GitHub',
                    color: Colors.black,
                    url: '',
                  ),
                  _ContactCard(
                    title: 'Email',
                    color: Colors.redAccent,
                    url: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    Key? key,
    required this.title,
    required this.url,
    required this.color,
  }) : super(key: key);

  final String title;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 30,
        child: ColoredBox(
          color: color,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
