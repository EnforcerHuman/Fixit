import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';

part 'service_provider_event.dart';
part 'service_provider_state.dart';

class ServiceProviderBloc
    extends Bloc<ServiceProviderEvent, ServiceProviderState> {
  final ServiceProviderDataSource serviceProviderDataSource;
  // StreamSubscription? _providerSubscription;
  // StreamSubscription? _providerDetailsSubscription;
  ServiceProviderBloc(this.serviceProviderDataSource)
      : super(ServiceProviderInitial()) {
    on<GetServiceProvider>((event, emit) async {
      emit(ServiceProviderLoading());
      try {
        await emit.forEach<List<Map<String, dynamic>>>(
          serviceProviderDataSource.getServiceProvidersStream(),
          onData: (providers) => ServiceProviderLoaded(providers),
          onError: (error, stackTrace) =>
              ServiceProviderError(error.toString()),
        );
      } catch (error) {
        emit(ServiceProviderError(error.toString()));
      }
    });
  }
}
