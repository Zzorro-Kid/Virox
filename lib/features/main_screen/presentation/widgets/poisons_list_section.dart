import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../cubit/main_screen_cubit.dart';
import '../cubit/main_screen_state.dart';
import 'poison_card_item.dart';

class PoisonsListSection extends StatelessWidget {
  final ScreenLayout screenLayout;

  const PoisonsListSection({super.key, required this.screenLayout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: AppDimensions.medium,
        bottom: AppDimensions.medium,
      ),
      decoration: const BoxDecoration(color: AppColors.surfaceBackground),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 12),
          _buildPoisonsCards(context),
          const SizedBox(height: 10),
          _buildLoadMoreButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      AppStrings.isThisPoison,
      style: AppTextStyles.h2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPoisonsCards(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        if (state is! MainScreenLoaded) {
          return const SizedBox.shrink();
        }
        final poisons = state.poisons;

        return SizedBox(
          height: screenLayout.getPoisonCardHeight(),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: AppDimensions.medium),
            itemCount: poisons.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return SizedBox(
                width: screenLayout.getPoisonCardWidth(),
                child: PoisonCardItem(
                  poison: poisons[index],
                  screenLayout: screenLayout,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadMoreButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildButtonText(),
      ),
    );
  }

  Text _buildButtonText() {
    return Text(
      AppStrings.loadMore,
      style: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}
