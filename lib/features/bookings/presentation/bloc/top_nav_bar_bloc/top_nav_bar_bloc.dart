import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'top_nav_bar_event.dart';
part 'top_nav_bar_state.dart';

class TopNavBarBloc extends Bloc<TopNavBarEvent, TopNavState> {
  TopNavBarBloc() : super(const TopNavState(0)) {
    on<NavigateToIndex>((event, emit) => emit(TopNavState(event.index)));
  }
}
