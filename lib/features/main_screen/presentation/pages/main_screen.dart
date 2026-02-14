import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../injection_container.dart';
import '../cubit/main_screen_cubit.dart';
import '../cubit/main_screen_state.dart';
import '../widgets/first_aid_section.dart';
import '../widgets/external_resources_section.dart';
import '../widgets/poisons_list_section.dart';
import '../widgets/search_bar_section.dart';
import '../widgets/top_help_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainScreenCubit>()..loadAllPoisons(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: AppColors.primary,
          child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: AppColors.primary,
              body: _buildBody(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          return switch (state) {
            MainScreenLoading() => UiUtils.buildLoadingIndicator(),
            MainScreenError() => Center(child: Text(state.message)),
            MainScreenLoaded() => _buildLoadedContent(state),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildLoadedContent(MainScreenLoaded state) {
    final screenLayout = ScreenLayoutHelper.getScreenLayout(context);

    return ListView(
      children: [
        TopHelpBar(screenLayout: screenLayout),
        const SearchBarSection(),
        const SizedBox(height: 16),
        FirstAidSection(screenLayout: screenLayout),
        PoisonsListSection(screenLayout: screenLayout),
        const MoreServicesSection(),
      ],
    );
  }
}
