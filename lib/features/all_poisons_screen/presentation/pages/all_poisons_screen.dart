import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../injection_container.dart';
import '../../../search_screen/domain/entities/poison_data.dart';
import '../cubit/all_poisons_cubit.dart';
import '../cubit/all_poisons_state.dart';
import '../widgets/all_poisons_card_item.dart';
import '../widgets/all_poisons_search_field.dart';

class AllPoisonsScreenPage extends StatefulWidget {
  const AllPoisonsScreenPage({super.key});

  @override
  State<AllPoisonsScreenPage> createState() => _AllPoisonsScreenPageState();
}

class _AllPoisonsScreenPageState extends State<AllPoisonsScreenPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllPoisonsCubit>(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: AppColors.primary,
          child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Scaffold(
              appBar: _buildAppBar(),
              backgroundColor: AppColors.background,
              body: _buildBody(context),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'All Poisons',
        style: AppTextStyles.h2.copyWith(color: AppColors.background),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<AllPoisonsCubit, AllPoisonsState>(
        builder: (context, state) {
          return switch (state) {
            AllPoisonsLoading() => UiUtils.buildLoadingIndicator(),
            AllPoisonsError() => Center(child: Text(state.message)),
            AllPoisonsLoaded() => _buildLoadedContent(state),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildLoadedContent(AllPoisonsLoaded state) {
    final screenLayout = ScreenLayoutHelper.getScreenLayout(context);

    return Column(
      children: [
        const AllPoisonsSearchField(),
        Expanded(
          child: state.poisons.isEmpty
              ? _buildEmptyState()
              : _buildPoisonsListResult(state.poisons, screenLayout),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNotFoundIcon(),
        const SizedBox(width: AppDimensions.small),
        _buildNotFoundText(),
      ],
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

  Widget _buildPoisonsListResult(
    List<PoisonData> poisons,
    ScreenLayout screenLayout,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: poisons.length,
      itemBuilder: (context, index) {
        final poison = poisons[index];
        return AllPoisonsCardItem(
          poison: poison,
          screenLayout: screenLayout,
          onTap: () => _openPoisonDetails(context, poison),
        );
      },
    );
  }

  void _openPoisonDetails(BuildContext context, dynamic poison) {}
}
