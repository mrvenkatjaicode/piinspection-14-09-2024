// To parse this JSON data, do
//
//     final shrigenUploadFileResponse = shrigenUploadFileResponseFromJson(jsonString);

import 'dart:convert';

ShrigenUploadFileResponse shrigenUploadFileResponseFromJson(String str) => ShrigenUploadFileResponse.fromJson(json.decode(str));

String shrigenUploadFileResponseToJson(ShrigenUploadFileResponse data) => json.encode(data.toJson());

class ShrigenUploadFileResponse {
    MessageResult? messageResult;
    String? attachmentId;
    List<DocFileUploadDetail>? docFileUploadDetails;

    ShrigenUploadFileResponse({
        this.messageResult,
        this.attachmentId,
        this.docFileUploadDetails,
    });

    factory ShrigenUploadFileResponse.fromJson(Map<String, dynamic> json) => ShrigenUploadFileResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        attachmentId: json["AttachmentId"],
        docFileUploadDetails: json["DocFileUploadDetails"] == null ? [] : List<DocFileUploadDetail>.from(json["DocFileUploadDetails"]!.map((x) => DocFileUploadDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "AttachmentId": attachmentId,
        "DocFileUploadDetails": docFileUploadDetails == null ? [] : List<dynamic>.from(docFileUploadDetails!.map((x) => x.toJson())),
    };
}

class DocFileUploadDetail {
    String? fileName;
    String? uniqueFileName;
    String? extension;
    String? tagName;
    String? tagId;
    String? xbizid;
    String? xbizurl;
    String? applicationNo;

    DocFileUploadDetail({
        this.fileName,
        this.uniqueFileName,
        this.extension,
        this.tagName,
        this.tagId,
        this.xbizid,
        this.xbizurl,
        this.applicationNo,
    });

    factory DocFileUploadDetail.fromJson(Map<String, dynamic> json) => DocFileUploadDetail(
        fileName: json["FileName"],
        uniqueFileName: json["UniqueFileName"],
        extension: json["Extension"],
        tagName: json["TagName"],
        tagId: json["TagId"],
        xbizid: json["XBIZID"],
        xbizurl: json["XBIZURL"],
        applicationNo: json["ApplicationNo"],
    );

    Map<String, dynamic> toJson() => {
        "FileName": fileName,
        "UniqueFileName": uniqueFileName,
        "Extension": extension,
        "TagName": tagName,
        "TagId": tagId,
        "XBIZID": xbizid,
        "XBIZURL": xbizurl,
        "ApplicationNo": applicationNo,
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
