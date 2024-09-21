// To parse this JSON data, do
//
//     final finalSubmitResponse = finalSubmitResponseFromJson(jsonString);

import 'dart:convert';

FinalSubmitResponse finalSubmitResponseFromJson(String str) => FinalSubmitResponse.fromJson(json.decode(str));

String finalSubmitResponseToJson(FinalSubmitResponse data) => json.encode(data.toJson());

class FinalSubmitResponse {
    MessageResult? messageResult;

    FinalSubmitResponse({
        this.messageResult,
    });

    factory FinalSubmitResponse.fromJson(Map<String, dynamic> json) => FinalSubmitResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
    };
}

class MessageResult {
    String? errorMessage;
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
