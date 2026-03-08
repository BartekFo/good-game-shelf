import 'package:flutter/material.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({super.key, this.gameId});

  final String? gameId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Details')),
      body: Center(
        child: Text('Game Details Placeholder ${gameId ?? ''}'.trim()),
      ),
    );
  }
}
