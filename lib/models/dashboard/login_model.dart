// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    MessageResult? messageResult;
    String? userpartyid;
    String? partyName;
    String? sessionId;
    String? loginUser;
    String? lastLoginDtTime;
    String? versionCode;
    String? apkUrl;
    String? preinspectionServiceUrl;
    String? preinspectionSearchUrl;

    LoginResponse({
        this.messageResult,
        this.userpartyid,
        this.partyName,
        this.sessionId,
        this.loginUser,
        this.lastLoginDtTime,
        this.versionCode,
        this.apkUrl,
        this.preinspectionServiceUrl,
        this.preinspectionSearchUrl,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        userpartyid: json["Userpartyid"],
        partyName: json["PartyName"],
        sessionId: json["SessionId"],
        loginUser: json["LoginUser"],
        lastLoginDtTime: json["LastLoginDtTime"],
        versionCode: json["VersionCode"],
        apkUrl: json["ApkUrl"],
        preinspectionServiceUrl: json["PreinspectionServiceUrl"],
        preinspectionSearchUrl: json["PreinspectionSearchUrl"],
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "Userpartyid": userpartyid,
        "PartyName": partyName,
        "SessionId": sessionId,
        "LoginUser": loginUser,
        "LastLoginDtTime": lastLoginDtTime,
        "VersionCode": versionCode,
        "ApkUrl": apkUrl,
        "PreinspectionServiceUrl": preinspectionServiceUrl,
        "PreinspectionSearchUrl": preinspectionSearchUrl,
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
