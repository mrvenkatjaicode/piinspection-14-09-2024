// To parse this JSON data, do
//
//     final deleteApiResponse = deleteApiResponseFromJson(jsonString);

import 'dart:convert';

DeleteApiResponse deleteApiResponseFromJson(String str) => DeleteApiResponse.fromJson(json.decode(str));

String deleteApiResponseToJson(DeleteApiResponse data) => json.encode(data.toJson());

class DeleteApiResponse {
    MessageResult? messageResult;

    DeleteApiResponse({
        this.messageResult,
    });

    factory DeleteApiResponse.fromJson(Map<String, dynamic> json) => DeleteApiResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
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
