// To parse this JSON data, do
//
//     final rtoResponse = rtoResponseFromJson(jsonString);

import 'dart:convert';

RtoResponse rtoResponseFromJson(String str) => RtoResponse.fromJson(json.decode(str));

String rtoResponseToJson(RtoResponse data) => json.encode(data.toJson());

class RtoResponse {
    MessageResult? messageResult;
    List<RtoDetail>? rtoDetails;

    RtoResponse({
        this.messageResult,
        this.rtoDetails,
    });

    factory RtoResponse.fromJson(Map<String, dynamic> json) => RtoResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        rtoDetails: json["RtoDetails"] == null ? [] : List<RtoDetail>.from(json["RtoDetails"]!.map((x) => RtoDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "RtoDetails": rtoDetails == null ? [] : List<dynamic>.from(rtoDetails!.map((x) => x.toJson())),
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

class RtoDetail {
    String? rtoCode;
    String? rtoName;
    String? rtoZoneCode;
    String? rtoZone;

    RtoDetail({
        this.rtoCode,
        this.rtoName,
        this.rtoZoneCode,
        this.rtoZone,
    });

    factory RtoDetail.fromJson(Map<String, dynamic> json) => RtoDetail(
        rtoCode: json["RtoCode"],
        rtoName: json["RtoName"],
        rtoZoneCode: json["RtoZoneCode"],
        rtoZone: json["RtoZone"],
    );

    Map<String, dynamic> toJson() => {
        "RtoCode": rtoCode,
        "RtoName": rtoName,
        "RtoZoneCode": rtoZoneCode,
        "RtoZone": rtoZone,
    };
}
