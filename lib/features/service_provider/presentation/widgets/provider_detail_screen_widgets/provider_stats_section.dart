import 'package:fixit/features/service_provider/presentation/bloc/bloc/provider_stats_bloc.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderStatsSection extends StatelessWidget {
  final Map<String, dynamic> providerDetails;

  const ProviderStatsSection({super.key, required this.providerDetails});

  @override
  Widget build(BuildContext context) {
    // context
    //     .read<ProviderStatsBloc>()
    //     .add(GetProviderStats(providerDetails['id']));
    return BlocBuilder<ProviderStatsBloc, ProviderStatsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<ProviderStatsBloc, ProviderStatsState>(
              builder: (context, state) {
                return ProviderInfoItem(
                    icon: Icons.check_circle_outline,
                    value: state is ProviderStatsLoaded
                        ? state.count.toString()
                        : '0',
                    label: 'Completed');
              },
            ),
            ProviderInfoItem(
                icon: Icons.access_time,
                value: providerDetails['experience'],
                label: 'Experience'),
          ],
        );
      },
    );
  }
}
