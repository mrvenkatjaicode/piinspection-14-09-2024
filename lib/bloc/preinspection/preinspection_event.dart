import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PreInspectionEvent extends Equatable {
  const PreInspectionEvent();

  @override
  List<Object> get props => [];
}

class DeleteFileApiEvent extends PreInspectionEvent {
  final String userPartyId;
  final String userIp;
  final String preInspectionId;
  final String uniqueFileName;

  const DeleteFileApiEvent(
      {required this.userPartyId,
      required this.userIp,
      required this.preInspectionId,
      required this.uniqueFileName});
}

class FinalSubmitAPIEvent extends PreInspectionEvent {
  final String userPartyId;
  final String preInspectionId;

  const FinalSubmitAPIEvent(
      {required this.userPartyId, required this.preInspectionId});
}

class GetPreInspectionImageApiEvent extends PreInspectionEvent {
  final String preinspectionid;
  const GetPreInspectionImageApiEvent(this.preinspectionid);
}

class UpdatePageIndexEvent extends PreInspectionEvent {
  final int index;

  const UpdatePageIndexEvent(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateTabIndexEvent extends PreInspectionEvent {
  final int index;
  final String tabName;

  const UpdateTabIndexEvent(this.index, this.tabName);

  @override
  List<Object> get props => [index];
}

class ShrigenUploadApiEvent extends PreInspectionEvent {
  final String referenceValue;
  final String docType;
  final String docId;
  final String userId;
  final String branch;
  final String fileName;
  final String base64Image;

  const ShrigenUploadApiEvent(
      {required this.referenceValue,
      required this.docType,
      required this.docId,
      required this.userId,
      required this.branch,
      required this.fileName,
      required this.base64Image});
}

class TakePhotEvent extends PreInspectionEvent {
  final String imageType;
  final String referenceValue;
  final String docType;
  final String docId;
  final String userId;
  final String branch;
  final String fileName;
  final String base64Image;
  const TakePhotEvent(
      {required this.imageType,
      required this.referenceValue,
      required this.docType,
      required this.docId,
      required this.userId,
      required this.branch,
      required this.fileName,
      required this.base64Image});
}

class TakeVideoEvent extends PreInspectionEvent {}

class TakeDocumentEvent extends PreInspectionEvent {
  final String imageType;
  final String referenceValue;
  final String docType;
  final String docId;
  final String userId;
  final String branch;
  final String fileName;
  final String base64Image;
  const TakeDocumentEvent(
      {required this.imageType,
      required this.referenceValue,
      required this.docType,
      required this.docId,
      required this.userId,
      required this.branch,
      required this.fileName,
      required this.base64Image});
}

class SelectDocIdEvent extends PreInspectionEvent {
  final String title;
  final String imageType;

  const SelectDocIdEvent({required this.title, required this.imageType});
}

class NavigateToVideoScreenEvent extends PreInspectionEvent {
  final BuildContext context;

  const NavigateToVideoScreenEvent({required this.context});
}

class NavigateToSignScreenEvent extends PreInspectionEvent {
  final BuildContext context;
  final String signType;

  const NavigateToSignScreenEvent(
      {required this.context, required this.signType});
}

class MoveToDoneEvent extends PreInspectionEvent {
  final bool ismovetodone;

  const MoveToDoneEvent({required this.ismovetodone});
}

class FileAlreadyUploadedEvent extends PreInspectionEvent {
  final String uniqueFileName;

 const FileAlreadyUploadedEvent({required this.uniqueFileName});
}

class GetImageFromApiEvent extends PreInspectionEvent {}
