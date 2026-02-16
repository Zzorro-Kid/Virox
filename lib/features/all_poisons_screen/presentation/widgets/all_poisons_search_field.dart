import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search_screen/presentation/widgets/search_poisons_app_bar.dart';
import '../cubit/all_poisons_cubit.dart';

class AllPoisonsSearchField extends StatelessWidget {
  const AllPoisonsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      autofocus: false,
      onTextChanged: (query) {
        context.read<AllPoisonsCubit>().searchPoisons(query);
      },
      onSearchSubmitted: (query) {
        context.read<AllPoisonsCubit>().searchPoisons(query);
      },
      onClearPressed: () {
        context.read<AllPoisonsCubit>().searchPoisons('');
      },
    );
  }
}
