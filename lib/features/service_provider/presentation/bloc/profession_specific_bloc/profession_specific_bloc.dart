import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';
part 'profession_specific_event.dart';
part 'profession_specific_state.dart';

/// Bloc that manages the state of fetching service providers based on profession.
class ProfessionSpecificBloc
    extends Bloc<ProfessionSpecificEvent, ProfessionSpecificState> {
  final ServiceProviderDataSource serviceProviderDataSource;

  ProfessionSpecificBloc(this.serviceProviderDataSource)
      : super(ProfessionSpecificInitial()) {
    // Handle the FetchProvidersByProfession event.
    on<FetchProvidersByProfession>((event, emit) async {
      emit(
          ProfessionSpecificLoading()); // Emit loading state before starting the data fetch.

      try {
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
