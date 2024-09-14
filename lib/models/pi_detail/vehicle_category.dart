// To parse this JSON data, do
//
//     final vehicleCategoryResponse = vehicleCategoryResponseFromJson(jsonString);

import 'dart:convert';

VehicleCategoryResponse vehicleCategoryResponseFromJson(String str) => VehicleCategoryResponse.fromJson(json.decode(str));

String vehicleCategoryResponseToJson(VehicleCategoryResponse data) => json.encode(data.toJson());

class VehicleCategoryResponse {
    MessageResult? messageResult;
    List<Response>? response;

    VehicleCategoryResponse({
        this.messageResult,
        this.response,
    });

    factory VehicleCategoryResponse.fromJson(Map<String, dynamic> json) => VehicleCategoryResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        response: json["Response"] == null ? [] : List<Response>.from(json["Response"]!.map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "Response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
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

class Response {
    String? pcCode;
    String? pcDesc;

    Response({
        this.pcCode,
        this.pcDesc,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        pcCode: json["pcCode"],
        pcDesc: json["pcDesc"],
    );

    Map<String, dynamic> toJson() => {
        "pcCode": pcCode,
        "pcDesc": pcDesc,
    };
}
