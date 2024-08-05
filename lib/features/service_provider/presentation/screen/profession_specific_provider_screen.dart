// import 'package:fixit/features/service_provider/presentation/bloc/profession_specific_bloc/profession_specific_bloc.dart';
// import 'package:fixit/features/service_provider/presentation/widgets/provider_grid_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfessionSpecificProviderScreen extends StatelessWidget {
//   final String profession;

//   const ProfessionSpecificProviderScreen({Key? key, required this.profession})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('$profession Providers')),
//       body: SafeArea(
//           child: BlocBuilder<ProfessionSpecificBloc, ProfessionSpecificState>(
//         builder: (context, state) {
//           if (state is ProfessionSpecificInitial) {
//             context
//                 .read<ProfessionSpecificBloc>()
//                 .add(FetchProvidersByProfession(profession));
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProfessionSpecificLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProfessionSpecificLoaded) {
//             return ProfessionSpecificProviderList(profession: profession);
//           } else if (state is ProfessionSpecificError) {
//             return Center(child: Text('Error: ${state.message}'));
//           } else {
//             return const Center(child: Text('Unexpected state'));
//           }
//         },
//       )),
//     );
//   }
// }

// class ProfessionSpecificProviderList extends StatelessWidget {
//   final String profession;

//   const ProfessionSpecificProviderList({super.key, required this.profession});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfessionSpecificBloc, ProfessionSpecificState>(
//       builder: (context, state) {
//         if (state is ProfessionSpecificInitial) {
//           context
//               .read<ProfessionSpecificBloc>()
//               .add(FetchProvidersByProfession(profession));
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ProfessionSpecificLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ProfessionSpecificLoaded) {
//           return ProviderGridWidget(providers: state.providers);
//         } else if (state is ProfessionSpecificError) {
//           return Center(child: Text('Error: ${state.message}'));
//         } else {
//           return const Center(child: Text('Unexpected state'));
//         }
//       },
//     );
//   }

//   void _navigateToProviderDetails(
//       BuildContext context, Map<String, dynamic> provider) {
//     // TODO: Implement navigation to provider details
//   }
// }

//******************************************88888888888888888888888888888888888888888888888 */

import 'package:fixit/features/service_provider/presentation/bloc/profession_specific_bloc/profession_specific_bloc.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionSpecificProviderScreen extends StatelessWidget {
  final String profession;
  const ProfessionSpecificProviderScreen({super.key, required this.profession});

  @override
  Widget build(BuildContext context) {
    context
        .read<ProfessionSpecificBloc>()
        .add(FetchProvidersByProfession(profession));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  BlocBuilder<ProfessionSpecificBloc, ProfessionSpecificState>(
                builder: (context, state) {
                  if (state is ProfessionSpecificLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfessionSpecificLoaded &&
                      state.providers.isNotEmpty) {
                    return ListView.builder(
                      itemCount: (state.providers.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildProviderCard(
                                  state.providers, index * 2),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: index * 2 + 1 < state.providers.length
                                  ? _buildProviderCard(
                                      state.providers, index * 2 + 1)
                                  : Container(),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is ProfessionSpecificLoaded &&
                      state.providers.isEmpty) {
                    return const Center(
                      child: Text('no provider available'),
                    );
                  } else if (state is ProfessionSpecificError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderCard(List<Map<String, dynamic>> providers, int index) {
    return SizedBox(
      height: 230, // Adjust this height as needed
      child: ServiceProviderCard(
        name: providers[index]['name'],
        profession: profession,
        imageUrl: providers[index]['profileImage'],
        rating: providers[index]['rating'],
        onDetailsPressed: () {},
      ),
    );
  }
}