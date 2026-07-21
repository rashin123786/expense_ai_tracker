part of 'navcontainer_bloc.dart';

@immutable
sealed class NavContainerEvent {}

class TabChanged extends NavContainerEvent {
  final int index;
  TabChanged(this.index);
}
