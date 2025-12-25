import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'core/cafe_sim.dart';
import 'core/cafe_state.dart';

class CafeGame extends FlameGame {
  static const double vw = 288;
  static const double vh = 512;
  static const double tilePx = 16;

  final CafeState state = CafeState();
  late final CafeSim sim;

  CafeGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: vw,
            height: vh,
          ),
        );

  double _acc = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Ensure pixel art stays crisp (Nearest Neighbor).
    images.setFilterQuality(FilterQuality.none);

    final world = World();
    this.world = world;
    camera.world = world;

    final tiled = await TiledComponent.load(
      'cafe_01.tmx',
      Vector2.all(tilePx),
    );
    world.add(tiled);

    sim = CafeSim(state: state);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _acc += dt;
    if (_acc >= 1.0) {
      _acc -= 1.0;
      sim.tick1s();
    }
  }
}
