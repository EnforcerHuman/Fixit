import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';
part 'provider_stats_event.dart';
part 'provider_stats_state.dart';

class ProviderStatsBloc extends Bloc<ProviderStatsEvent, ProviderStatsState> {
  final ServiceProviderDataSource serviceProviderDataSource;
  ProviderStatsBloc(this.serviceProviderDataSource)
      : super(ProviderStatsInitial()) {
    on<GetProviderStats>((event, emit) async {
      emit(ProiderStatsLoading());
      try {
        await emit.forEach<int>(
            serviceProviderDataSource.getProviderTotalBookings(event.id),
            onData: (count) {
              return ProviderStatsLoaded(count);
            },
            onError: (error, stackTrace) => ProiderStatsError());
      } catch (e) {
        emit(ProiderStatsError());
      }
    });
  }
}
