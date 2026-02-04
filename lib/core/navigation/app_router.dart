import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/services/auth_service.dart';
import 'package:meditation_app/features/auth/auth_dependencies.dart';
import 'package:meditation_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:meditation_app/features/home/home_dependencies.dart';
import 'package:meditation_app/features/home/presentation/pages/home_page.dart';
import 'package:meditation_app/core/navigation/go_router_refresh_stream.dart';
import 'package:meditation_app/core/navigation/route_names.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';

GoRouter createRouter(AuthService authService) {
  return GoRouter(
    initialLocation: RoutePaths.welcome,
    refreshListenable: GoRouterRefreshStream(authService.isLoggedIn.stream),
    redirect: (context, state) {
      final isLoggedIn = authService.isLoggedIn.value;
      final isOnWelcome = state.matchedLocation == RoutePaths.welcome;

      if (isOnWelcome && isLoggedIn) {
        return RoutePaths.home;
      }
      if (!isOnWelcome && !isLoggedIn) {
        return RoutePaths.welcome;
      }
      return null;
    },
    routes: [
      // PRE-AUTH
      GoRoute(
        path: RoutePaths.welcome,
        name: RouteNames.welcome,
        builder: (context, state) {
          ensureAuthDependencies();
          return const WelcomePage();
        },
      ),

      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) {
          ensureHomeDependencies();
          return const HomePage();
        },
      ),
    ],
  );
}
