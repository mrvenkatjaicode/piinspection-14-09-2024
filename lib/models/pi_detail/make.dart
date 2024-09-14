// To parse this JSON data, do
//
//     final makeResponse = makeResponseFromJson(jsonString);

import 'dart:convert';

MakeResponse makeResponseFromJson(String str) => MakeResponse.fromJson(json.decode(str));

String makeResponseToJson(MakeResponse data) => json.encode(data.toJson());

class MakeResponse {
    MessageResult? messageResult;
    List<VehicleMakeDetail>? vehicleMakeDetails;

    MakeResponse({
        this.messageResult,
        this.vehicleMakeDetails,
    });

    factory MakeResponse.fromJson(Map<String, dynamic> json) => MakeResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        vehicleMakeDetails: json["VehicleMakeDetails"] == null ? [] : List<VehicleMakeDetail>.from(json["VehicleMakeDetails"]!.map((x) => VehicleMakeDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "VehicleMakeDetails": vehicleMakeDetails == null ? [] : List<dynamic>.from(vehicleMakeDetails!.map((x) => x.toJson())),
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

class VehicleMakeDetail {
    String? vehicleMakeCode;
    String? vehicleMakeDesc;

    VehicleMakeDetail({
        this.vehicleMakeCode,
        this.vehicleMakeDesc,
    });

    factory VehicleMakeDetail.fromJson(Map<String, dynamic> json) => VehicleMakeDetail(
        vehicleMakeCode: json["VehicleMakeCode"],
        vehicleMakeDesc: json["VehicleMakeDesc"],
    );

    Map<String, dynamic> toJson() => {
        "VehicleMakeCode": vehicleMakeCode,
        "VehicleMakeDesc": vehicleMakeDesc,
    };
}
