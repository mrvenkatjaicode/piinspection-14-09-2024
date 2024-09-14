import 'package:equatable/equatable.dart';

abstract class PreInspectionEvent extends Equatable {
  const PreInspectionEvent();

  @override
  List<Object> get props => [];
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

class TakeDocumentEvent extends PreInspectionEvent {}

class SelectDocIdEvent extends PreInspectionEvent {
  final String title;
  final String imageType;

  const SelectDocIdEvent({required this.title, required this.imageType});
}

class GetImageFromApiEvent extends PreInspectionEvent{}