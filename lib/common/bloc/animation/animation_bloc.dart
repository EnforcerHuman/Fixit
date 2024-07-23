import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animation_event.dart';
part 'animation_state.dart';

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  AnimationBloc() : super(AnimationInitial()) {
    on<AnimationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
