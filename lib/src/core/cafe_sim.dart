import 'cafe_state.dart';

class CafeSim {
  final CafeState state;

  CafeSim({required this.state});

  void tick1s() {
    state.coins.value += 1;
  }
}
