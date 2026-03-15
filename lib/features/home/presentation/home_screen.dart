import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/state/async_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/game_card.dart';
import '../state/home_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeNotifier});

  final HomeNotifier homeNotifier;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.homeNotifier.loadGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.homeNotifier,
      builder: (context, _) {
        final state = widget.homeNotifier.state;
        return RefreshIndicator(
          onRefresh: widget.homeNotifier.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Discover your next favorite game',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSection(
                  context,
                  title: 'Trending Now',
                  state: state.trendingGames,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSection(
                  context,
                  title: 'Popular Games',
                  state: state.popularGames,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSection(
                  context,
                  title: 'Recently Released',
                  state: state.recentlyReleasedGames,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required AsyncState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 260,
          child: _buildContent(context, state),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, AsyncState state) {
    return switch (state) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncEmpty() => _buildEmptyState(context),
      AsyncError(:final message) => _buildErrorState(context, message),
      AsyncData(:final data) => _buildGamesList(context, data),
    };
  }

  Widget _buildGamesList(BuildContext context, List games) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        cacheExtent: 500,
        itemCount: games.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final game = games[index];
          return GameCard(
            game: game,
            onTap: () => context.push('/game/${game.id}'),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'No games found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Failed to load games',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => widget.homeNotifier.refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
