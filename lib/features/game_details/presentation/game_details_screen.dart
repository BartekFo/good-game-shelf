import 'package:flutter/material.dart';

import '../../../core/models/rawg_game_details_dto.dart';
import '../../../core/state/async_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../home/data/discovery_repository.dart';
import '../state/game_details_notifier.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({
    super.key,
    this.gameId,
    required this.repository,
  });

  final String? gameId;
  final DiscoveryRepository repository;

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  late final GameDetailsNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = GameDetailsNotifier(widget.repository);
    if (widget.gameId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _notifier.loadGameDetails(widget.gameId!);
      });
    }
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gameId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Game not found')),
      );
    }

    return ListenableBuilder(
      listenable: _notifier,
      builder: (context, _) {
        return switch (_notifier.state) {
          AsyncLoading() => Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator()),
            ),
          AsyncEmpty() => Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Game not found')),
            ),
          AsyncError(:final message) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Failed to load game details',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton.icon(
                        onPressed: _notifier.retry,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          AsyncData(:final data) => _buildDetails(context, data),
        };
      },
    );
  }

  Widget _buildDetails(BuildContext context, RawgGameDetailsDto game) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            leading: Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: BackButton(color: AppColors.onPrimary),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                game.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: game.backgroundImage != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          game.backgroundImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildHeroPlaceholder(),
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black54,
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : _buildHeroPlaceholder(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMetaRow(context, game),
                if (game.platforms.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Platforms',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: game.platforms
                        .map((p) => Chip(label: Text(p)))
                        .toList(),
                  ),
                ],
                if (game.genres.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Genres',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: game.genres
                        .map((g) => Chip(label: Text(g)))
                        .toList(),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  game.description ?? 'No description available.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.library_add_outlined),
                    label: const Text('Add to Library'),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(BuildContext context, RawgGameDetailsDto game) {
    return Row(
      children: [
        if (game.rating != null) ...[
          const Icon(Icons.star_rounded, size: 20, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            game.rating!.toStringAsFixed(1),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        if (game.released != null) ...[
          const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            game.released!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildHeroPlaceholder() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: Center(
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.onPrimary.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: const Icon(
            Icons.sports_esports_rounded,
            size: 54,
            color: AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
