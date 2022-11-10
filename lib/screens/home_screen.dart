import 'package:flutter/material.dart';

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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
              'ALBIN PK'.characters.map((e) => SingleCharacter(e)).toList(),
        ),
      ),
    );
  }
}
