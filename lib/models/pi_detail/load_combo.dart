// To parse this JSON data, do
//
//     final getLoadComboResponse = getLoadComboResponseFromJson(jsonString);

import 'dart:convert';

GetLoadComboResponse getLoadComboResponseFromJson(String str) => GetLoadComboResponse.fromJson(json.decode(str));

String getLoadComboResponseToJson(GetLoadComboResponse data) => json.encode(data.toJson());

class GetLoadComboResponse {
    MessageResult? messageResult;
    String? serverDate;
    List<MAgencystatusObj>? mAgencystatusObj;
    List<MBharatR1Obj>? mBharatR1Obj;
    List<MEndorsementTypertnObj>? mEndorsementTypertnObj;
    List<MFuelTypeResObj>? mFuelTypeResObj;
    List<MPreinspectionStatusResObj>? mPreinspectionStatusResObj;
    List<MProductDetailsResObj>? mProductDetailsResObj;
    List<MRtoStateCodeResObj>? mRtoStateCodeResObj;
    List<MTagNameRtnObj>? mTagNameRtnObj;
    List<MUserActivityHoRtnObj>? mUserActivityHoRtnObj;

    GetLoadComboResponse({
        this.messageResult,
        this.serverDate,
        this.mAgencystatusObj,
        this.mBharatR1Obj,
        this.mEndorsementTypertnObj,
        this.mFuelTypeResObj,
        this.mPreinspectionStatusResObj,
        this.mProductDetailsResObj,
        this.mRtoStateCodeResObj,
        this.mTagNameRtnObj,
        this.mUserActivityHoRtnObj,
    });

    factory GetLoadComboResponse.fromJson(Map<String, dynamic> json) => GetLoadComboResponse(
        messageResult: json["MessageResult"] == null ? null : MessageResult.fromJson(json["MessageResult"]),
        serverDate: json["ServerDate"],
        mAgencystatusObj: json["mAgencystatusObj"] == null ? [] : List<MAgencystatusObj>.from(json["mAgencystatusObj"]!.map((x) => MAgencystatusObj.fromJson(x))),
        mBharatR1Obj: json["mBharatR1Obj"] == null ? [] : List<MBharatR1Obj>.from(json["mBharatR1Obj"]!.map((x) => MBharatR1Obj.fromJson(x))),
        mEndorsementTypertnObj: json["mEndorsementTypertnObj"] == null ? [] : List<MEndorsementTypertnObj>.from(json["mEndorsementTypertnObj"]!.map((x) => MEndorsementTypertnObj.fromJson(x))),
        mFuelTypeResObj: json["mFuelTypeResObj"] == null ? [] : List<MFuelTypeResObj>.from(json["mFuelTypeResObj"]!.map((x) => MFuelTypeResObj.fromJson(x))),
        mPreinspectionStatusResObj: json["mPreinspectionStatusResObj"] == null ? [] : List<MPreinspectionStatusResObj>.from(json["mPreinspectionStatusResObj"]!.map((x) => MPreinspectionStatusResObj.fromJson(x))),
        mProductDetailsResObj: json["mProductDetailsResObj"] == null ? [] : List<MProductDetailsResObj>.from(json["mProductDetailsResObj"]!.map((x) => MProductDetailsResObj.fromJson(x))),
        mRtoStateCodeResObj: json["mRtoStateCodeResObj"] == null ? [] : List<MRtoStateCodeResObj>.from(json["mRtoStateCodeResObj"]!.map((x) => MRtoStateCodeResObj.fromJson(x))),
        mTagNameRtnObj: json["mTagNameRtnObj"] == null ? [] : List<MTagNameRtnObj>.from(json["mTagNameRtnObj"]!.map((x) => MTagNameRtnObj.fromJson(x))),
        mUserActivityHoRtnObj: json["mUserActivityHORtnObj"] == null ? [] : List<MUserActivityHoRtnObj>.from(json["mUserActivityHORtnObj"]!.map((x) => MUserActivityHoRtnObj.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "ServerDate": serverDate,
        "mAgencystatusObj": mAgencystatusObj == null ? [] : List<dynamic>.from(mAgencystatusObj!.map((x) => x.toJson())),
        "mBharatR1Obj": mBharatR1Obj == null ? [] : List<dynamic>.from(mBharatR1Obj!.map((x) => x.toJson())),
        "mEndorsementTypertnObj": mEndorsementTypertnObj == null ? [] : List<dynamic>.from(mEndorsementTypertnObj!.map((x) => x.toJson())),
        "mFuelTypeResObj": mFuelTypeResObj == null ? [] : List<dynamic>.from(mFuelTypeResObj!.map((x) => x.toJson())),
        "mPreinspectionStatusResObj": mPreinspectionStatusResObj == null ? [] : List<dynamic>.from(mPreinspectionStatusResObj!.map((x) => x.toJson())),
        "mProductDetailsResObj": mProductDetailsResObj == null ? [] : List<dynamic>.from(mProductDetailsResObj!.map((x) => x.toJson())),
        "mRtoStateCodeResObj": mRtoStateCodeResObj == null ? [] : List<dynamic>.from(mRtoStateCodeResObj!.map((x) => x.toJson())),
        "mTagNameRtnObj": mTagNameRtnObj == null ? [] : List<dynamic>.from(mTagNameRtnObj!.map((x) => x.toJson())),
        "mUserActivityHORtnObj": mUserActivityHoRtnObj == null ? [] : List<dynamic>.from(mUserActivityHoRtnObj!.map((x) => x.toJson())),
    };
}

class MAgencystatusObj {
    String? agencyStatus;

    MAgencystatusObj({
        this.agencyStatus,
    });

    factory MAgencystatusObj.fromJson(Map<String, dynamic> json) => MAgencystatusObj(
        agencyStatus: json["AgencyStatus"],
    );

    Map<String, dynamic> toJson() => {
        "AgencyStatus": agencyStatus,
    };
}

class MBharatR1Obj {
    String? bharatR1;

    MBharatR1Obj({
        this.bharatR1,
    });

    factory MBharatR1Obj.fromJson(Map<String, dynamic> json) => MBharatR1Obj(
        bharatR1: json["BharatR1"],
    );

    Map<String, dynamic> toJson() => {
        "BharatR1": bharatR1,
    };
}

class MEndorsementTypertnObj {
    String? display;
    String? endorsementCombo;

    MEndorsementTypertnObj({
        this.display,
        this.endorsementCombo,
    });

    factory MEndorsementTypertnObj.fromJson(Map<String, dynamic> json) => MEndorsementTypertnObj(
        display: json["Display"],
        endorsementCombo: json["EndorsementCombo"],
    );

    Map<String, dynamic> toJson() => {
        "Display": display,
        "EndorsementCombo": endorsementCombo,
    };
}

class MFuelTypeResObj {
    String? fuelType;

    MFuelTypeResObj({
        this.fuelType,
    });

    factory MFuelTypeResObj.fromJson(Map<String, dynamic> json) => MFuelTypeResObj(
        fuelType: json["FuelType"],
    );

    Map<String, dynamic> toJson() => {
        "FuelType": fuelType,
    };
}

class MPreinspectionStatusResObj {
    String? statusid;
    String? statusname;

    MPreinspectionStatusResObj({
        this.statusid,
        this.statusname,
    });

    factory MPreinspectionStatusResObj.fromJson(Map<String, dynamic> json) => MPreinspectionStatusResObj(
        statusid: json["statusid"],
        statusname: json["statusname"],
    );

    Map<String, dynamic> toJson() => {
        "statusid": statusid,
        "statusname": statusname,
    };
}

class MProductDetailsResObj {
    String? subCategoryflag;
    String? premiaProductCode;
    String? productcode;
    String? productid;
    String? productname;

    MProductDetailsResObj({
        this.subCategoryflag,
        this.premiaProductCode,
        this.productcode,
        this.productid,
        this.productname,
    });

    factory MProductDetailsResObj.fromJson(Map<String, dynamic> json) => MProductDetailsResObj(
        subCategoryflag: json["SubCategoryflag"],
        premiaProductCode: json["premia_product_code"],
        productcode: json["productcode"],
        productid: json["productid"],
        productname: json["productname"],
    );

    Map<String, dynamic> toJson() => {
        "SubCategoryflag": subCategoryflag,
        "premia_product_code": premiaProductCode,
        "productcode": productcode,
        "productid": productid,
        "productname": productname,
    };
}

class MRtoStateCodeResObj {
    String? stateCode;
    String? stateId;
    String? stateName;

    MRtoStateCodeResObj({
        this.stateCode,
        this.stateId,
        this.stateName,
    });

    factory MRtoStateCodeResObj.fromJson(Map<String, dynamic> json) => MRtoStateCodeResObj(
        stateCode: json["StateCode"],
        stateId: json["stateID"],
        stateName: json["stateName"],
    );

    Map<String, dynamic> toJson() => {
        "StateCode": stateCode,
        "stateID": stateId,
        "stateName": stateName,
    };
}

class MTagNameRtnObj {
    String? fileuploadtagid;
    String? fileuploadtagname;

    MTagNameRtnObj({
        this.fileuploadtagid,
        this.fileuploadtagname,
    });

    factory MTagNameRtnObj.fromJson(Map<String, dynamic> json) => MTagNameRtnObj(
        fileuploadtagid: json["FILEUPLOADTAGID"],
        fileuploadtagname: json["FILEUPLOADTAGNAME"],
    );

    Map<String, dynamic> toJson() => {
        "FILEUPLOADTAGID": fileuploadtagid,
        "FILEUPLOADTAGNAME": fileuploadtagname,
    };
}

class MUserActivityHoRtnObj {
    String? partyid;
    String? username;

    MUserActivityHoRtnObj({
        this.partyid,
        this.username,
    });

    factory MUserActivityHoRtnObj.fromJson(Map<String, dynamic> json) => MUserActivityHoRtnObj(
        partyid: json["PARTYID"],
        username: json["USERNAME"],
    );

    Map<String, dynamic> toJson() => {
        "PARTYID": partyid,
        "USERNAME": username,
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
