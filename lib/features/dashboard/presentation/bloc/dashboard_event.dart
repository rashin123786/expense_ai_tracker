part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class LoadDashboard extends DashboardEvent {}
