// To parse this JSON data, do
//
//     final preInspectionImageResponse = preInspectionImageResponseFromJson(jsonString);

import 'dart:convert';

PreInspectionImageResponse preInspectionImageResponseFromJson(String str) => PreInspectionImageResponse.fromJson(json.decode(str));

String preInspectionImageResponseToJson(PreInspectionImageResponse data) => json.encode(data.toJson());

class PreInspectionImageResponse {
    List<String>? response;
    ResponseImage? responseImage;

    PreInspectionImageResponse({
        this.response,
        this.responseImage,
    });

    factory PreInspectionImageResponse.fromJson(Map<String, dynamic> json) => PreInspectionImageResponse(
        response: json["Response"] == null ? [] : List<String>.from(json["Response"]!.map((x) => x)),
        responseImage: json["ResponseImage"] == null ? null : ResponseImage.fromJson(json["ResponseImage"]),
    );

    Map<String, dynamic> toJson() => {
        "Response": response == null ? [] : List<dynamic>.from(response!.map((x) => x)),
        "ResponseImage": responseImage?.toJson(),
    };
}

class ResponseImage {
    String? engravedChassis;
    String? engravedChassisNo;
    String? signature;
    String? back;
    String? more;
    String? right;
    String? odometer;
    String? executivePhotographsWithTheVehicle;
    String? left;
    String? front;

    ResponseImage({
        this.engravedChassis,
        this.engravedChassisNo,
        this.signature,
        this.back,
        this.more,
        this.right,
        this.odometer,
        this.executivePhotographsWithTheVehicle,
        this.left,
        this.front,
    });

    factory ResponseImage.fromJson(Map<String, dynamic> json) => ResponseImage(
        engravedChassis: json["ENGRAVED CHASSIS"],
        engravedChassisNo: json["ENGRAVED CHASSIS NO"],
        signature: json["SIGNATURE"],
        back: json["BACK"],
        more: json["MORE"],
        right: json["RIGHT"],
        odometer: json["ODOMETER"],
        executivePhotographsWithTheVehicle: json["EXECUTIVE PHOTOGRAPHS WITH THE VEHICLE"],
        left: json["LEFT"],
        front: json["FRONT"],
    );

    Map<String, dynamic> toJson() => {
        "ENGRAVED CHASSIS": engravedChassis,
        "ENGRAVED CHASSIS NO": engravedChassisNo,
        "SIGNATURE": signature,
        "BACK": back,
        "MORE": more,
        "RIGHT": right,
        "ODOMETER": odometer,
        "EXECUTIVE PHOTOGRAPHS WITH THE VEHICLE": executivePhotographsWithTheVehicle,
        "LEFT": left,
        "FRONT": front,
    };
}
