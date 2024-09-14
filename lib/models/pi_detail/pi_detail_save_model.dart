// To parse this JSON data, do
//
//     final piDetailSaveRequest = piDetailSaveRequestFromJson(jsonString);

import 'dart:convert';

PiDetailSaveRequest piDetailSaveRequestFromJson(String str) => PiDetailSaveRequest.fromJson(json.decode(str));

String piDetailSaveRequestToJson(PiDetailSaveRequest data) => json.encode(data.toJson());

class PiDetailSaveRequest {
    String? branchPartyId;
    String? surveyorPartyId;
    String? productType;
    String? productCategory;
    String? vehicleType;
    String? registrationFormat;
    String? registrationNo;
    String? engineNo;
    String? chassisNo;
    String? make;
    String? model;
    String? fueltype;
    String? yearOfManufacturing;
    String? inspectionLocation;
    String? contactPerson;
    String? contactMobileNo;
    String? insuredName;
    String? piPurpose;
    String? endorsementType;
    String? policyNo;
    String? ncbPercentage;
    String? contactNoforSms;
    String? intimationRemarks;
    String? userPartyId;
    String? sourceFrom;
    String? loginId;
    String? idvofvehicle;
    String? proposalType;
    String? surveydonebyInsured;
    String? sgicPolicyNumber;
    String? engineprotectorcover;
    String? contactnoToSendlink;
    String? gvw;
    String? seatingcapacity;
    List<RequestPifilesuploadObj>? requestPifilesuploadObj;
    String? attachmentId;
    String? preInspectionId;
    String? title;
    String? odometerReading;
    String? agencyStatus;
    String? rcVerified;
    String? surveyorRemark;
    String? vehRunningCondition;
    String? branch;
    String? piFeesAmount;
    String? conveyanceAmount;
    String? modeofPayment;
    String? referenceNumber;
    String? piFeesCollected;

    PiDetailSaveRequest({
        this.branchPartyId,
        this.surveyorPartyId,
        this.productType,
        this.productCategory,
        this.vehicleType,
        this.registrationFormat,
        this.registrationNo,
        this.engineNo,
        this.chassisNo,
        this.make,
        this.model,
        this.fueltype,
        this.yearOfManufacturing,
        this.inspectionLocation,
        this.contactPerson,
        this.contactMobileNo,
        this.insuredName,
        this.piPurpose,
        this.endorsementType,
        this.policyNo,
        this.ncbPercentage,
        this.contactNoforSms,
        this.intimationRemarks,
        this.userPartyId,
        this.sourceFrom,
        this.loginId,
        this.idvofvehicle,
        this.proposalType,
        this.surveydonebyInsured,
        this.sgicPolicyNumber,
        this.engineprotectorcover,
        this.contactnoToSendlink,
        this.gvw,
        this.seatingcapacity,
        this.requestPifilesuploadObj,
        this.attachmentId,
        this.preInspectionId,
        this.title,
        this.odometerReading,
        this.agencyStatus,
        this.rcVerified,
        this.surveyorRemark,
        this.vehRunningCondition,
        this.branch,
        this.piFeesAmount,
        this.conveyanceAmount,
        this.modeofPayment,
        this.referenceNumber,
        this.piFeesCollected,
    });

    factory PiDetailSaveRequest.fromJson(Map<String, dynamic> json) => PiDetailSaveRequest(
        branchPartyId: json["BranchPartyId"],
        surveyorPartyId: json["SurveyorPartyId"],
        productType: json["ProductType"],
        productCategory: json["ProductCategory"],
        vehicleType: json["VehicleType"],
        registrationFormat: json["RegistrationFormat"],
        registrationNo: json["RegistrationNo"],
        engineNo: json["EngineNo"],
        chassisNo: json["ChassisNo"],
        make: json["Make"],
        model: json["Model"],
        fueltype: json["FUELTYPE"],
        yearOfManufacturing: json["YearOfManufacturing"],
        inspectionLocation: json["InspectionLocation"],
        contactPerson: json["ContactPerson"],
        contactMobileNo: json["ContactMobileNo"],
        insuredName: json["InsuredName"],
        piPurpose: json["PIPurpose"],
        endorsementType: json["EndorsementType"],
        policyNo: json["PolicyNo"],
        ncbPercentage: json["NCBPercentage"],
        contactNoforSms: json["ContactNoforSMS"],
        intimationRemarks: json["IntimationRemarks"],
        userPartyId: json["UserPartyId"],
        sourceFrom: json["SourceFrom"],
        loginId: json["LoginId"],
        idvofvehicle: json["IDVOFVEHICLE"],
        proposalType: json["ProposalType"],
        surveydonebyInsured: json["SURVEYDONEBY_INSURED"],
        sgicPolicyNumber: json["SGICPolicyNumber"],
        engineprotectorcover: json["ENGINEPROTECTORCOVER"],
        contactnoToSendlink: json["CONTACTNO_TO_SENDLINK"],
        gvw: json["GVW"],
        seatingcapacity: json["SEATINGCAPACITY"],
        requestPifilesuploadObj: json["RequestPIFILESUPLOADObj"] == null ? [] : List<RequestPifilesuploadObj>.from(json["RequestPIFILESUPLOADObj"]!.map((x) => RequestPifilesuploadObj.fromJson(x))),
        attachmentId: json["AttachmentId"],
        preInspectionId: json["PreInspectionId"],
        title: json["Title"],
        odometerReading: json["OdometerReading"],
        agencyStatus: json["AgencyStatus"],
        rcVerified: json["RCVerified"],
        surveyorRemark: json["SurveyorRemark"],
        vehRunningCondition: json["VehRunningCondition"],
        branch: json["Branch"],
        piFeesAmount: json["PIFeesAmount"],
        conveyanceAmount: json["ConveyanceAmount"],
        modeofPayment: json["ModeofPayment"],
        referenceNumber: json["ReferenceNumber"],
        piFeesCollected: json["PIFeesCollected"],
    );

    Map<String, dynamic> toJson() => {
        "BranchPartyId": branchPartyId,
        "SurveyorPartyId": surveyorPartyId,
        "ProductType": productType,
        "ProductCategory": productCategory,
        "VehicleType": vehicleType,
        "RegistrationFormat": registrationFormat,
        "RegistrationNo": registrationNo,
        "EngineNo": engineNo,
        "ChassisNo": chassisNo,
        "Make": make,
        "Model": model,
        "FUELTYPE": fueltype,
        "YearOfManufacturing": yearOfManufacturing,
        "InspectionLocation": inspectionLocation,
        "ContactPerson": contactPerson,
        "ContactMobileNo": contactMobileNo,
        "InsuredName": insuredName,
        "PIPurpose": piPurpose,
        "EndorsementType": endorsementType,
        "PolicyNo": policyNo,
        "NCBPercentage": ncbPercentage,
        "ContactNoforSMS": contactNoforSms,
        "IntimationRemarks": intimationRemarks,
        "UserPartyId": userPartyId,
        "SourceFrom": sourceFrom,
        "LoginId": loginId,
        "IDVOFVEHICLE": idvofvehicle,
        "ProposalType": proposalType,
        "SURVEYDONEBY_INSURED": surveydonebyInsured,
        "SGICPolicyNumber": sgicPolicyNumber,
        "ENGINEPROTECTORCOVER": engineprotectorcover,
        "CONTACTNO_TO_SENDLINK": contactnoToSendlink,
        "GVW": gvw,
        "SEATINGCAPACITY": seatingcapacity,
        "RequestPIFILESUPLOADObj": requestPifilesuploadObj == null ? [] : List<dynamic>.from(requestPifilesuploadObj!.map((x) => x.toJson())),
        "AttachmentId": attachmentId,
        "PreInspectionId": preInspectionId,
        "Title": title,
        "OdometerReading": odometerReading,
        "AgencyStatus": agencyStatus,
        "RCVerified": rcVerified,
        "SurveyorRemark": surveyorRemark,
        "VehRunningCondition": vehRunningCondition,
        "Branch": branch,
        "PIFeesAmount": piFeesAmount,
        "ConveyanceAmount": conveyanceAmount,
        "ModeofPayment": modeofPayment,
        "ReferenceNumber": referenceNumber,
        "PIFeesCollected": piFeesCollected,
    };
}

class RequestPifilesuploadObj {
    String? tagName;
    String? tagId;
    String? fileName;
    String? base64Value;
    String? uniqueFileName;
    String? extension;
    String? xbizid;
    String? xbizurl;

    RequestPifilesuploadObj({
        this.tagName,
        this.tagId,
        this.fileName,
        this.base64Value,
        this.uniqueFileName,
        this.extension,
        this.xbizid,
        this.xbizurl,
    });

    factory RequestPifilesuploadObj.fromJson(Map<String, dynamic> json) => RequestPifilesuploadObj(
        tagName: json["TagName"],
        tagId: json["TagId"],
        fileName: json["FileName"],
        base64Value: json["Base64Value"],
        uniqueFileName: json["UniqueFileName"],
        extension: json["Extension"],
        xbizid: json["XBIZID"],
        xbizurl: json["XBIZURL"],
    );

    Map<String, dynamic> toJson() => {
        "TagName": tagName,
        "TagId": tagId,
        "FileName": fileName,
        "Base64Value": base64Value,
        "UniqueFileName": uniqueFileName,
        "Extension": extension,
        "XBIZID": xbizid,
        "XBIZURL": xbizurl,
    };
}
