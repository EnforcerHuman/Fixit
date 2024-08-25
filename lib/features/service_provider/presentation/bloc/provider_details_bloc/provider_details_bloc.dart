import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';

part 'provider_details_event.dart';
part 'provider_details_state.dart';

class ProviderDetailsBloc
    extends Bloc<ProviderDetailsEvent, ProviderDetailsState> {
  final ServiceProviderDataSource serviceProviderDataSource;

  ProviderDetailsBloc(this.serviceProviderDataSource)
      : super(ProviderDetailsInitial()) {
    on<GetProviderDetails>((event, emit) async {
      emit(ProviderDetailsLoading());
      try {
        await emit.forEach<Map<String, dynamic>>(
          serviceProviderDataSource.getSingleProviderDetails(event.id),
          onData: (data) => ProviderDetailsLoaded(data),
          onError: (error, stackTrace) => ProviderDetailsError(),
        );
      } catch (e) {
        emit(ProviderDetailsError());
      }
    });
  }
}
