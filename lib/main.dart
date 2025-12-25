import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/cafe_game.dart';
import 'src/ui/hud_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final game = CafeGame();

  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        HudOverlay.overlayKey: (context, game) =>
            HudOverlay(game: game as CafeGame),
      },
      initialActiveOverlays: const [HudOverlay.overlayKey],
    ),
  );
}
