// pi_detail_bloc.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnovapi/screens/preinspection/preinspection_screen.dart';
import 'package:tuple/tuple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../models/pi_detail/branch_name.dart';
import '../../models/pi_detail/load_combo.dart';
import '../../models/pi_detail/make.dart';
import '../../models/pi_detail/model.dart';
import '../../models/pi_detail/pi_detail_model.dart';
import '../../models/pi_detail/pi_detail_save_model.dart';
import '../../models/pi_detail/pi_detail_save_response_model.dart';
import '../../models/pi_detail/rto_list.dart';
import '../../models/pi_detail/surveyor_name.dart';
import '../../models/pi_detail/vehicle_category.dart';
import '../../screens/pi_detail/dropdownlist_screen.dart';
import '../../utils/constant.dart';
import 'pi_detail_event.dart';
import 'pi_detail_state.dart';
import '../../core/services.dart' as api;

class PIDetailBloc extends Bloc<PIDetailEvent, PIDetailState> {
  String? selectedSurveyorId;
  String? selectedMakeId;
  PiDetailResponse? pidetailsresponse;

  ///VISIBILITY WIDGET
  bool isShowVehicleCategory = false;
  bool isShowEndorsementType = false;
  bool isShowSeatingCapacity = false;
  bool isShowgvw = false;
  bool isShowepcr = false;
  bool isShowep = false;
  bool isShowidv = false;
  bool isShowsgic = false;
  bool isShowcurrentstatus = false;

  bool isPiSubmitted = false;

  ///SWITCH WIDGET
  bool isPiFeeCollected = false;
  bool isvehicleType = true;
  bool isregistrationnumberformat = true;
  bool isrcVerified = true;
  bool isvehiclerunningcondition = true;

  ///IMAGE UPLOADING IN PREINSPECTION SCREEN
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? base64Image;
  bool isRcCopyUploaded = false;
  bool isPreviousPolicyUploaded = false;
  bool isInvoiceCopyUploaded = false;
  RequestPifilesuploadObj requestPifilesuploadObj = RequestPifilesuploadObj();
  List<RequestPifilesuploadObj> requestPifilesuploadObjlist = [];

  PIDetailBloc() : super(PIDetailInitial()) {
    // on<ShowVehicleCategory>((event, emit) {
    //   isShowVehicleCategory = true;
    //   emit(VehicleCategoryShow(isShowvehiclecategory: isShowVehicleCategory));
    // });

    // on<HideVehicleCategory>((event, emit) {
    //   isShowVehicleCategory = false;
    //   emit(VehicleCategoryShow(isShowvehiclecategory: isShowVehicleCategory));
    // });

    on<LoadPIDetail>((event, emit) async {
      emit(PIDetailLoading());

      try {
        if (event.ownpi || event.otherpi) {
          // Si your ownpiflow logic
          // await ownpiflow(event.ownpi, event.otherpi);
        } else {
          // Simulate your hitapi logic
          // await hitapi(event.ishitapi, event.preinsid, event.partid);
        }

        emit(const BranchListLoaded(getList: []));
      } catch (error) {
        emit(PIDetailError(message: error.toString()));
      }
    });
    // on<PIDetailIntialEvent>(addpreinspectionid);
    // add(PIDetailIntialEvent());
    on<PIDetailsGetApiEvent>(getPiDetailApi);
    on<PIDetailsSaveApiEvent>(savePiDetailapi);
    on<ChooseDDValue>(selectddvalue);
    on<ChooseRTOValue>(selectrtovalue);
    on<FetchBranchNameApi>(getBranchDetail);
    on<FetchSurveyorNameApi>(getSurveyorDetail);
    on<FetchLoadComboApi>(getLoadComboDetail);
    on<ShowBottomSheetEvent>(callbotttomsheet);
    on<GetFromCameraEvent>(getimage);
    on<PickPdfEvent>(getpdf);
    on<RegistrationTypeSelectedEvent>(handleRegistrationTypeSelected);
    on<ShowVehicleCategory>(onShowVehicleCategory);
    on<ShowSeatingCapacity>(onShowSeatingCapacity);
    on<ShowGVW>(onShowgvw);
    on<ShowEPCR>(onShowepcr);
    on<ShowEP>(onShowep);
    on<ShowEndorsementType>(onShowEndorsementType);
    on<ShowIDV>(onShowidv);
    on<VehicleTypeToggleSwitch>(switchvehicleTypecollected);
    on<RegistrationNumberFormatToggleSwitch>(
        switchregistrationnumberformatcollected);
    on<PiFeeCollectedToggleSwitch>(switchpifeecollected);
    on<RcVerifiedToggleSwitchEvent>(switchrcverified);
    on<VehicleRunningConditionSwitchEvent>(switchvehiclerunningcondition);
    on<ShowSGICEvent>(onShowsgic);
    on<ShowCurrentStatusEvent>(onShowcurrentstatus);
    on<FetchVehicleCategoryApi>(getvehiclecategory);
    on<ProductSelected>(onProductSelected);
    on<FetchSeatingCapacity>(getSeatingCapacity);
    on<Fetchgvw>(getgvw);
    on<FetchMakeApi>(getMake);
    on<FetchModelApi>(getModel);
    on<GetRtoCodeEvent>(getRtoCode);
    on<IdvSelect>(getidv);
    on<PrefixSelect>(getprefix);
    on<ProposalTypeSelect>(getproposalType);
    on<PreInspectionSelect>(getpreInspection);
    on<NCBSelect>(getNcb);
    on<PaymentSelect>(getpayment);
    on<ShowYearPickerEvent>(showYearPicker);
    on<YearSelectedEvent>(yearSelected);
    on<PISubmitEvent>(getPiSubmit);
    on<NavigateToNcxtScreenEvent>(navigatetonxtscreen);
  }

  savePiDetailapi(
      PIDetailsSaveApiEvent event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());
    try {
      PiDetailSaveRequest pidetailsave = PiDetailSaveRequest();

      pidetailsave.branchPartyId = event.branchPartyId;
      pidetailsave.surveyorPartyId = event.surveyorPartyId;
      pidetailsave.productType = event.productType;
      pidetailsave.productCategory = event.productCategory;
      pidetailsave.vehicleType = event.vehicleType;
      pidetailsave.registrationFormat = event.registrationFormat;
      pidetailsave.registrationNo = event.registrationNo;
      pidetailsave.engineNo = event.engineNo;
      pidetailsave.chassisNo = event.chassisNo;
      pidetailsave.make = event.make;
      pidetailsave.model = event.model;
      pidetailsave.yearOfManufacturing = event.yearOfManufacturing;
      pidetailsave.fueltype = event.fueltype;
      pidetailsave.inspectionLocation = event.inspectionLocation;
      pidetailsave.contactPerson = event.contactPerson;
      pidetailsave.contactMobileNo = event.contactMobileNo;
      pidetailsave.insuredName = event.insuredName;
      pidetailsave.piPurpose = event.piPurpose;
      pidetailsave.endorsementType = event.endorsementType;
      pidetailsave.policyNo = event.policyNo;
      pidetailsave.ncbPercentage = event.ncbPercentage;
      pidetailsave.contactNoforSms = event.contactNoforSms;
      pidetailsave.intimationRemarks = event.intimationRemarks;
      pidetailsave.userPartyId = event.userPartyId;
      pidetailsave.sourceFrom = event.sourceFrom;
      pidetailsave.loginId = event.loginId;
      pidetailsave.idvofvehicle = event.idvofvehicle;
      pidetailsave.proposalType = event.proposalType;
      pidetailsave.sgicPolicyNumber = event.sgicPolicyNumber;
      pidetailsave.engineprotectorcover = event.engineprotectorcover;
      pidetailsave.contactnoToSendlink = event.contactnoToSendlink;
      pidetailsave.gvw = event.gvw;
      pidetailsave.seatingcapacity = event.seatingcapacity;
      pidetailsave.requestPifilesuploadObj = event.requestPifilesuploadObj;
      pidetailsave.attachmentId = event.attachmentId;
      pidetailsave.preInspectionId = event.preInspectionId;
      pidetailsave.title = event.title;
      pidetailsave.odometerReading = event.odometerReading;
      pidetailsave.agencyStatus = event.agencyStatus;
      pidetailsave.rcVerified = event.rcVerified;
      pidetailsave.surveyorRemark = event.surveyorRemark;
      pidetailsave.vehRunningCondition = event.vehRunningCondition;
      pidetailsave.piFeesAmount = event.piFeesAmount;
      pidetailsave.conveyanceAmount = event.conveyanceAmount;
      pidetailsave.modeofPayment = event.modeofPayment;
      pidetailsave.referenceNumber = event.referenceNumber;
      pidetailsave.piFeesCollected = event.piFeesCollected;
      pidetailsave.branch = event.branch;
      pidetailsave.registrationFormat = event.registrationFormat;
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/PreInspectionCreation",
          piDetailSaveRequestToJson(pidetailsave));
      if (res.statusCode == 200) {
        var resModel = piDetailSaveResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          preInspectionId = resModel.preInspectionId ?? "";
          debugPrint(preInspectionId);
          emit(PIDetailSaveApiState(piDetailSaveResponse: resModel));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: 'Failed to fetch data from API'));
      }
    } catch (e) {
      emit(PIDetailError(message: 'Error: ${e.toString()}'));
    }
  }

  getPiDetailApi(
      PIDetailsGetApiEvent event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/PreinspectionSearch",
          jsonEncode({
            "PREINSPECTIONID": event.preInspectionId,
            "TAGNAME": "PREINS_VIEW",
            "Userpartyid": event.userPartyId,
            "Userip": ""
          }));
      if (res.statusCode == 200) {
        var resModel = piDetailResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          pidetailsresponse = resModel;
          // attachmentid = resModel.response![0].attachmentid.toString();
          // surveyorpartyid =
          //     resModel.response![0].surveyorList![0].surveyorPartyId.toString();
          // intimationstatus = resModel.response![0].statusname.toString();
          // streamController.add(pidetailsresponse);
          emit(PIDetailGetApiState(pidetailsresponse: pidetailsresponse!));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: 'Failed to fetch data from API'));
      }
    } catch (e) {
      emit(PIDetailError(message: 'Error: ${e.toString()}'));
    }
  }
  // addpreinspectionid(PIDetailIntialEvent event, Emitter<PIDetailState> emit) {
  //   userId = "100000000138661";
  //   debugPrint(userId);
  // }

  // Event handler for product selection
  void onProductSelected(ProductSelected event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    final productCode = _fetchProductCode(event.productName);
    final type = event.api;
    emit(PIDetailProductCodeFetched(productCode, type));
  }

  String _fetchProductCode(String selectedProduct) {
    switch (selectedProduct) {
      case 'TRAILERS':
        return "MOT-PRD-004";
      case 'Misc.-D':
        return "MOT-PRD-006";
      case 'PCCV':
        return "MOT-PRD-005";
      case 'PRIVATE CAR':
        return "MOT-PRD-001";
      case 'MOTORISED-TWO WHEELERS':
        return "MOT-PRD-002";
      case 'GCCV':
        return "MOT-PRD-003";
      default:
        return "";
    }
  }

  getimage(GetFromCameraEvent event, Emitter<PIDetailState> emit) async {
    emit(FileUploadInProgress());

    // Pick the image from the camera
    var pickedFile = await picker.pickImage(
      source: event.imageType == "Camera"
          ? ImageSource.camera
          : ImageSource.gallery,
      imageQuality: 20,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      final String type = imageFile!.path.split(".").last;
      final bytes = imageFile!.readAsBytesSync();
      base64Image = base64Encode(bytes);

      // Handle different tag names
      if (event.tagName == "RC Copy" && isRcCopyUploaded) {
        _showAlreadyUploadedDialog(event.context);
        emit(FileAlreadyUploaded(event.tagName));
      } else if (event.tagName == "Previous Policy" &&
          isPreviousPolicyUploaded) {
        _showAlreadyUploadedDialog(event.context);
        emit(FileAlreadyUploaded(event.tagName));
      } else if (event.tagName == "Invoice Copy" && isInvoiceCopyUploaded) {
        _showAlreadyUploadedDialog(event.context);
        emit(FileAlreadyUploaded(event.tagName));
      } else {
        _uploadFile(event.tagName, type, base64Image!);
        emit(FileUploadedSuccessfully(event.tagName));
      }
    }
  }

  getpdf(PickPdfEvent event, Emitter<PIDetailState> emit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: event.imageType == "PDF" ? ['pdf'] : ['doc', 'docx'],
    );
    if (result == null) {
      emit(NoFilePicked()); // No file picked
      return;
    }
    // Read the file and encode to base64
    final bytes = File(result.files.first.path!).readAsBytesSync();
    final String file64 = base64Encode(bytes);
    final String fileName = result.names[0] ?? '';
    if (event.tagName == "RC Copy" && isRcCopyUploaded) {
      _showAlreadyUploadedDialog(event.context);
      emit(FileAlreadyUploaded(event.tagName));
    } else if (event.tagName == "Previous Policy" && isPreviousPolicyUploaded) {
      _showAlreadyUploadedDialog(event.context);
      emit(FileAlreadyUploaded(event.tagName));
    } else if (event.tagName == "Invoice Copy" && isInvoiceCopyUploaded) {
      _showAlreadyUploadedDialog(event.context);
      emit(FileAlreadyUploaded(event.tagName));
    } else {
      _uploadFile(event.tagName, fileName, file64);
      emit(FileUploadedSuccessfully(event.tagName));
    }
  }

  // Upload the file and handle different tags
  void _uploadFile(String tagName, String type, String base64value) {
    requestPifilesuploadObj = RequestPifilesuploadObj(
      tagName: tagName,
      tagId: "173",
      fileName: "$tagName.$type",
      base64Value: base64value,
      uniqueFileName: "",
      extension: "",
      xbizid: "",
      xbizurl: "",
    );

    // Add the upload object to the list based on the tagName
    requestPifilesuploadObjlist.add(requestPifilesuploadObj);

    // Update the uploaded status for respective tags
    if (tagName == "RC Copy") {
      isRcCopyUploaded = true;
    } else if (tagName == "Previous Policy") {
      isPreviousPolicyUploaded = true;
    } else if (tagName == "Invoice Copy") {
      isInvoiceCopyUploaded = true;
    }
  }

// Show the "Already Uploaded" dialog
  void _showAlreadyUploadedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (alertDialogContext) => const AlertDialog(
        content: SizedBox(
          height: 60,
          width: 60,
          child: Center(child: Text("Already Uploaded")),
        ),
      ),
    );
  }

  callbotttomsheet(
      ShowBottomSheetEvent event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());
    emit(ShowBottomSheetState(type: event.type));
  }

  Future<void> showYearPicker(
      ShowYearPickerEvent event, Emitter<PIDetailState> emit) async {
    // This event doesn't need to emit anything, as it just triggers the year picker UI.
  }

  void yearSelected(YearSelectedEvent event, Emitter<PIDetailState> emit) {
    emit(YearPickerUpdatedState(event.selectedYear));
  }

  selectddvalue(dynamic event, Emitter<PIDetailState> emit) async {
    final result = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => DropDownListScreen(
          datalist: event.getList,
          listtype: event.screenName,
        ),
      ),
    );

    if (result != null) {
      event.controller.text = result['value'] ?? "";
      if (event.screenName == "Make") {
        selectedMakeId = result['code'] ?? "";
      } else if (event.screenName == 'Branch') {
        branchCode = result['code'] ?? "";
      } else {
        selectedSurveyorId = result['code'] ?? "";
      }
    }
    debugPrint("gggggg $selectedMakeId");
  }

  selectrtovalue(ChooseRTOValue event, Emitter<PIDetailState> emit) async {
    final result = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => DropDownListScreen(
          datalist: event.getList,
          listtype: event.screenName,
        ),
      ),
    );
    event.rtocodecontroller.text =
        result['value'].toString().split(" - ").first;
    event.rtonamecontroller.text = result['value'].toString().split(" - ").last;
    event.r1controller.text = result['value'].toString().split("-").first;
    event.r2controller.text = result['value'].toString().split("-")[1];
  }

  getBranchDetail(FetchBranchNameApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/getMainBranchList",
          jsonEncode({
            "PartySearch": "sgi",
            "searchCondition": "1",
            "Userpartyid": "mobile_test",
            "Userip": "sgi",
            "ROOTORGBY": "102"
          }));
      if (res.statusCode == 200) {
        var resModel = pibranchlistResponseFromJson(res.resBody);
        if (resModel.messageResult.result == 'Success') {
          List<Tuple2<String?, String?>?> branchlist = [];

          for (int i = 0; i < resModel.response.length; i++) {
            branchlist.add(Tuple2(
                resModel.response[i].partyid, resModel.response[i].partyname));
          }
          emit(BranchListLoaded(getList: branchlist));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: 'Failed to fetch data from API'));
      }
    } catch (e) {
      emit(PIDetailError(message: 'Error: ${e.toString()}'));
    }
  }

  getSurveyorDetail(
      FetchSurveyorNameApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetSurveyorDetails",
          jsonEncode({
            "BranchPartyId": branchCode,
            "SearchBy": "ALL",
            "SearchValue": event.searchValue,
            "UserPartyId": event.partyId
          }));
      if (res.statusCode == 200) {
        var resModel = surveryorResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String?, String?>?> surveyorlist = [];

          for (int i = 0; i < resModel.surveyorDetails!.length; i++) {
            surveyorlist.add(Tuple2(
                resModel.surveyorDetails![i].surveyorPartyId,
                resModel.surveyorDetails![i].surveyorName));
          }
          emit(SurveyourListLoaded(getList: surveyorlist));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: 'Failed to fetch data from API'));
      }
    } catch (e) {
      emit(PIDetailError(message: 'Error: ${e.toString()}'));
    }
  }

  Future<void> getLoadComboDetail(
      FetchLoadComboApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      // API call to fetch data
      api.Response res = await api.ApiService().postRequest(
          "http://shrigenservice.shriramgi.com/SHRIGENSERVICE/ShrigenServices/ServiceTransaction.svc/RestService/GetScreenLoadCombo",
          jsonEncode({"Userip": "", "Userpartyid": event.partyId}));

      if (res.statusCode == 200) {
        var resModel = getLoadComboResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          // Lists for the different fields
          List<Tuple2<String, String>> productList = [];
          List<Tuple2<String, String>> piPurposeList = [];
          List<Tuple2<String, String>> fuelTypeList = [];
          List<Tuple2<String, String>> endorsementList = [];

          // Populate product list
          for (var item in resModel.mProductDetailsResObj!) {
            if (item.productname != "TRAILERS") {
              productList
                  .add(Tuple2(item.productid ?? "", item.productname ?? ""));
            }
          }

          // Populate PI Purpose list
          for (var item in resModel.mPreinspectionStatusResObj!) {
            piPurposeList
                .add(Tuple2(item.statusid ?? "", item.statusname ?? ""));
          }

          // Populate Fuel Type list
          for (var item in resModel.mFuelTypeResObj!) {
            fuelTypeList.add(Tuple2("", item.fuelType ?? ""));
          }

          // Populate Endorsement list
          for (var item in resModel.mEndorsementTypertnObj!) {
            endorsementList.add(Tuple2("", item.endorsementCombo ?? ""));
          }

          // Additional conditions based on the values of the controllers (Product, VehicleCategory, etc.)
          final productControllerText = event.productname;
          final vehicleControllerText = event.vehcategory;
          final seatingcapacityControllerText = event.seatingcap;

          if (productControllerText == "Misc.-D") {
            // Remove specific items from piPurposeList for "Misc.-D"
            piPurposeList.removeWhere((item) =>
                item.item2 ==
                    resModel.mPreinspectionStatusResObj![3].statusname ||
                item.item2 ==
                    resModel.mPreinspectionStatusResObj![5].statusname);
          } else if (productControllerText == "PCCV") {
            // Conditional removal for "PCCV"

            if (vehicleControllerText!.contains("PCCV-4")) {
              if (seatingcapacityControllerText!.contains(">11")) {
                piPurposeList.removeWhere((item) =>
                    item.item2 ==
                        resModel.mPreinspectionStatusResObj![3].statusname ||
                    item.item2 ==
                        resModel.mPreinspectionStatusResObj![5].statusname);
              }
            } else {
              piPurposeList.removeWhere((item) =>
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![3].statusname ||
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![5].statusname);
            }
          } else if (productControllerText == "GCCV") {
            if (vehicleControllerText!.contains(
                    "GOODS CARRYING MOTORISED THREE WHEELERS AND MOTORISED PEDAL CYCLES-PUBLIC CARRIERS") ||
                vehicleControllerText.contains(
                    "GOODS CARRYING MOTORISED THREE WHEELERS AND MOTORISED PEDAL CYCLES-PRIVATE CARRIERS")) {
              piPurposeList.removeWhere((item) =>
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![3].statusname ||
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![5].statusname);
            }
          }

          // Determine which list to send to the dropdown screen based on the name (Product, PI Purpose, Fuel Type, Endorsement)
          List<Tuple2<String, String>> dataList;
          switch (event.name) {
            case "Product":
              dataList = productList;
              // Emit success state with loaded data
              emit(ProductListLoaded(getList: dataList, name: event.name));
              break;
            case "PI Purpose":
              dataList = piPurposeList;
              emit(PiPuroseListLoaded(getList: dataList, name: event.name));
              break;
            case "Fuel Type":
              dataList = fuelTypeList;
              emit(FuelTypeListLoaded(getList: dataList, name: event.name));
              break;
            default:
              dataList = endorsementList;
              emit(EndoresementTypeListLoaded(
                  getList: dataList, name: event.name));
          }
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  void getvehiclecategory(
      FetchVehicleCategoryApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    // Call the API
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/getProductCategory",
          jsonEncode({
            "Flag": "NEW",
            "Userip": "",
            "Userpartyid": event.partyId,
            "VAP_PROD_CODE": event.vehCode
          }));

      if (res.statusCode == 200) {
        var resModel = vehicleCategoryResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String?, String?>> vehCategoryList = [];

          for (int i = 0; i < resModel.response!.length; i++) {
            vehCategoryList.add(Tuple2(
                resModel.response![i].pcCode, resModel.response![i].pcDesc));
          }
          vehCategoryList
              .sort((a, b) => (a.item2 ?? "").compareTo(b.item2 ?? ""));

          emit(VehicleCategoryListLoaded(getList: vehCategoryList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  getSeatingCapacity(FetchSeatingCapacity event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> seatingCapacityList = [];

    // Hardcoded seating capacity list
    List<dynamic> seatingCapacityListData = ["UPTO 10+1", ">11"];
    for (var seating in seatingCapacityListData) {
      seatingCapacityList.add(Tuple2("", seating));
    }

    // Emit the loaded seating capacity state
    emit(SeatingCapacityLoaded(getList: seatingCapacityList));
  }

  getgvw(Fetchgvw event, Emitter<PIDetailState> emit) {
    List<Tuple2<String, String>> gvwList = [];
    emit(PIDetailLoading());
    // Hardcoded seating capacity list
    List<dynamic> gvwListData = ["UPTO 2500 GVW", "UPTO 7500 GVW", ">7500 GVW"];
    for (var gvw in gvwListData) {
      gvwList.add(Tuple2("", gvw));
    }

    // Emit the loaded seating capacity state
    emit(GVWLoaded(getList: gvwList));
  }

  getMake(FetchMakeApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      api.Response res = await api.ApiService().postRequest(
        "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetVehicleMakeDetails",
        jsonEncode({
          "Userip": "",
          "Userpartyid": event.partyId,
          "PremiaPoductCode": event.productCode,
          "ProductCategory": ""
        }),
      );

      if (res.statusCode == 200) {
        var resModel = makeResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String, String>> makeList = [];

          for (var vehicleMakeDetail in resModel.vehicleMakeDetails!) {
            makeList.add(Tuple2(vehicleMakeDetail.vehicleMakeCode ?? "",
                vehicleMakeDetail.vehicleMakeDesc ?? ""));
          }

          emit(MakeListLoaded(getList: makeList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  String makecode = "";

  getModel(FetchModelApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      api.Response res = await api.ApiService().postRequest(
        "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetVehicleModelDetails",
        jsonEncode({
          "Userip": "",
          "Userpartyid": event.partyId,
          "PremiaPoductCode": event.productCode,
          "ProductCategory": "",
          "VehicleMake": selectedMakeId
        }),
      );

      if (res.statusCode == 200) {
        var resModel = modelResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String, String>> modelList = [];

          for (var vehicleMakeDetail in resModel.vehicleModelDetails!) {
            modelList.add(Tuple2(vehicleMakeDetail.vehicleModel ?? "",
                vehicleMakeDetail.modelDesc ?? ""));
          }

          emit(ModelListLoaded(getList: modelList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  Future<void> getRtoCode(
      GetRtoCodeEvent event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetRtoDetails",
          jsonEncode({
            "Userip": "",
            "Userpartyid": event.partyId,
            "SearchType": "CODE",
            "SearchVal": event.name
          }));

      if (res.statusCode == 200) {
        var resModel = rtoResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String, String>> rtoNameList = [];
          List<Tuple2<String, String>> rtoCodeList = [];

          for (var rtoDetail in resModel.rtoDetails!) {
            rtoNameList.add(Tuple2("", rtoDetail.rtoName!));
            rtoCodeList
                .add(Tuple2("", "${rtoDetail.rtoCode} - ${rtoDetail.rtoName}"));
          }

          emit(PIDetailRtoCodeLoaded(
            rtoCodeList: rtoCodeList,
            rtoNameList: rtoNameList,
          ));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: "Something went wrong: $e"));
    }
  }

  // Separate method for handling RegistrationTypeSelected event
  void handleRegistrationTypeSelected(
      RegistrationTypeSelectedEvent event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    if (event.selectedValue == 2) {
      emit(RegistrationTypeState(
        selectedValue: event.selectedValue,
        rtoCode: "",
        rtoName: "",
        regisNumberOne: "",
        regisNumberTwo: "BH",
        regisNumberThree: "",
        regisNumberFour: "",
      ));
    } else {
      emit(RegistrationTypeState(
        selectedValue: event.selectedValue,
        rtoCode: "",
        rtoName: "",
        regisNumberOne: "",
        regisNumberTwo: "",
        regisNumberThree: "",
        regisNumberFour: "",
      ));
    }
  }

  onShowEndorsementType(
      ShowEndorsementType event, Emitter<PIDetailState> emit) {
    if (event.piPurpose == "Endorsement") {
      isShowEndorsementType = true;
      emit(PIDetailShowEndorsementState(
        isShowEndorsementType: isShowEndorsementType,
        isShowPolicyNumber: isShowEndorsementType,
      ));
    } else {
      isShowEndorsementType = false;
      emit(PIDetailShowEndorsementState(
        isShowEndorsementType: isShowEndorsementType,
        isShowPolicyNumber: isShowEndorsementType,
      ));
    }
  }

  onShowidv(ShowIDV event, Emitter<PIDetailState> emit) {
    if (event.product == "MOTORISED-TWO WHEELERS" ||
        (event.product == "PCCV" &&
            event.vehiclecategory == "PCCV-2 wheelers - carrying passengers")) {
      isShowidv = true;
      emit(IDVShow(isShowepcr: isShowidv));
    } else {
      isShowidv = false;
      emit(IDVShow(isShowepcr: isShowidv));
    }
  }

  onShowVehicleCategory(
      ShowVehicleCategory event, Emitter<PIDetailState> emit) {
    if (["PCCV", "Misc.-D", "GCCV"].contains(event.product)) {
      isShowVehicleCategory = true;
      emit(VehicleCategoryShow(isShowvehiclecategory: isShowVehicleCategory));
    } else {
      isShowVehicleCategory = false;
      emit(VehicleCategoryShow(isShowvehiclecategory: isShowVehicleCategory));
    }
  }

  onShowSeatingCapacity(
      ShowSeatingCapacity event, Emitter<PIDetailState> emit) {
    if (event.product == "PCCV" &&
        event.vehiclecategory ==
            "PCCV-4 (more) wheeled vehicles-capacity > 6 and 3 wheelers-carrying passengers-capacity > 17") {
      isShowSeatingCapacity = true;
      emit(SeatingCapacityShow(isShowseatingCapacity: isShowSeatingCapacity));
    } else {
      isShowSeatingCapacity = false;
      emit(SeatingCapacityShow(isShowseatingCapacity: isShowSeatingCapacity));
    }
  }

  onShowgvw(ShowGVW event, Emitter<PIDetailState> emit) {
    if (event.product == "GCCV") {
      isShowgvw = true;
      emit(GVWShow(isShowgvw: isShowgvw));
    } else {
      isShowgvw = false;
      emit(GVWShow(isShowgvw: isShowgvw));
    }
  }

  onShowepcr(ShowEPCR event, Emitter<PIDetailState> emit) {
    if (event.product == "PRIVATE CAR" &&
        (event.pipurpose == "Nil Dep." ||
            event.pipurpose == "Break-In with Nil Dep.")) {
      isShowepcr = true;
      emit(EPCRShow(isShowepcr: isShowepcr));
    } else {
      isShowepcr = false;
      emit(EPCRShow(isShowepcr: isShowepcr));
    }
  }

  onShowep(ShowEP event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isShowep = !isShowep;
    emit(EPShowState(isShowep: isShowep, value: event.value));
  }

  onShowsgic(ShowSGICEvent event, Emitter<PIDetailState> emit) {
    if (event.proposaltype == "Own Renewal") {
      isShowsgic = true;
      emit(SGICShowState(isShowsgic: isShowsgic));
    } else {
      isShowsgic = false;
      emit(SGICShowState(isShowsgic: isShowsgic));
    }
  }

  onShowcurrentstatus(
      ShowCurrentStatusEvent event, Emitter<PIDetailState> emit) {
    if (event.intimationStatus == "Request Assign to Surveyor") {
      isShowcurrentstatus = true;
      emit(CurrentStatusShowState(isShowcurrentstatus: isShowcurrentstatus));
    } else {
      isShowcurrentstatus = false;
      emit(CurrentStatusShowState(isShowcurrentstatus: isShowcurrentstatus));
    }
  }

  switchpifeecollected(
      PiFeeCollectedToggleSwitch event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isPiFeeCollected = event.isCollected;

    emit(PiFeeCollectedState(isCollected: isPiFeeCollected));
  }

  switchvehicleTypecollected(
      VehicleTypeToggleSwitch event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isvehicleType = event.isCollected;

    emit(VehicleTypeState(isCollected: isvehicleType));
  }

  switchregistrationnumberformatcollected(
      RegistrationNumberFormatToggleSwitch event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isregistrationnumberformat = event.isCollected;

    emit(
        RegistrationNumberFormatState(isCollected: isregistrationnumberformat));
  }

  switchrcverified(
      RcVerifiedToggleSwitchEvent event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isrcVerified = event.isCollected;

    emit(RcVerifiedState(isCollected: isrcVerified));
  }

  switchvehiclerunningcondition(
      VehicleRunningConditionSwitchEvent event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isvehiclerunningcondition = event.isCollected;

    emit(VehicleRunningConditionState(isCollected: isvehiclerunningcondition));
  }

  getidv(IdvSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> idvList = [];

    // Hardcoded seating capacity list
    List<dynamic> idvListData = [
      "Less than 1 Lac",
      "Greater than or equal to 1 Lac"
    ];
    for (var idv in idvListData) {
      idvList.add(Tuple2("", idv));
    }

    // Emit the loaded seating capacity state
    emit(IdvLoaded(getList: idvList));
  }

  getprefix(PrefixSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> prefixList = [];

    // Hardcoded seating capacity list
    List<dynamic> prefixListData = [
      "Mr.",
      "Mrs.",
      "Miss.",
      "M/S.",
    ];
    for (var prefix in prefixListData) {
      prefixList.add(Tuple2("", prefix));
    }

    // Emit the loaded seating capacity state
    emit(PrefixLoaded(getList: prefixList));
  }

  getproposalType(ProposalTypeSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> proposalTypeList = [];

    // Hardcoded seating capacity list
    List<dynamic> proposalTypeListData = [
      "Market Renewal",
      "Market Renewal without previous insurance",
      "Own Renewal"
    ];
    for (var proposalType in proposalTypeListData) {
      proposalTypeList.add(Tuple2("", proposalType));
    }

    // Emit the loaded seating capacity state
    emit(ProposalTypeLoaded(getList: proposalTypeList));
  }

  getpreInspection(PreInspectionSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> preInspectionList = [];

    // Hardcoded seating capacity list
    List<dynamic> preInspectionListData = ["Recommended", "Not Recommended"];
    for (var preInspection in preInspectionListData) {
      preInspectionList.add(Tuple2("", preInspection));
    }

    // Emit the loaded seating capacity state
    emit(PreInspectionLoaded(getList: preInspectionList));
  }

  getNcb(NCBSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> ncbList = [];

    // Hardcoded seating capacity list
    List<dynamic> ncbListData = ["0", "20", "25", "35", "45", "50"];
    for (var ncb in ncbListData) {
      ncbList.add(Tuple2("", ncb));
    }

    // Emit the loaded seating capacity state
    emit(NCBLoaded(getList: ncbList));
  }

  getpayment(PaymentSelect event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    List<Tuple2<String, String>> paymentList = [];

    List<dynamic> paymentListData = ["Cash", "Cheque", "DD"];
    for (var payment in paymentListData) {
      paymentList.add(Tuple2("", payment));
    }

    emit(PaymentLoaded(getList: paymentList));
  }

  getPiSubmit(PISubmitEvent event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    isPiSubmitted = true;

    emit(PISubimtState(isSubmitted: isPiSubmitted));
  }
}

navigatetonxtscreen(
    NavigateToNcxtScreenEvent event, Emitter<PIDetailState> emit) {
  Navigator.push(
    event.context,
    MaterialPageRoute(
      builder: (context) =>
          PreInspectionScreen(preInspectionId: event.preInspectionId),
    ),
  );
}
