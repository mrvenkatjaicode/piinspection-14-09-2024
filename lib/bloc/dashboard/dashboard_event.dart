import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoginApiEvent extends DashboardEvent {
  final String userId;
  final String password;

  const LoginApiEvent({
    required this.userId,
    required this.password,
  });

  @override
  List<Object> get props => [userId, password];
}

class PIDashboardDetailsEvent extends DashboardEvent {
  final String userPartyId;
  final int pagination;
  final int list;
  final String searchType;
  final String searchValue;

  const PIDashboardDetailsEvent(
      {required this.userPartyId,
      required this.pagination,
      required this.list,
      required this.searchType,
      required this.searchValue});

  @override
  List<Object> get props =>
      [userPartyId, pagination, list, searchType, searchValue];
}

class NavigateToPIDetailScreenEvent extends DashboardEvent {
  final String preInspectionId;
  final bool isHitApi;
  final BuildContext context;

  const NavigateToPIDetailScreenEvent(
      {required this.preInspectionId, required this.isHitApi, required this.context});

  @override
  List<Object> get props => [preInspectionId, isHitApi];
}

class OwnFlowNavigateEvent extends DashboardEvent {
  const OwnFlowNavigateEvent();
}

class OtherFlowNavigateEvent extends DashboardEvent {
  const OtherFlowNavigateEvent();
}

class HitApiFlowNavigateEvent extends DashboardEvent {
  const HitApiFlowNavigateEvent();
}
