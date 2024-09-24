// pi_detail_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../models/pi_detail/pi_detail_save_model.dart';

abstract class PIDetailEvent extends Equatable {
  const PIDetailEvent();

  @override
  List<Object> get props => [];
}

class PIDetailSubmitEvent extends PIDetailEvent {}

class DeleteUploadEvent extends PIDetailEvent {
  final String tagName;

  const DeleteUploadEvent({required this.tagName});
}

class PIDetailIntialEvent extends PIDetailEvent {}

class PIDetailsGetApiEvent extends PIDetailEvent {
  final String preInspectionId;
  final String userPartyId;

  const PIDetailsGetApiEvent(
      {required this.preInspectionId, required this.userPartyId});
}

class PIDetailsSaveApiEvent extends PIDetailEvent {
  final String branchPartyId;
  final String surveyorPartyId;
  final String productType;
  final String productCategory;
  final String vehicleType;
  final String registrationFormat;
  final String registrationNo;
  final String engineNo;
  final String chassisNo;
  final String make;
  final String model;
  final String yearOfManufacturing;
  final String fueltype;
  final String inspectionLocation;
  final String contactPerson;
  final String contactMobileNo;
  final String insuredName;
  final String piPurpose;
  final String endorsementType;
  final String policyNo;
  final String ncbPercentage;
  final String contactNoforSms;
  final String intimationRemarks;
  final String userPartyId;
  final String sourceFrom;
  final String loginId;
  final String idvofvehicle;
  final String proposalType;
  final String sgicPolicyNumber;
  final String engineprotectorcover;
  final String contactnoToSendlink;
  final String gvw;
  final String seatingcapacity;
  final List<RequestPifilesuploadObj>? requestPifilesuploadObj;
  final String attachmentId;
  final String preInspectionId;
  final String title;
  final String odometerReading;
  final String agencyStatus;
  final String rcVerified;
  final String surveyorRemark;
  final String vehRunningCondition;
  final String piFeesAmount;
  final String conveyanceAmount;
  final String modeofPayment;
  final String referenceNumber;
  final String piFeesCollected;
  final String branch;

  const PIDetailsSaveApiEvent(
      {required this.branchPartyId,
      required this.surveyorPartyId,
      required this.productType,
      required this.productCategory,
      required this.vehicleType,
      required this.registrationFormat,
      required this.registrationNo,
      required this.engineNo,
      required this.chassisNo,
      required this.make,
      required this.model,
      required this.yearOfManufacturing,
      required this.fueltype,
      required this.inspectionLocation,
      required this.contactPerson,
      required this.contactMobileNo,
      required this.insuredName,
      required this.piPurpose,
      required this.endorsementType,
      required this.policyNo,
      required this.ncbPercentage,
      required this.contactNoforSms,
      required this.intimationRemarks,
      required this.userPartyId,
      required this.sourceFrom,
      required this.loginId,
      required this.idvofvehicle,
      required this.proposalType,
      required this.sgicPolicyNumber,
      required this.engineprotectorcover,
      required this.contactnoToSendlink,
      required this.gvw,
      required this.seatingcapacity,
      required this.requestPifilesuploadObj,
      required this.attachmentId,
      required this.preInspectionId,
      required this.title,
      required this.odometerReading,
      required this.agencyStatus,
      required this.rcVerified,
      required this.surveyorRemark,
      required this.vehRunningCondition,
      required this.piFeesAmount,
      required this.conveyanceAmount,
      required this.modeofPayment,
      required this.referenceNumber,
      required this.piFeesCollected,
      required this.branch});
}

class ShowVehicleCategory extends PIDetailEvent {
  final String product;

  const ShowVehicleCategory({required this.product});
}

class ShowSeatingCapacity extends PIDetailEvent {
  final String product;
  final String vehiclecategory;

  const ShowSeatingCapacity(
      {required this.product, required this.vehiclecategory});
}

class ShowGVW extends PIDetailEvent {
  final String product;

  const ShowGVW({required this.product});
}

class ShowEPCR extends PIDetailEvent {
  final String product;
  final String pipurpose;

  const ShowEPCR({required this.product, required this.pipurpose});
}

class ShowEP extends PIDetailEvent {
  final String value;

  const ShowEP({required this.value});
}

class ShowIDV extends PIDetailEvent {
  final String product;
  final String vehiclecategory;

  const ShowIDV({required this.product, required this.vehiclecategory});
}

class ShowSGICEvent extends PIDetailEvent {
  final String proposaltype;

  const ShowSGICEvent({required this.proposaltype});
}

class ShowCurrentStatusEvent extends PIDetailEvent {
  final String intimationStatus;

  const ShowCurrentStatusEvent({required this.intimationStatus});
}

class LoadPIDetail extends PIDetailEvent {
  final bool ownpi;
  final bool otherpi;
  final bool ishitapi;
  final String preinsid;
  final String partid;

  const LoadPIDetail({
    required this.ownpi,
    required this.otherpi,
    required this.ishitapi,
    required this.preinsid,
    required this.partid,
  });

  @override
  List<Object> get props => [ownpi, otherpi, ishitapi, preinsid, partid];
}

class ProductSelected extends PIDetailEvent {
  final String productName;
  final String api;

  const ProductSelected(this.productName, this.api);
}

class FetchBranchNameApi extends PIDetailEvent {}

class FetchSurveyorNameApi extends PIDetailEvent {
  // final String? branchId;
  final String? partyId;
  final String? searchValue;

  const FetchSurveyorNameApi(
      {
      //required this.branchId,
      required this.searchValue,
      required this.partyId});
}

class ChooseDDValue extends PIDetailEvent {
  final TextEditingController controller;
  final List<Tuple2<String?, String?>?> getList;
  final String screenName;
  final BuildContext context;

  const ChooseDDValue(
      {required this.controller,
      required this.getList,
      required this.screenName,
      required this.context});
}

class ChooseRTOValue extends PIDetailEvent {
  final TextEditingController rtocodecontroller;
  final TextEditingController rtonamecontroller;
  final TextEditingController r1controller;
  final TextEditingController r2controller;
  final List<Tuple2<String?, String?>?> getList;
  final String screenName;
  final BuildContext context;

  const ChooseRTOValue(
      {required this.rtocodecontroller,
      required this.rtonamecontroller,
      required this.r1controller,
      required this.r2controller,
      required this.getList,
      required this.screenName,
      required this.context});
}

class FetchLoadComboApi extends PIDetailEvent {
  final String? partyId;
  final String name;
  final String? productname;
  final String? vehcategory;
  final String? seatingcap;

  const FetchLoadComboApi(
      {required this.partyId,
      required this.name,
      required this.productname,
      required this.vehcategory,
      required this.seatingcap});
}

class ShowBottomSheetEvent extends PIDetailEvent {
  final String type;

  const ShowBottomSheetEvent({required this.type});
}

class GetFromCameraEvent extends PIDetailEvent {
  final String tagName;
  final String imageType;
  final BuildContext context;

  const GetFromCameraEvent(this.tagName, this.imageType, this.context);
}

class PickPdfEvent extends PIDetailEvent {
  final String tagName;
  final String imageType;
  final BuildContext context;

  const PickPdfEvent(this.tagName, this.imageType, this.context);
}

class FetchVehicleCategoryApi extends PIDetailEvent {
  final String? partyId;
  final String? vehCode;
  const FetchVehicleCategoryApi({required this.partyId, required this.vehCode});
}

class FetchSeatingCapacity extends PIDetailEvent {}

class Fetchgvw extends PIDetailEvent {}

class FetchMakeApi extends PIDetailEvent {
  final String? partyId;
  final String? productCode;
  const FetchMakeApi({required this.partyId, required this.productCode});
}

class SelectMake extends PIDetailEvent {
  final String makeId; // unique ID of the selected make
  const SelectMake(this.makeId);
}

class FetchModelApi extends PIDetailEvent {
  final String? partyId;
  final String? productCode;
  final String? makeCode;
  const FetchModelApi(
      {required this.partyId,
      required this.productCode,
      required this.makeCode});
}

class GetRtoCodeEvent extends PIDetailEvent {
  final String? partyId;
  final String? name;

  const GetRtoCodeEvent({
    required this.partyId,
    required this.name,
  });
}

class ShowEndorsementType extends PIDetailEvent {
  final String piPurpose;

  const ShowEndorsementType({required this.piPurpose});
}

class PiFeeCollectedToggleSwitch extends PIDetailEvent {
  final bool isCollected;

  const PiFeeCollectedToggleSwitch({required this.isCollected});
}

class VehicleTypeToggleSwitch extends PIDetailEvent {
  final bool isCollected;

  const VehicleTypeToggleSwitch({required this.isCollected});
}

class RegistrationNumberFormatToggleSwitch extends PIDetailEvent {
  final bool isCollected;

  const RegistrationNumberFormatToggleSwitch({required this.isCollected});
}

class RcVerifiedToggleSwitchEvent extends PIDetailEvent {
  final bool isCollected;

  const RcVerifiedToggleSwitchEvent({required this.isCollected});
}

class VehicleRunningConditionSwitchEvent extends PIDetailEvent {
  final bool isCollected;

  const VehicleRunningConditionSwitchEvent({required this.isCollected});
}

class RegistrationTypeSelectedEvent extends PIDetailEvent {
  final int selectedValue;

  const RegistrationTypeSelectedEvent({required this.selectedValue});
}

class ShowYearPickerEvent extends PIDetailEvent {}

class YearSelectedEvent extends PIDetailEvent {
  final int selectedYear;

  const YearSelectedEvent(this.selectedYear);
}

class IdvSelect extends PIDetailEvent {}

class PrefixSelect extends PIDetailEvent {}

class ProposalTypeSelect extends PIDetailEvent {}

class PreInspectionSelect extends PIDetailEvent {}

class NCBSelect extends PIDetailEvent {}

class PaymentSelect extends PIDetailEvent {}

class PISubmitEvent extends PIDetailEvent {}

class NavigateToNcxtScreenEvent extends PIDetailEvent {
  final String preInspectionId;
  final BuildContext context;

  const NavigateToNcxtScreenEvent(
      {required this.preInspectionId, required this.context});
}
