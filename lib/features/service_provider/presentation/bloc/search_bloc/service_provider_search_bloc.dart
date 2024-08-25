import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_search.dart';
import 'package:meta/meta.dart';

part 'service_provider_search_event.dart';
part 'service_provider_search_state.dart';

class ServiceProviderSearchBloc
    extends Bloc<ServiceProviderSearchEvent, ServiceProviderSearchState> {
  final ServiceProviderSearchDataSource serviceProviderSearchDataSource;
  ServiceProviderSearchBloc(this.serviceProviderSearchDataSource)
      : super(ServiceProviderSearchInitial()) {
    on<ServiceProviderSearch>((event, emit) async {
      ///
      try {
        List<Map<String, dynamic>> providers =
            await serviceProviderSearchDataSource
                .searchServiceProviders(event.query);
        emit(SearchCompleted(providers));
      } catch (e) {
        //handle exception
      }
    });
  }
}
