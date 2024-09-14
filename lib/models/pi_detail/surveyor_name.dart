// To parse this JSON data, do
//
//     final surveryorResponse = surveryorResponseFromJson(jsonString);

import 'dart:convert';

SurveryorResponse surveryorResponseFromJson(String str) => SurveryorResponse.fromJson(json.decode(str));

String surveryorResponseToJson(SurveryorResponse data) => json.encode(data.toJson());

class SurveryorResponse {
    MessageResult? messageResult;
    List<SurveyorDetail>? surveyorDetails;

    SurveryorResponse({
        this.messageResult,
        this.surveyorDetails,
    });

    factory SurveryorResponse.fromJson(Map<String, dynamic> json) => SurveryorResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        surveyorDetails: json["SurveyorDetails"] == null ? [] : List<SurveyorDetail>.from(json["SurveyorDetails"]!.map((x) => SurveyorDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "SurveyorDetails": surveyorDetails == null ? [] : List<dynamic>.from(surveyorDetails!.map((x) => x.toJson())),
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

class SurveyorDetail {
    String? surveyorCode;
    String? surveyorPartyId;
    String? surveyorName;
    String? surveyorType;
    String? surveyorPhoneNo;
    String? surveyorMailId;

    SurveyorDetail({
        this.surveyorCode,
        this.surveyorPartyId,
        this.surveyorName,
        this.surveyorType,
        this.surveyorPhoneNo,
        this.surveyorMailId,
    });

    factory SurveyorDetail.fromJson(Map<String, dynamic> json) => SurveyorDetail(
        surveyorCode: json["SurveyorCode"],
        surveyorPartyId: json["SurveyorPartyID"],
        surveyorName: json["SurveyorName"],
        surveyorType: json["SurveyorType"],
        surveyorPhoneNo: json["SurveyorPhoneNo"],
        surveyorMailId: json["SurveyorMailId"],
    );

    Map<String, dynamic> toJson() => {
        "SurveyorCode": surveyorCode,
        "SurveyorPartyID": surveyorPartyId,
        "SurveyorName": surveyorName,
        "SurveyorType": surveyorType,
        "SurveyorPhoneNo": surveyorPhoneNo,
        "SurveyorMailId": surveyorMailId,
    };
}
