# 00_BOOTSTRAP — 프로젝트 부트스트랩 가이드

본 리포의 Flutter/Flame 프로젝트를 바로 실행할 수 있도록, 고정 스펙과 파일 트리, 체크리스트, 필수 로그 항목을 정리했습니다. 이미 생성된 기본 구조에 맞춰 바로 적용/확장할 수 있습니다.

## 1) 필수 스펙(고정)
- 타일 크기: **16px**
- 가상 해상도: **288×512** (18×32 타일, 9:16 비율)
- 뷰포트: **FixedResolutionViewport** / `CameraComponent.withFixedResolution(288, 512)`
- 시뮬레이션 틱: **1초**
- 오프라인 정산 cap: **12h**
- 스케일링: **Nearest Neighbor** (`FilterQuality.none`)

## 2) 의존성(pubspec.yaml)
최신 안정 버전 기준으로 아래 패키지를 포함합니다.
- `flame`
- `flame_tiled`
- (저장용) `shared_preferences`

## 3) 에셋 등록(pubspec.yaml)
다음 폴더를 에셋 경로로 등록합니다.
- `assets/maps/`
- `assets/sprites/`
- `assets/ui/`
- `assets/fonts/`
- (기존 호환용) `assets/images/tiles/`, `assets/images/sprites/`

## 4) 최소 파일 트리(권장)
현재 리포 구조는 아래와 같이 시작되었습니다. 동일한 스펙으로 확장하면 됩니다.
```
lib/
  main.dart
  src/
    cafe_game.dart            # 고정 해상도 카메라 + TMX 로드 + 1초 틱
    core/
      cafe_state.dart         # 코인 상태(ValueNotifier)
      cafe_sim.dart           # 1초 틱 시뮬레이터(코인 증가 + 로그 스텁)
    ui/
      hud_overlay.dart        # 상단 코인 HUD (Flutter 오버레이)
assets/
  maps/
    cafe_01.tmx               # 18×32, 16px 타일 맵 (tileset inline)
  images/
    tiles/
  sprites/
  ui/
  fonts/
```

## 5) 개발 중 필수 로그(우선 스텁 포함)
- **매 1초 틱**: `queueLen`, `brewBacklog`, `cashierBacklog`, `coinsPerMin`, `bottleneck`
- **오프라인 정산 시**: `elapsedMin`, `offlineCoins`, `capMin` 적용 결과

현재 `cafe_sim.dart`에서 1초 틱 로그 스텁이 동작하며, 차후 실제 처리량/병목 계산을 연결하면 됩니다.

## 6) 즉시 실행 체크리스트 (현재 리포 반영 상태)
- [x] 세로 고정(`SystemChrome.setPreferredOrientations`)
- [x] 가상 해상도 288×512 고정 카메라
- [x] TMX 맵 로드(`assets/maps/cafe_01.tmx`)
- [x] 1초마다 코인 증가 + HUD 표기
- [x] Nearest Neighbor 필터 적용(`FilterQuality.none`)

## 7) 다음 확장 순서(추천)
1. 손님 스폰/대기열/제조/결제 상태 머신 추가
2. 병목 계산(`min(스폰, 제조, 결제, 좌석)`) 후 `coinsPerMin` 반영
3. 업그레이드 4종(좌석/제조/결제/직원) + 가격 곡선 적용
4. 오프라인 정산(12h cap) + 팝업 UI
5. 로그 필드를 실제 값으로 연결하고 HUD/디버그 표시에 활용
