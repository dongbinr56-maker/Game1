import 'package:flutter/material.dart';

import '../cafe_game.dart';

class HudOverlay extends StatelessWidget {
  static const overlayKey = 'HudOverlay';

  final CafeGame game;
  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.55),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: game.state.coins,
            builder: (_, coins, __) {
              return Text(
                'COIN: $coins',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
