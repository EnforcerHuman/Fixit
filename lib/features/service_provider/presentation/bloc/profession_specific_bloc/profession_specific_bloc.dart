// import 'package:bloc/bloc.dart';
// import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
// import 'package:meta/meta.dart';

// part 'profession_specific_event.dart';
// part 'profession_specific_state.dart';

// class ProfessionSpecificBloc
//     extends Bloc<ProfessionSpecificEvent, ProfessionSpecificState> {
//   final ServiceProviderDataSource serviceProviderDataSource;

//   ProfessionSpecificBloc(this.serviceProviderDataSource)
//       : super(ProfessionSpecificInitial()) {
//     on<FetchProvidersByProfession>((event, emit) async {
//       emit(ProfessionSpecificLoading());
//       try {
//         await emit.forEach<List<Map<String, dynamic>>>(
//             serviceProviderDataSource.getProviderByProfession(event.query),
//             onData: (data) => ProfessionSpecificLoaded(data));
//         onError(error, stackTrace) => ProfessionSpecificError(error);
//       } catch (e) {
//         emit(ProfessionSpecificError(e.toString()));
//       }
//     });
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';

part 'profession_specific_event.dart';
part 'profession_specific_state.dart';

/// Bloc that manages the state of fetching service providers based on profession.
class ProfessionSpecificBloc
    extends Bloc<ProfessionSpecificEvent, ProfessionSpecificState> {
  final ServiceProviderDataSource serviceProviderDataSource;

  /// Constructs a [ProfessionSpecificBloc] with the given [serviceProviderDataSource].
  ///
  /// [serviceProviderDataSource] is used to fetch provider data based on profession.
  ProfessionSpecificBloc(this.serviceProviderDataSource)
      : super(ProfessionSpecificInitial()) {
    // Handle the FetchProvidersByProfession event.
    on<FetchProvidersByProfession>((event, emit) async {
      emit(
          ProfessionSpecificLoading()); // Emit loading state before starting the data fetch.

      try {
        // Listen for updates from the data source and emit states accordingly.
        await emit.forEach<List<Map<String, dynamic>>>(
          serviceProviderDataSource.getProviderByProfession(event.query),
          onData: (data) => ProfessionSpecificLoaded(data),
        );
      } catch (error, stackTrace) {
        // Emit an error state if data fetch fails.
        emit(ProfessionSpecificError(error.toString()));
      }
    });
  }
}
