part of 'navcontainer_bloc.dart';

@immutable
sealed class NavcontainerState {}

final class NavcontainerInitial extends NavcontainerState {}

class NavContainerState extends NavcontainerState {
  final int selectedIndex;
  NavContainerState({this.selectedIndex = 0});
}
