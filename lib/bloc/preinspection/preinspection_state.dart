import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mnovapi/models/preinspection/delete_api_model.dart';

import '../../models/preinspection/get_image_model.dart';

abstract class PreInspectionState extends Equatable {
  const PreInspectionState();

  @override
  List<Object> get props => [];
}

class DeleteFileApiState extends PreInspectionState {
  final DeleteApiResponse deleteApiResponse;

  const DeleteFileApiState({required this.deleteApiResponse});
}

class FinalSubmitAPIState extends PreInspectionState {
  final String resMsg;

  const FinalSubmitAPIState({required this.resMsg});
}

class MoveToDoneState extends PreInspectionState {
  final bool ismovetodone;

  const MoveToDoneState({required this.ismovetodone});
}

class FileAlreadyUploadedState extends PreInspectionState {
  final String uniqueFileName;

  const FileAlreadyUploadedState({required this.uniqueFileName});
}

class PreInspectionInitialState extends PreInspectionState {}

class PreInspectionLoadingState extends PreInspectionState {}

class VideoRecordedCompletedState extends PreInspectionState {
  final String videoPath;

  const VideoRecordedCompletedState({required this.videoPath});
}

class SignCompletedState extends PreInspectionState {
  final String signature;
  final String signType;

  const SignCompletedState({required this.signature, required this.signType});
}

class SignNotSelectedState extends PreInspectionState {}

class PreInspectionImageSuccessState extends PreInspectionState {
  final List<String> tabDetails;
  final PageController pageController;
  final TabController tabController;

  const PreInspectionImageSuccessState({
    required this.tabDetails,
    required this.pageController,
    required this.tabController,
  });

  @override
  List<Object> get props => [tabDetails /* , pageController, tabController */];
}

class NextPageState extends PreInspectionState {
  final int index;
  final String tabName;

  const NextPageState({required this.index, required this.tabName});
}

class PreInspectionFailureState extends PreInspectionState {
  final String errorMessage;
  const PreInspectionFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ShrigenUploadApiState extends PreInspectionState {
  final String imageURl;
  final String extension;
  final String uniqueFileName;

  const ShrigenUploadApiState(
      {required this.imageURl,
      required this.extension,
      required this.uniqueFileName});
}

class NoFilePicked extends PreInspectionState {}

class FileUploadInProgress extends PreInspectionState {}

class FileUploadedSuccessfully extends PreInspectionState {
  final String referenceValue;
  final String docType;
  final String docId;
  final String userId;
  final String branch;
  final String fileName;
  final String base64Image;

  const FileUploadedSuccessfully(
      {required this.referenceValue,
      required this.docType,
      required this.docId,
      required this.userId,
      required this.branch,
      required this.fileName,
      required this.base64Image});
}

class SelectDocIdState extends PreInspectionState {
  final String docId;
  final String imageType;
  final String tabType;

  const SelectDocIdState(
      {required this.docId, required this.imageType, required this.tabType});
}

class GetImageFromApiState extends PreInspectionState {
  final GetImageResponse getImageResponse;

  const GetImageFromApiState({required this.getImageResponse});
}
