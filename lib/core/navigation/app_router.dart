import 'package:go_router/go_router.dart';
import 'package:meditation_app/app/app_shell.dart';
import 'package:meditation_app/core/services/auth_service.dart';
import 'package:meditation_app/features/auth/auth_dependencies.dart';
import 'package:meditation_app/features/auth/presentation/pages/auth_welcome_page.dart';
import 'package:meditation_app/features/auth/presentation/pages/login_page.dart';
import 'package:meditation_app/features/auth/presentation/pages/register_page.dart';
import 'package:meditation_app/features/home/home_dependencies.dart';
import 'package:meditation_app/features/home/presentation/pages/home_page.dart';
import 'package:meditation_app/core/navigation/go_router_refresh_stream.dart';
import 'package:meditation_app/core/navigation/route_names.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';

GoRouter createRouter(AuthService authService) {
  return GoRouter(
    initialLocation: RoutePaths.authWelcome,
    refreshListenable: GoRouterRefreshStream(authService.isLoggedIn.stream),
    redirect: (context, state) {
      final isLoggedIn = authService.isLoggedIn.value;
      final isOnAuth = state.matchedLocation.startsWith('/auth');

      if (isOnAuth && isLoggedIn) return RoutePaths.home;
      if (!isOnAuth && !isLoggedIn) return RoutePaths.authWelcome;
      return null;
    },
    routes: [
      // PRE-AUTH
      GoRoute(
        path: RoutePaths.authWelcome,
        name: RouteNames.authWelcome,
        builder: (context, state) {
          ensureAuthDependencies();
          return const AuthWelcomePage();
        },
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) {
          ensureAuthDependencies();
          return const LoginPage();
        },
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) {
          ensureAuthDependencies();
          return const RegisterPage();
        },
      ),

      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            builder: (context, state) {
              ensureHomeDependencies();
              return const HomePage();
            },
          ),
        ],
      ),
    ],
  );
}
