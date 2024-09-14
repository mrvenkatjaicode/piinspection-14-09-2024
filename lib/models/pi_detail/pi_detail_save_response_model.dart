// To parse this JSON data, do
//
//     final piDetailSaveResponse = piDetailSaveResponseFromJson(jsonString);

import 'dart:convert';

PiDetailSaveResponse piDetailSaveResponseFromJson(String str) => PiDetailSaveResponse.fromJson(json.decode(str));

String piDetailSaveResponseToJson(PiDetailSaveResponse data) => json.encode(data.toJson());

class PiDetailSaveResponse {
    MessageResult? messageResult;
    String? preInspectionId;
    String? attachmentId;

    PiDetailSaveResponse({
        this.messageResult,
        this.preInspectionId,
        this.attachmentId,
    });

    factory PiDetailSaveResponse.fromJson(Map<String, dynamic> json) => PiDetailSaveResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        preInspectionId: json["PreInspectionId"],
        attachmentId: json["AttachmentId"],
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "PreInspectionId": preInspectionId,
        "AttachmentId": attachmentId,
    };
}

class MessageResult {
    dynamic errorMessage;
    String? result;
    String? successMessage;

    MessageResult({
        this.errorMessage,
        this.result,
        this.successMessage,
    });

    factory MessageResult.fromJson(Map<String, dynamic> json) => MessageResult(
        errorMessage: json["ErrorMessage"],
        result: json["Result"],
        successMessage: json["SuccessMessage"],
    );

    Map<String, dynamic> toJson() => {
        "ErrorMessage": errorMessage,
        "Result": result,
        "SuccessMessage": successMessage,
    };
}
