import 'package:bloc/bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:meta/meta.dart';

part 'single_service_provider_event.dart';
part 'single_service_provider_state.dart';

class SingleServiceProviderBloc
    extends Bloc<SingleServiceProviderEvent, SingleServiceProviderState> {
  final ServiceProviderDataSource serviceProviderDataSource;
  SingleServiceProviderBloc(this.serviceProviderDataSource)
      : super(SingleServiceProviderInitial()) {
    on<GetSingleServiceProvider>((event, emit) {
      //
    });
  }
}
