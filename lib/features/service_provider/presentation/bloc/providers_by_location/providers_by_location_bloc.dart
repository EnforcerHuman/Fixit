import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/domain/usecases/filter_provider_by_area.dart';
import 'package:meta/meta.dart';

part 'providers_by_location_event.dart';
part 'providers_by_location_state.dart';

class ProvidersByLocationBloc
    extends Bloc<ProvidersByLocationEvent, ProvidersByLocationState> {
  final GetProvidersWithinRadius getProvidersWithinRadius;
  ProvidersByLocationBloc(this.getProvidersWithinRadius)
      : super(ProvidersByLocationInitial()) {
    on<ProvidersByLocationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetProviderByLocation>((event, emit) async {
      //handling case where
      try {
        final providers = await getProvidersWithinRadius.execute(
          event.userLatitude,
          event.userLongitude,
          20,
        );
        if (providers.isEmpty) {
          emit(GetProvidersByLocationFailed());
        } else {
          emit(ProvidersByLocationLoaded(providers));
        }
      } catch (e) {
        emit(GetProvidersByLocationError());
      }
    });
  }
}
