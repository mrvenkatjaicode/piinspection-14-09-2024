// pi_detail_state.dart
import 'package:equatable/equatable.dart';
import 'package:mnovapi/models/pi_detail/pi_detail_save_model.dart';
import 'package:tuple/tuple.dart';

import '../../models/pi_detail/pi_detail_model.dart';
import '../../models/pi_detail/pi_detail_save_response_model.dart';

abstract class PIDetailState extends Equatable {
  const PIDetailState();

  @override
  List<Object> get props => [];
}

class DeleteUploadState extends PIDetailState {
  final String tagName;
  final List<RequestPifilesuploadObj> requestPifilesuploadObjlist;

  const DeleteUploadState(
      {required this.tagName, required this.requestPifilesuploadObjlist});
}

class PIDetailInitial extends PIDetailState {}

class PIDetailLoading extends PIDetailState {}

class PIDetailLoaded extends PIDetailState {}

class PIDetailGetApiState extends PIDetailState {
  final PiDetailResponse pidetailsresponse;

  const PIDetailGetApiState({required this.pidetailsresponse});
}

class PIDetailSaveApiState extends PIDetailState {
  final PiDetailSaveResponse piDetailSaveResponse;

  const PIDetailSaveApiState({required this.piDetailSaveResponse});
}

class VehicleCategoryShow extends PIDetailState {
  final bool isShowvehiclecategory;

  const VehicleCategoryShow({required this.isShowvehiclecategory});
}

class SeatingCapacityShow extends PIDetailState {
  final bool isShowseatingCapacity;

  const SeatingCapacityShow({required this.isShowseatingCapacity});
}

class GVWShow extends PIDetailState {
  final bool isShowgvw;

  const GVWShow({required this.isShowgvw});
}

class EPCRShow extends PIDetailState {
  final bool isShowepcr;

  const EPCRShow({required this.isShowepcr});
}

class EPShowState extends PIDetailState {
  final bool isShowep;
  final String value;

  const EPShowState({required this.isShowep, required this.value});
}

class IDVShow extends PIDetailState {
  final bool isShowepcr;

  const IDVShow({required this.isShowepcr});
}

class SGICShowState extends PIDetailState {
  final bool isShowsgic;

  const SGICShowState({required this.isShowsgic});
}

class CurrentStatusShowState extends PIDetailState {
  final bool isShowcurrentstatus;

  const CurrentStatusShowState({required this.isShowcurrentstatus});
}

class BranchListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  const BranchListLoaded({
    required this.getList,
  });

  @override
  List<Object> get props => [getList];
}

class SurveyourListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  const SurveyourListLoaded({
    required this.getList,
  });

  @override
  List<Object> get props => [getList];
}

class ProductListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const ProductListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class PiPuroseListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const PiPuroseListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class EndoresementTypeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const EndoresementTypeListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class FuelTypeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const FuelTypeListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class VehicleCategoryListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const VehicleCategoryListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class PIDetailShowEndorsementState extends PIDetailState {
  final bool isShowEndorsementType;
  final bool isShowPolicyNumber;

  const PIDetailShowEndorsementState({
    required this.isShowEndorsementType,
    required this.isShowPolicyNumber,
  });
}

class PIDetailProductCodeFetched extends PIDetailState {
  final String productCode;
  final String api;

  const PIDetailProductCodeFetched(this.productCode, this.api);
}

class SeatingCapacityLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const SeatingCapacityLoaded({required this.getList});
}

class GVWLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const GVWLoaded({required this.getList});
}

class MakeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const MakeListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class ModelListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const ModelListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class PIDetailRtoCodeLoaded extends PIDetailState {
  final List<Tuple2<String, String>> rtoCodeList;
  final List<Tuple2<String, String>> rtoNameList;

  const PIDetailRtoCodeLoaded(
      {required this.rtoCodeList, required this.rtoNameList});
}

class YearPickerInitialState extends PIDetailState {
  final int selectedYear;

  const YearPickerInitialState(this.selectedYear);
}

class YearPickerUpdatedState extends PIDetailState {
  final int selectedYear;

  const YearPickerUpdatedState(this.selectedYear);
}

class IdvLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const IdvLoaded({required this.getList});
}

class PrefixLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const PrefixLoaded({required this.getList});
}

class ProposalTypeLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const ProposalTypeLoaded({required this.getList});
}

class PreInspectionLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const PreInspectionLoaded({required this.getList});
}

class NCBLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const NCBLoaded({required this.getList});
}

class PiFeeCollectedState extends PIDetailState {
  final bool isCollected;

  const PiFeeCollectedState({required this.isCollected});
}

class VehicleTypeState extends PIDetailState {
  final bool isCollected;

  const VehicleTypeState({required this.isCollected});
}

class RegistrationNumberFormatState extends PIDetailState {
  final bool isCollected;

  const RegistrationNumberFormatState({required this.isCollected});
}

class FileUploadInProgress extends PIDetailState {}

class FileAlreadyUploaded extends PIDetailState {
  final String tagName;

  const FileAlreadyUploaded(this.tagName);
}

class PIDetailSubmitState extends PIDetailState{}

class FileUploadedSuccessfully extends PIDetailState {
  final String tagName;
  final List<RequestPifilesuploadObj> requestPifilesuploadObjlist;

  const FileUploadedSuccessfully(this.tagName, this.requestPifilesuploadObjlist);
}

class NoFilePicked extends PIDetailState {}

class ShowBottomSheetState extends PIDetailState {
  final String type;

  const ShowBottomSheetState({required this.type});
}

class RcVerifiedState extends PIDetailState {
  final bool isCollected;

  const RcVerifiedState({required this.isCollected});
}

class VehicleRunningConditionState extends PIDetailState {
  final bool isCollected;

  const VehicleRunningConditionState({required this.isCollected});
}

class RegistrationTypeState extends PIDetailState {
  final int selectedValue;
  final String rtoCode;
  final String rtoName;
  final String regisNumberOne;
  final String regisNumberTwo;
  final String regisNumberThree;
  final String regisNumberFour;

  const RegistrationTypeState({
    required this.selectedValue,
    required this.rtoCode,
    required this.rtoName,
    required this.regisNumberOne,
    required this.regisNumberTwo,
    required this.regisNumberThree,
    required this.regisNumberFour,
  });
}

class PaymentLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const PaymentLoaded({required this.getList});
}

class PISubimtState extends PIDetailState {
  final bool isSubmitted;

  const PISubimtState({required this.isSubmitted});
}

class PIDetailError extends PIDetailState {
  final String message;

  const PIDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

class NaigateToNxtScreenState extends PIDetailState {}
