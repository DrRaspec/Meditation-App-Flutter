# Flutter GetX + GoRouter Clean Structure (No Bindings)

This is a reusable structure for projects that use:

- `go_router` for navigation
- `get` for DI/state
- `get_storage` for local persistence

## Why no `Bindings` here?

`Bindings` belong to GetX navigation (`GetMaterialApp` + `GetPage`).  
When you use `go_router`, keep route navigation in GoRouter and do DI with:

- global init (`core/di/app_dependencies.dart`)
- feature dependency functions called from route builders

---

## Recommended Structure

```text
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── di/
│   │   └── app_dependencies.dart
│   ├── navigation/
│   │   ├── app_router.dart
│   │   ├── go_router_refresh_stream.dart
│   │   ├── route_names.dart
│   │   └── route_paths.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── theme_service.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_theme.dart
│       └── app_typography.dart
│
└── features/
    ├── auth/
    │   ├── auth_dependencies.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── login_controller.dart
    │       └── pages/
    │           └── login_page.dart
    └── home/
        ├── home_dependencies.dart
        └── presentation/
            ├── controllers/
            │   └── home_controller.dart
            └── pages/
                └── home_page.dart
```

---

## Dependency Rules

- Global services: register once in `initAppDependencies()`
  - `AuthService`
  - `ThemeService`
- Feature controllers: register lazily in feature dependency files
  - `ensureAuthDependencies()`
  - `ensureHomeDependencies()`
- Router calls feature dependency functions in each `GoRoute.builder`.

---

## Router Pattern

```dart
GoRoute(
  path: RoutePaths.home,
  name: RouteNames.home,
  builder: (context, state) {
    ensureHomeDependencies();
    return const HomePage();
  },
)
```

This keeps page dependencies predictable without GetX bindings.

---

## Feature Template (Reusable)

For each new feature:

```text
features/<feature_name>/
├── <feature_name>_dependencies.dart
└── presentation/
    ├── controllers/
    │   └── <feature_name>_controller.dart
    └── pages/
        └── <feature_name>_page.dart
```

If the feature grows, add:

```text
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── data/
    ├── models/
    ├── datasources/
    └── repositories/
```

---

## Notes

- Use `GetView<Controller>` when the controller is guaranteed by feature dependency setup.
- Keep auth redirects in `core/navigation/app_router.dart`.
- Use route paths in redirects (not route names).
