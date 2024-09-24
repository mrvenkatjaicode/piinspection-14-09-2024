import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/dashboard/login_model.dart';
import '../../models/dashboard/pi_dashboard_model.dart';
import '../../screens/pi_detail/pi_detail_screen.dart';
import '../../utils/constant.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../core/services.dart' as api;

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<PiDetail> dashboardList = [];
  DashboardBloc() : super(DashboardInitial()) {
    on<OwnFlowNavigateEvent>(_onOwnFlowNavigate);
    on<OtherFlowNavigateEvent>(_onOtherFlowNavigate);
    on<HitApiFlowNavigateEvent>(_onHitApiFlowNavigate);
    on<LoginApiEvent>(getloginapi);
    on<PIDashboardDetailsEvent>(getdashboardpiapi);
    on<NavigateToPIDetailScreenEvent>(navigatetopidetail);
  }

  getloginapi(LoginApiEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/ValidatePILogin",
          jsonEncode({"UserID": event.userId, "Password": event.password}));

      if (res.statusCode == 200) {
        var resModel = loginResponseFromJson(res.resBody);

        if (resModel.messageResult!.errorMessage != null) {
          emit(DashboardFailureState(
              resModel.messageResult!.errorMessage ?? "Login Failed!"));
        } else {
          userName = resModel.partyName ?? "";
          userId = resModel.userpartyid ?? "";
          userMailId = resModel.loginUser ?? "";
          emit(LoginSuccessState(
            userId: resModel.loginUser.toString(),
            partyId: resModel.userpartyid.toString(),
            partyName: resModel.partyName.toString(),
            serviceUrl: resModel.preinspectionServiceUrl.toString(),
          ));
        }
      } else {
        emit(const DashboardFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(DashboardFailureState(e.toString()));
    }
  }

  getdashboardpiapi(
      PIDashboardDetailsEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/PIDashBoard",
          jsonEncode({
            "Userip": "",
            "Userpartyid": event.userPartyId,
            "Pagination": event.pagination,
            "List": event.list,
            "SearchType": event.searchType,
            "SearchValue": event.searchValue
          }));

      if (res.statusCode == 200) {
        var resModel = piDashboardResponseFromJson(res.resBody);
        for (int i = 0; i < resModel.piDetails!.length; i++) {
          dashboardList.add(resModel.piDetails![i]);
        }
        emit(DashboardPISuccessState(dashboardList: dashboardList));
      } else {
        emit(const DashboardFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(DashboardFailureState(e.toString()));
    }
  }

  navigatetopidetail(
      NavigateToPIDetailScreenEvent event, Emitter<DashboardState> emit) async {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) {
          return PIDetailScreen(
              preinsid: event.preInspectionId,
              hitapiflow: event.isHitApi,
              iseditable: true,
              otherflow: false,
              ownflow: false);
        },
      ),
    ) /* .then((value) {
      event.context.read<DashboardBloc>().add(const LoginApiEvent(
          userId: "abhinaw.sgi@gmail.com", password: "cherry123"));
    }) */
        ;
    // emit(DashboardLoadingState());
    // emit(NavigateToPIDetailScreenState(preInspectionId: event.preInspectionId, isHitApi: event.isHitApi));
  }

  Future<void> _onOwnFlowNavigate(
      OwnFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(true, false, false, emit);
  }

  Future<void> _onOtherFlowNavigate(
      OtherFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(false, true, false, emit);
  }

  Future<void> _onHitApiFlowNavigate(
      HitApiFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(false, false, true, emit);
  }

  Future<void> _fetchLocation(bool isOwnFlow, bool isOtherFlow, bool isHitApi,
      Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        emit(const LocationPermissionDeniedState(
            'Location services are disabled.'));
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const LocationPermissionDeniedState(
              'Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const LocationPermissionDeniedState(
            'Location permissions are permanently denied, we cannot request permissions.'));
        return;
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      // Get placemark from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks.first;

      emit(LocationFetchedAndNavigateState(
          position: position,
          place: place,
          isOwnFlow: isOwnFlow,
          isOtherFlow: isOtherFlow,
          isHitApi: isHitApi));
    } catch (e) {
      emit(LocationPermissionDeniedState(e.toString()));
    }
  }
}

class VisibilityCubit extends Cubit<DashboardState> {
  VisibilityCubit() : super(DashboardInitial()); // Initial state is false

  // Toggle visibility
  void toggleVisibility() {}
}
