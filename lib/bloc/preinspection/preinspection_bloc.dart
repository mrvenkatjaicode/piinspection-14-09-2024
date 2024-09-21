import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mnovapi/models/preinspection/delete_api_model.dart';
import 'package:mnovapi/models/preinspection/final_submit_model.dart';
import 'package:mnovapi/screens/preinspection/video_recording/video_recording_screen.dart';
import 'package:mnovapi/screens/signature/signature_screen.dart';
import 'package:mnovapi/utils/constant.dart';
import 'package:tuple/tuple.dart';

import '../../core/services.dart' as api;
import '../../models/preinspection/get_image_model.dart';
import '../../models/preinspection/preinspection_image_res.dart';
import '../../models/preinspection/shrigen_upload_model.dart';
import 'preinspection_event.dart';
import 'preinspection_state.dart';

class PreInspectionBloc extends Bloc<PreInspectionEvent, PreInspectionState> {
  TabController? tabController;
  PageController? pageController;
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? base64Image;
  bool? ismovetodone;
  String? videoPath;
  String? signature;

  PreInspectionBloc(this.vsync) : super(PreInspectionInitialState()) {
    on<GetPreInspectionImageApiEvent>(getSurveyorDetail);
    add(GetPreInspectionImageApiEvent(preInspectionId));
    on<UpdatePageIndexEvent>(updatePageIndex);
    on<UpdateTabIndexEvent>(updateTabIndex);
    on<TakePhotEvent>(getImagefromCamara);
    on<TakeDocumentEvent>(getdocument);
    on<ShrigenUploadApiEvent>(uploadshrigenapi);
    on<SelectDocIdEvent>(getDocId);
    on<GetImageFromApiEvent>(getImageFromApi);
    on<NavigateToVideoScreenEvent>(navtovideoScreen);
    on<NavigateToSignScreenEvent>(navigatetoSignScreen);
    on<MoveToDoneEvent>(movetodone);
    on<FinalSubmitAPIEvent>(finalSubmitAPI);
    on<FileAlreadyUploadedEvent>(showAlreadyUploadedDialog);
    on<DeleteFileApiEvent>(deleteFileApi);
  }
  final TickerProvider vsync;

  showAlreadyUploadedDialog(
      FileAlreadyUploadedEvent event, Emitter<PreInspectionState> emit) {
    emit(PreInspectionLoadingState());
    emit(FileAlreadyUploadedState(uniqueFileName: event.uniqueFileName));
  }

  deleteFileApi(
      DeleteFileApiEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/DeletePIImage",
          jsonEncode({
            "Userpartyid": event.userPartyId,
            "Userip": event.userIp,
            "PreinspectionId": event.preInspectionId,
            "UniqueFileName": event.uniqueFileName
          }));

      if (res.statusCode == 200) {
        var resModel = deleteApiResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == "Success") {
          emit(DeleteFileApiState(deleteApiResponse: resModel));
        } else {
          emit(PreInspectionFailureState(
              resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PreInspectionFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(PreInspectionFailureState(e.toString()));
    }
  }

  finalSubmitAPI(
      FinalSubmitAPIEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/SubmitPreinspection",
          jsonEncode({
            "Userpartyid": event.userPartyId,
            "PreinspectionId": event.preInspectionId
          }));

      if (res.statusCode == 200) {
        var resModel = finalSubmitResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == "Success") {
          emit(FinalSubmitAPIState(
              resMsg: resModel.messageResult!.successMessage ?? ""));
        } else {
          emit(PreInspectionFailureState(
              resModel.messageResult!.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PreInspectionFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(PreInspectionFailureState(e.toString()));
    }
  }

  movetodone(MoveToDoneEvent event, Emitter<PreInspectionState> emit) {
    emit(PreInspectionLoadingState());
    ismovetodone = event.ismovetodone;
    emit(MoveToDoneState(ismovetodone: ismovetodone ?? false));
  }

  navtovideoScreen(NavigateToVideoScreenEvent event,
      Emitter<PreInspectionState> emit) async {
    final result = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) {
          return VideoRecordingScreen();
        },
      ),
    );
    if (result != null) {
      videoPath = result.path;
      debugPrint("Video File Path **** ---- ${result.path}");
      emit(VideoRecordedCompletedState(videoPath: videoPath ?? ""));
    }
  }

  navigatetoSignScreen(
      NavigateToSignScreenEvent event, Emitter<PreInspectionState> emit) async {
    dynamic signatureImage = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => SignatureScreen(
          title: "Signature",
          image64: (signature) {
            // base64Encode(signature);
            //  emit(SignCompletedState(signature: base64Encode(signature)));
            // Handle signature
          },
        ),
      ),
    );
    if (signatureImage != null) {
      signature = base64Encode(signatureImage);
      emit(SignCompletedState(
          signature: base64Encode(signatureImage), signType: event.signType));
    } else {
      emit(SignNotSelectedState());
    }
  }

  getImageFromApi(
      GetImageFromApiEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/PreinspectionSearch",
          jsonEncode({
            "PREINSPECTIONID": preInspectionId,
            "TAGNAME": "PI_REPORT_VIEWSEARCH",
            "Userpartyid": userId,
            "Userip": ""
          }));

      if (res.statusCode == 200) {
        var resModel = getImageResponseFromJson(res.resBody);

        emit(GetImageFromApiState(getImageResponse: resModel));
      } else {
        emit(const PreInspectionFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(PreInspectionFailureState(e.toString()));
    }
  }

  getSurveyorDetail(GetPreInspectionImageApiEvent event,
      Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());

    try {
      api.Response res = await api.ApiService().postRequest(
          "http://shriramgeneral.net.in/cloud/shrisurance/PreInspection/getPreinspectionPictureModes",
          jsonEncode({"preInsId": event.preinspectionid}));

      if (res.statusCode == 200) {
        List<Tuple2<String, dynamic>> defaultvehicleimages = [];
        var resModel = preInspectionImageResponseFromJson(res.resBody);
        Map<String, dynamic> map = json.decode(res.resBody);
        Map<String, dynamic> data = map["ResponseImage"];

        for (var coln in data.keys) {
          defaultvehicleimages.add(Tuple2(coln, data[coln]));
        }

        List<String> tabdetails = [];

        for (int i = 0; i < resModel.response!.length; i++) {
          for (int j = 0; j < defaultvehicleimages.length; j++) {
            if (defaultvehicleimages[j].item1.toString() != "SIGNATURE") {
              if (resModel.response![i].toString() ==
                  defaultvehicleimages[j].item1.toString()) {
                tabdetails.add(
                    "${defaultvehicleimages[j].item1}:${defaultvehicleimages[j].item2}");
              }
            }
          }
        }
        tabdetails.add("VIDEO RECORDING: ");
        for (int j = 0; j < defaultvehicleimages.length; j++) {
          if (defaultvehicleimages[j].item1.toString() == "SIGNATURE") {
            for (int i = 0; i < resModel.response!.length; i++) {
              if (resModel.response![i].toString() ==
                      defaultvehicleimages[j].item1.toString() &&
                  (resModel.response![i].toString() == "SIGNATURE")) {
                tabdetails.add(
                    "${defaultvehicleimages[j].item1}:${defaultvehicleimages[j].item2}");
              }
            }
          }
        }
        PageController pageController = PageController();
        TabController tabController = TabController(
          length: tabdetails.length,
          vsync: vsync,
        );
        emit(PreInspectionImageSuccessState(
            tabDetails: tabdetails,
            tabController: tabController,
            pageController: pageController));
      } else {
        emit(const PreInspectionFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(PreInspectionFailureState(e.toString()));
    }
  }

  void updatePageIndex(
      UpdatePageIndexEvent event, Emitter<PreInspectionState> emit) {}

  void updateTabIndex(
      UpdateTabIndexEvent event, Emitter<PreInspectionState> emit) {
    emit(PreInspectionLoadingState());
    emit(NextPageState(index: event.index, tabName: event.tabName));
  }

  getImagefromCamara(
      TakePhotEvent event, Emitter<PreInspectionState> emit) async {
    debugPrint("sfasdf");
    emit(PreInspectionLoadingState());

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
      var val = DateFormat("yyyyMMdd'_'HHmmss")
          .format(DateTime.now()); //IMG_20221220_140836

      var filename = "IMG_$val.png";
      emit(FileUploadedSuccessfully(
          referenceValue: attachmentId,
          docType: "Image",
          docId: event.docId,
          userId: userId,
          branch: "",
          fileName: filename,
          base64Image: base64Image ?? ""));
    } else {
      emit(NoFilePicked());
    }

    //  uploadshrigenapi(event, emit);
  }

  getDocId(SelectDocIdEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    switch (event.title) {
      case "FRONT":
        docId = "226";
        break;
      case "RIGHT":
        docId = "227";
        break;
      case "BACK":
        docId = "228";
        break;
      case "LEFT":
        docId = "229";
        break;
      case "ODOMETER":
        docId = "191";
        break;
      case "ENGRAVED CHASSIS":
        docId = "248";
        break;
      case "EXECUTIVE PHOTOGRAPHS WITH THE VEHICLE":
        docId = "11";
        break;
      case "ENGINE COMPARTMENT":
        docId = "249";
        break;
      case "UNDERCARRIAGE":
        docId = "232";
        break;
      case "WIND SHIELD":
        docId = "233";
        break;
      case "INSIDE WIND SHIELD":
        docId = "265";
        break;
      case "DICKY":
        docId = "234";
        break;
      case "MORE":
        docId = "235";
        break;
      case "SIGNATURE":
        docId = "212";
        break;
      case "RC":
        docId = "204";
        break;
      case "OTHER DOCUMENTS":
        docId = "247";
        break;
      case "PHOTO ID PROOF":
        docId = "250";
        break;
      case "VIDEO RECORDING":
        docId = "251";
        break;
      default:
        docId = "247";
    }
    event.title == "VIDEO RECORDING"
        ? emit(FileUploadedSuccessfully(
            referenceValue: attachmentId,
            docType: "Video",
            docId: docId,
            userId: userId,
            branch: "",
            fileName: "Video.mp4",
            base64Image: base64Encode(File(videoPath ?? "").readAsBytesSync()),
          ))
        : event.title == "SIGNATURE"
            ? emit(FileUploadedSuccessfully(
                referenceValue: attachmentId,
                docType: "Sign",
                docId: docId,
                userId: userId,
                branch: "",
                fileName: "Sign.png",
                base64Image: signature ?? "",
              ))
            : emit(SelectDocIdState(
                docId: docId,
                imageType: event.imageType,
                tabType: event.title));
  }

  uploadshrigenapi(
      ShrigenUploadApiEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ShrigenFileUpload.svc/RestService/ShrigenUploadFiles",
          jsonEncode({
            "ApplicationName": "Mobile",
            "ScreenID": "MOB014",
            "FileCategory": "",
            "Product": "",
            "ReferenceValue": event.referenceValue,
            "ReferenceType": "PI",
            "Source": "Mobile",
            "DocType": event.docType,
            "DocId": docId,
            "UploadType": "PI",
            "UserId": event.userId,
            "Branch": event.branch,
            "Action": "SU",
            "FileDetails": [
              {"FileName": event.fileName, "base64Image": event.base64Image}
            ]
          }));

      if (res.statusCode == 200) {
        var resModel = shrigenUploadFileResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == "Success") {
          emit(ShrigenUploadApiState(
              imageURl: resModel.docFileUploadDetails![0].xbizurl ?? "",
              extension: resModel.docFileUploadDetails![0].extension ?? "",
              uniqueFileName:
                  resModel.docFileUploadDetails![0].uniqueFileName ?? ""));
        } else {
          emit(PreInspectionFailureState(resModel.messageResult!.errorMessage));
        }
      } else {
        emit(const PreInspectionFailureState("Request Failed!"));
      }
    } catch (e) {
      emit(PreInspectionFailureState(e.toString()));
    }
  }

  getdocument(TakeDocumentEvent event, Emitter<PreInspectionState> emit) async {
    emit(PreInspectionLoadingState());
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result == null) {
      emit(NoFilePicked());
      return;
    } else {
      final bytes = File(result.files.first.path!).readAsBytesSync();
      final String file64 = base64Encode(bytes);
      final String fileName = result.names[0] ?? '';
      // var val = DateFormat("yyyyMMdd'_'HHmmss").format(DateTime.now());
      //   var filename = val;
      emit(FileUploadedSuccessfully(
          referenceValue: attachmentId,
          docType: "Image",
          docId: event.docId,
          userId: userId,
          branch: "",
          fileName: fileName,
          base64Image: file64));
    }
  }
}
