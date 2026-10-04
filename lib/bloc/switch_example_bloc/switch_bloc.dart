

import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/switch_example_bloc/switch_events.dart';
import 'package:bloc_counter_app/bloc/switch_example_bloc/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvents,SwitchStates>{

  SwitchBloc():super(SwitchStates()){
   on<UnableOrDisableNotification>(_unableOrDisableNotification);
   on<SliderEvent>(_slider);
  }
   void _unableOrDisableNotification(
       UnableOrDisableNotification event, Emitter<SwitchStates> emit) {
     emit(state.copyWith(isSwitch:!state.isSwitch));
   }

  void _slider(
      SliderEvent event, Emitter<SwitchStates> emit) {
    emit(state.copyWith(slider: event.slider));
  }

}