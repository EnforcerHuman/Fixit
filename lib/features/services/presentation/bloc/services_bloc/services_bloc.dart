import 'package:bloc/bloc.dart';
import 'package:fixit/features/services/data/data_sources/service_remote_repository.dart';
import 'package:fixit/features/services/data/model/services_model.dart';
import 'package:meta/meta.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServiceRemoteRepository serviceRemoteRepository;
  ServicesBloc(this.serviceRemoteRepository) : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetServices>((event, emit) async {
      emit(ServicesLoading());
      try {
        await emit.forEach<List<ServicesModel>>(
            serviceRemoteRepository.getServices(),
            onData: (Services) => ServicesLoaded(Services));
        onError(error, stackTrace) => ServicesError(error.toString());
      } catch (e) {
        emit(ServicesError(e.toString()));
      }
    });
  }
}
