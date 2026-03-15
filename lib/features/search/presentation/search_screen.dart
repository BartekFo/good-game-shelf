import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/state/async_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/game_card.dart';
import '../state/search_notifier.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchNotifier});

  final SearchNotifier searchNotifier;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.searchNotifier,
      builder: (context, _) {
        final state = widget.searchNotifier.state;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                controller: _controller,
                onChanged: widget.searchNotifier.updateQuery,
                decoration: InputDecoration(
                  hintText: 'Search games...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            widget.searchNotifier.updateQuery('');
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.tune),
                          onPressed: () {},
                        ),
                ),
              ),
            ),
            Expanded(
              child: _buildContent(context, state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, SearchState state) {
    if (state.query.isEmpty) {
      return _buildInitialState(context);
    }

    return switch (state.results) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncEmpty() => _buildEmptyState(context),
      AsyncError(:final message) => _buildErrorState(context, message),
      AsyncData(:final data) => _buildResultsList(context, data),
    };
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Search for games',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Find games by title',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(BuildContext context, List games) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return GameCard(
          game: game,
          onTap: () => context.push('/game/${game.id}'),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No games found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Try a different search term',
            style: Theme.of(context).textTheme.bodySmall,
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
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => widget.searchNotifier.retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
