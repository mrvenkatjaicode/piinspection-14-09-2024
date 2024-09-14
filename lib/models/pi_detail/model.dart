// To parse this JSON data, do
//
//     final modelResponse = modelResponseFromJson(jsonString);

import 'dart:convert';

ModelResponse modelResponseFromJson(String str) => ModelResponse.fromJson(json.decode(str));

String modelResponseToJson(ModelResponse data) => json.encode(data.toJson());

class ModelResponse {
    MessageResult? messageResult;
    List<VehicleModelDetail>? vehicleModelDetails;

    ModelResponse({
        this.messageResult,
        this.vehicleModelDetails,
    });

    factory ModelResponse.fromJson(Map<String, dynamic> json) => ModelResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        vehicleModelDetails: json["VehicleModelDetails"] == null ? [] : List<VehicleModelDetail>.from(json["VehicleModelDetails"]!.map((x) => VehicleModelDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "VehicleModelDetails": vehicleModelDetails == null ? [] : List<dynamic>.from(vehicleModelDetails!.map((x) => x.toJson())),
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

class VehicleModelDetail {
    String? bodyDesc;
    String? modelDesc;
    String? vehicleFuel;
    String? vehicleModel;

    VehicleModelDetail({
        this.bodyDesc,
        this.modelDesc,
        this.vehicleFuel,
        this.vehicleModel,
    });

    factory VehicleModelDetail.fromJson(Map<String, dynamic> json) => VehicleModelDetail(
        bodyDesc: json["BodyDesc"],
        modelDesc: json["ModelDesc"],
        vehicleFuel: json["VehicleFuel"],
        vehicleModel: json["VehicleModel"],
    );

    Map<String, dynamic> toJson() => {
        "BodyDesc": bodyDesc,
        "ModelDesc": modelDesc,
        "VehicleFuel": vehicleFuel,
        "VehicleModel": vehicleModel,
    };
}
