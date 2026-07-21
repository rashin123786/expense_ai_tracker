import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navcontainer_event.dart';
part 'navcontainer_state.dart';

class NavContainerBloc extends Bloc<NavContainerEvent, NavContainerState> {
  NavContainerBloc() : super(NavContainerState(selectedIndex: 0)) {
    on<TabChanged>((event, emit) {
      emit(NavContainerState(selectedIndex: event.index));
    });
  }
}
