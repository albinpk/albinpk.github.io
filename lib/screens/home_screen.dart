import 'package:flutter/material.dart';

import '../widgets/single_character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
              'ALBIN PK'.characters.map((e) => SingleCharacter(e)).toList(),
        ),
      ),
    );
  }
}
