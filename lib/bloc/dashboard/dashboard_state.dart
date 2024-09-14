import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../models/dashboard/pi_dashboard_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class LoginSuccessState extends DashboardState {
  final String userId;
  final String partyId;
  final String partyName;
  final String serviceUrl;

  const LoginSuccessState({
    required this.userId,
    required this.partyId,
    required this.partyName,
    required this.serviceUrl,
  });

  @override
  List<Object> get props => [userId, partyId, partyName, serviceUrl];
}

class DashboardPISuccessState extends DashboardState {
  final List<PiDetail> dashboardList;

  const DashboardPISuccessState({required this.dashboardList});

  @override
  List<Object> get props => [dashboardList];
}

// class NavigateToPIDetailScreenState extends DashboardState {
//   final String preInspectionId;
//   final bool isHitApi;

//   const NavigateToPIDetailScreenState(
//       {required this.preInspectionId, required this.isHitApi});

//   @override
//   List<Object> get props => [preInspectionId, isHitApi];
// }

class LocationFetchedAndNavigateState extends DashboardState {
  final Position position;
  final Placemark place;
  final bool isOwnFlow;
  final bool isOtherFlow;
  final bool isHitApi;

  const LocationFetchedAndNavigateState({
    required this.position,
    required this.place,
    required this.isOwnFlow,
    required this.isOtherFlow,
    required this.isHitApi,
  });

  @override
  List<Object?> get props =>
      [position, place, isOwnFlow, isOtherFlow, isHitApi];
}

class LocationPermissionDeniedState extends DashboardState {
  final String error;

  const LocationPermissionDeniedState(this.error);

  @override
  List<Object?> get props => [error];
}

class DashboardFailureState extends DashboardState {
  final String error;

  const DashboardFailureState(this.error);

  @override
  List<Object> get props => [error];
}
