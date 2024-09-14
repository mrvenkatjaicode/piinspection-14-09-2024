// To parse this JSON data, do
//
//     final piDashboardResponse = piDashboardResponseFromJson(jsonString);

import 'dart:convert';

PiDashboardResponse piDashboardResponseFromJson(String str) => PiDashboardResponse.fromJson(json.decode(str));

String piDashboardResponseToJson(PiDashboardResponse data) => json.encode(data.toJson());

class PiDashboardResponse {
    MessageResult? messageResult;
    List<PiDetail>? piDetails;

    PiDashboardResponse({
        this.messageResult,
        this.piDetails,
    });

    factory PiDashboardResponse.fromJson(Map<String, dynamic> json) => PiDashboardResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        piDetails: json["PIDetails"] == null ? [] : List<PiDetail>.from(json["PIDetails"]!.map((x) => PiDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "PIDetails": piDetails == null ? [] : List<dynamic>.from(piDetails!.map((x) => x.toJson())),
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

class PiDetail {
    String? preinspectionId;
    String? insuredName;
    String? regNumber;
    String? date;
    String? productCode;
    String? currentStatus;
    String? rootOrgBy;

    PiDetail({
        this.preinspectionId,
        this.insuredName,
        this.regNumber,
        this.date,
        this.productCode,
        this.currentStatus,
        this.rootOrgBy,
    });

    factory PiDetail.fromJson(Map<String, dynamic> json) => PiDetail(
        preinspectionId: json["PreinspectionId"],
        insuredName: json["InsuredName"],
        regNumber: json["RegNumber"],
        date: json["Date"],
        productCode: json["ProductCode"],
        currentStatus: json["CurrentStatus"],
        rootOrgBy: json["RootOrgBy"],
    );

    Map<String, dynamic> toJson() => {
        "PreinspectionId": preinspectionId,
        "InsuredName": insuredName,
        "RegNumber": regNumber,
        "Date": date,
        "ProductCode": productCode,
        "CurrentStatus": currentStatus,
        "RootOrgBy": rootOrgBy,
    };
}
