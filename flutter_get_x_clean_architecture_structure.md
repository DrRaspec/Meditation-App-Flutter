# Deprecated: Use flutter_get_x_go_router_structure.md

> This file uses a bindings-heavy pattern.  
> For your current GoRouter setup, follow `flutter_get_x_go_router_structure.md`.

# Flutter + GetX + GoRouter Clean Structure (Reusable Blueprint)

This is a practical structure you can reuse across projects, including full feature examples (`HomeController`, `HomeBinding`, routes, and page wiring).

## Project Structure (Full Example)

```text
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── di/
│   │   ├── app_dependencies.dart
│   │   └── app_bindings.dart
│   ├── navigation/
│   │   ├── app_router.dart
│   │   ├── app_route_guards.dart
│   │   ├── go_router_refresh_stream.dart
│   │   ├── route_names.dart
│   │   └── route_paths.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── theme_service.dart
│   │   └── storage_service.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── app_typography.dart
│   ├── utils/
│   │   ├── app_logger.dart
│   │   └── validators.dart
│   └── widgets/
│       ├── app_button.dart
│       └── app_loading.dart
│
├── features/
│   ├── auth/
│   │   ├── bindings/
│   │   │   └── auth_binding.dart
│   │   ├── presentation/
│   │   │   ├── controllers/
│   │   │   │   └── login_controller.dart
│   │   │   ├── pages/
│   │   │   │   └── login_page.dart
│   │   │   └── widgets/
│   │   │       └── login_form.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       └── login_usecase.dart
│   │   └── data/
│   │       ├── models/
│   │       │   └── user_model.dart
│   │       ├── datasources/
│   │       │   ├── auth_local_data_source.dart
│   │       │   └── auth_remote_data_source.dart
│   │       └── repositories/
│   │           └── auth_repository_impl.dart
│   │
│   └── home/
│       ├── bindings/
│       │   └── home_binding.dart
│       ├── presentation/
│       │   ├── controllers/
│       │   │   └── home_controller.dart
│       │   ├── pages/
│       │   │   └── home_page.dart
│       │   └── widgets/
│       │       └── home_header.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── meditation_session_entity.dart
│       │   ├── repositories/
│       │   │   └── home_repository.dart
│       │   └── usecases/
│       │       └── get_home_data_usecase.dart
│       └── data/
│           ├── models/
│           │   └── meditation_session_model.dart
│           ├── datasources/
│           │   └── home_remote_data_source.dart
│           └── repositories/
│               └── home_repository_impl.dart
│
└── shared/
    ├── constants/
    │   ├── app_strings.dart
    │   └── app_sizes.dart
    └── extensions/
        └── context_extensions.dart
```

## Feature Template You Can Reuse

For every new feature (`profile`, `settings`, `player`, etc.):

```text
features/<feature_name>/
├── bindings/
│   └── <feature_name>_binding.dart
├── presentation/
│   ├── controllers/
│   │   └── <feature_name>_controller.dart
│   ├── pages/
│   │   └── <feature_name>_page.dart
│   └── widgets/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── data/
    ├── models/
    ├── datasources/
    └── repositories/
```

## Home Example (Controller + Binding)

```dart
// features/home/presentation/controllers/home_controller.dart
class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString greeting = 'Welcome back'.obs;

  void loadHome() {
    isLoading.value = true;
    // call use case here
    isLoading.value = false;
  }
}
```

```dart
// features/home/bindings/home_binding.dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
```

```dart
// features/home/presentation/pages/home_page.dart
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(controller.greeting.value));
  }
}
```

## How to Use Bindings with GoRouter

Because you use `go_router`, initialize bindings at route entry:

```dart
GoRoute(
  path: RoutePaths.home,
  name: RouteNames.home,
  builder: (context, state) {
    HomeBinding().dependencies();
    return const HomePage();
  },
)
```

This keeps page dependencies scoped and predictable.

## DI Strategy (Recommended)

- Global services in `core/di/app_dependencies.dart` (`AuthService`, `ThemeService`, storage).
- Feature controllers in each feature binding (`home_binding.dart`, `auth_binding.dart`).
- Avoid calling `Get.put()` inside page widgets.

## Rules for Long-Term Cleanliness

- `presentation` depends on `domain`, never directly on `data`.
- `domain` has no Flutter imports.
- `core` is shared infrastructure only (no feature-specific logic).
- Route guard logic stays in `core/navigation`.
- One source of truth for auth state (`AuthService.isLoggedIn`).

## Current App Migration Notes

Your app is already on the right path:

- `core/navigation` for router and route constants.
- `features/auth` and `features/home` for pages.
- `core/di/app_dependencies.dart` for startup registration.

Next incremental step:

1. Add `bindings/` and `controllers/` under each feature.
2. Convert pages to `GetView<FeatureController>`.
3. Move feature business logic from pages into controllers/usecases.

---

This blueprint stays simple for small apps and scales cleanly to medium/large apps.
