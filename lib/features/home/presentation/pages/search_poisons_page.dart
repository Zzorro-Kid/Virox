import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../injection_container.dart' as di;
import '../cubit/search_poisons/search_poisons_cubit.dart';
import '../cubit/search_poisons/search_poisons_state.dart';
import '../widgets/help_dialog.dart';
import '../widgets/initial_search_container.dart';
import '../widgets/search_poisons_app_bar.dart';
import '../widgets/search_poisons_history.dart';
import '../widgets/search_poisons_result_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SearchPoisonsCubit>()..loadSearchHistory(),
      child: BlocListener<SearchPoisonsCubit, SearchPoisonsState>(
        listener: (context, state) {
          if (state is SearchError) {
            _handleError(context, state);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          appBar: _buildAppBar(),
          body: _buildBody(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(67),
      child: SafeArea(
        child: Builder(
          builder: (context) {
            return SearchAppBar(
              controller: _searchController,
              onTextChanged: (query) =>
                  context.read<SearchPoisonsCubit>().onTextInput(query),
              onSearchSubmitted: (query) =>
                  context.read<SearchPoisonsCubit>().onSearchSubmit(query),
              onClearPressed: () =>
                  context.read<SearchPoisonsCubit>().resetSearch(),
              onHelpPressed: () => _showHelpDialog(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: BlocBuilder<SearchPoisonsCubit, SearchPoisonsState>(
        builder: (context, state) {
          switch (state) {
            case final SearchInitial searchInitialState:
              return _buildInitialView(context, searchInitialState);
            case SearchLoading _:
              return _buildLoadingView();
            case final SearchLoaded searchLoadedState:
              return SearchResultsList(
                results: searchLoadedState.results,
                searchQuery: searchLoadedState.query,
              );
            case SearchError _:
              return _buildNoResultsView();
          }
        },
      ),
    );
  }

  Widget _buildInitialView(BuildContext context, SearchInitial state) {
    final searchHistory = state.searchHistory;
    if (searchHistory.isEmpty) {
      return const InitialSearchContainer();
    } else {
      return _buildHistoryView(context, searchHistory);
    }
  }

  Widget _buildHistoryView(BuildContext context, List<String> history) {
    return SearchPoisonsHistory(
      searchHistory: history,
      onHistoryItemTap: (query) => _onHistoryItemTap(context, query),
    );
  }

  void _onHistoryItemTap(BuildContext context, String query) {
    _searchController.text = query;
    context.read<SearchPoisonsCubit>().onSearchSubmit(query);
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const HelpDialog());
  }

  void _handleError(BuildContext context, SearchError state) {
    final errorMessage = state.query;

    if (_isCriticalError(errorMessage)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMessage'),
          backgroundColor: AppColors.accent,
          action: SnackBarAction(
            label: 'Retry',
            textColor: AppColors.textOnDark,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  bool _isCriticalError(String message) {
    return message == 'Failed to load data' || message == 'Data not loaded';
  }

  Widget _buildLoadingView() {
    return Container(
      color: AppColors.background,
      child: const Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildNoResultsView() {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(AppDimensions.medium),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNotFoundIcon(),
          const SizedBox(width: AppDimensions.small),
          _buildNotFoundText(),
        ],
      ),
    );
  }

  Widget _buildNotFoundIcon() {
    return SvgPicture.asset(
      AppIcons.notFoundIcon,
      width: AppDimensions.iconSmall,
      height: AppDimensions.iconSmall,
      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    );
  }

  Widget _buildNotFoundText() {
    return Text(
      AppStrings.searchEmptyText,
      style: AppTextStyles.regularText.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
