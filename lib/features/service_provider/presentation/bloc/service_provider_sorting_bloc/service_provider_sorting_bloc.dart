import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/domain/usecases/sort_service_providers.dart';
import 'package:meta/meta.dart';

part 'service_provider_sorting_event.dart';
part 'service_provider_sorting_state.dart';

class ServiceProviderSortingBloc
    extends Bloc<ServiceProviderSortingEvent, ServiceProviderSortingState> {
  ServiceProviderSortingBloc() : super(ServiceProviderSortingInitial()) {
    on<ServiceProviderSortRequested>((event, emit) {
      SortServiceProviders sortServiceProviders = SortServiceProviders();
      if (event.sortingCriteria == 'price low to high') {
        final List<Map<String, dynamic>> sortedproviders =
            sortServiceProviders.sortByHourlyPay(event.providers);
        emit(ServiceProviderSorted(sortedproviders));
      }
    });
  }
}
