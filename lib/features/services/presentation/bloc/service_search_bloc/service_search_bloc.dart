import 'package:bloc/bloc.dart';
import 'package:fixit/features/services/data/data_sources/service_remote_repository.dart';
import 'package:fixit/features/services/data/model/services_model.dart';
import 'package:meta/meta.dart';

part 'service_search_event.dart';
part 'service_search_state.dart';

class ServiceSearchBloc extends Bloc<ServiceSearchEvent, ServiceSearchState> {
  final ServiceRemoteRepository serviceRemoteRepository;
  ServiceSearchBloc(this.serviceRemoteRepository)
      : super(ServiceSearchInitial()) {
    on<SearchService>((event, emit) async {
      //
      try {
        List<ServicesModel> services =
            await serviceRemoteRepository.searchService(event.query);
        emit(ServiceSearchCompleted(services));
      } catch (e) {
        emit(ServiceSearchError());
      }
    });
  }
}
