import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_shell.dart';
import '../../features/game_details/presentation/game_details_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return AppShell(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) {
                  return homeBranchRoot;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.search,
                builder: (BuildContext context, GoRouterState state) {
                  return searchBranchRoot;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.library,
                builder: (BuildContext context, GoRouterState state) {
                  return libraryBranchRoot;
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.gameDetails,
        builder: (BuildContext context, GoRouterState state) {
          return GameDetailsScreen(
            gameId: state.pathParameters['id'],
            repository: discoveryRepository,
          );
        },
      ),
    ],
  );
}
