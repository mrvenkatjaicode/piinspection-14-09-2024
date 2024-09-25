// To parse this JSON data, do
//
//     final getImageResponse = getImageResponseFromJson(jsonString);

import 'dart:convert';

GetImageResponse getImageResponseFromJson(String str) =>
    GetImageResponse.fromJson(json.decode(str));

String getImageResponseToJson(GetImageResponse data) =>
    json.encode(data.toJson());

class GetImageResponse {
  MessageResult? messageResult;
  String? htmlGrid;
  List<Response>? response;

  GetImageResponse({
    this.messageResult,
    this.htmlGrid,
    this.response,
  });

  factory GetImageResponse.fromJson(Map<String, dynamic> json) =>
      GetImageResponse(
        messageResult: json["MessageResult"] == null
            ? null
            : MessageResult.fromJson(json["MessageResult"]),
        htmlGrid: json["HTML_GRID"],
        response: json["Response"] == null
            ? []
            : List<Response>.from(
                json["Response"]!.map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MessageResult": messageResult?.toJson(),
        "HTML_GRID": htmlGrid,
        "Response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
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
        errorMessage: json["ErrorMessage"] ?? "",
        result: json["Result"],
        successMessage: json["SuccessMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorMessage": errorMessage ?? "",
        "Result": result,
        "SuccessMessage": successMessage,
      };
}

class Response {
  String? abandonedreason;
  String? agencystatus;
  String? agencyHoldCount;
  String? agtCategory;
  String? appointmentinfo;
  String? approvalreason;
  String? approvalReqByRemarks;
  String? approvedby;
  String? attachmentid;
  String? auditfeedback;
  String? auditremarks;
  String? auditstatus;
  String? adjustedApprovedDate;
  String? approveddate;
  String? branchid;
  String? branchname;
  String? branchClarification;
  String? branchClarificationOthers;
  String? branchClarificationRemarks;
  String? branchHoldCount;
  String? brokenparts;
  String? chassisno;
  String? chassisnoRs;
  String? contactmobileno;
  String? contactnoPrimary;
  String? contactperson;
  String? contacttoSendlink;
  String? conveyanceamount;
  String? currentyearclm;
  String? currentyearclmremark;
  String? customerremarks;
  String? customerHoldCount;
  String? city;
  String? completeReportSubmittedeDate;
  String? currentDate;
  String? declaration;
  String? dentedparts;
  String? delayedCaseFlg;
  String? district;
  String? engincover;
  String? engineno;
  String? enginenoRs;
  String? errortype;
  String? errorToBeMarked;
  String? extensionRemarks;
  String? finalstatus;
  String? fueltype;
  String? firstName;
  String? galleryimage;
  String? gvw;
  String? gvwRs;
  String? holdtype;
  dynamic hoUserFlag;
  String? idvvehicle;
  String? importexcess;
  String? importexcessdetails;
  String? inspectionlocation;
  String? insuredname;
  String? insurednameRs;
  String? intermediariesname;
  String? intimationcreatedby;
  String? intimationcreateddate;
  String? intimationcreatorloginid;
  String? intimationpurpose;
  String? intimationremarks;
  String? isforphone;
  List<Imageresponse>? imageresponse;
  String? inspectionLocation1;
  String? inspectionLocation2;
  String? insuredPhone;
  String? isApprovalReasonEnable;
  String? landmark;
  String? lastName;
  String? make;
  String? makeRs;
  String? maxnoofHoldAgency;
  String? maxnoofHoldBranch;
  String? maxnoofHoldCustomer;
  String? model;
  String? modelRs;
  String? modeofpayment;
  String? mysgisource;
  String? middleName;
  String? ncbPer;
  String? ncbPercentage;
  String? noofphotosalert;
  String? noofphotoscaptured;
  String? noofphotosrequired;
  String? odometerreading;
  String? partyname;
  String? photoattached;
  String? pifeesamount;
  String? pifeescollected;
  dynamic pioLogBook;
  dynamic pioUserFlag;
  String? policyno;
  String? preinspectionid;
  String? previousby;
  String? previousstatus;
  String? productcode;
  String? productname;
  String? proposaltype;
  String? pendingTimeClock;
  String? pincode;
  String? policyUrl;
  String? premiaCode;
  String? productCategory;
  String? productCategoryRs;
  String? rcverified;
  String? reasoncanrejhold;
  String? referencenumber;
  String? refmobileno;
  String? regNumberFormat;
  String? remarksifcancelled;
  String? reworkdone;
  String? reworkrecommended;
  String? rootorg;
  String? remarks;
  dynamic reopenRemarks;
  String? repositoryAlert;
  String? scratchedparts;
  String? seatingcapacity;
  String? seatingcapacityRs;
  String? sgicpolicyno;
  String? status;
  String? statusname;
  String? surveydate;
  String? surveydoneby;
  String? surveydonebyInsured;
  String? surveyid;
  String? surveyorid;
  String? surveyormailid;
  String? surveyorremark;
  String? surveyortype;
  String? surveyorAgencyName;
  String? surveySubmitDate;
  dynamic specialApprovalAlert;
  String? state;
  dynamic surveyBy;
  dynamic surveyorDoneFileList;
  List<SurveyorList>? surveyorList;
  String? typeofendor;
  String? title;
  String? vehicletype;
  String? vehicleRegNo;
  String? vehicleRegNoRs;
  String? vehCategory;
  String? vehCategoryRs;
  String? vehRunningCondition;
  String? videofileurl;
  String? yearofmanuf;
  String? yearofmanufRs;
  String? claimnotapprovedfor;

  Response({
    this.abandonedreason,
    this.agencystatus,
    this.agencyHoldCount,
    this.agtCategory,
    this.appointmentinfo,
    this.approvalreason,
    this.approvalReqByRemarks,
    this.approvedby,
    this.attachmentid,
    this.auditfeedback,
    this.auditremarks,
    this.auditstatus,
    this.adjustedApprovedDate,
    this.approveddate,
    this.branchid,
    this.branchname,
    this.branchClarification,
    this.branchClarificationOthers,
    this.branchClarificationRemarks,
    this.branchHoldCount,
    this.brokenparts,
    this.chassisno,
    this.chassisnoRs,
    this.contactmobileno,
    this.contactnoPrimary,
    this.contactperson,
    this.contacttoSendlink,
    this.conveyanceamount,
    this.currentyearclm,
    this.currentyearclmremark,
    this.customerremarks,
    this.customerHoldCount,
    this.city,
    this.completeReportSubmittedeDate,
    this.currentDate,
    this.declaration,
    this.dentedparts,
    this.delayedCaseFlg,
    this.district,
    this.engincover,
    this.engineno,
    this.enginenoRs,
    this.errortype,
    this.errorToBeMarked,
    this.extensionRemarks,
    this.finalstatus,
    this.fueltype,
    this.firstName,
    this.galleryimage,
    this.gvw,
    this.gvwRs,
    this.holdtype,
    this.hoUserFlag,
    this.idvvehicle,
    this.importexcess,
    this.importexcessdetails,
    this.inspectionlocation,
    this.insuredname,
    this.insurednameRs,
    this.intermediariesname,
    this.intimationcreatedby,
    this.intimationcreateddate,
    this.intimationcreatorloginid,
    this.intimationpurpose,
    this.intimationremarks,
    this.isforphone,
    this.imageresponse,
    this.inspectionLocation1,
    this.inspectionLocation2,
    this.insuredPhone,
    this.isApprovalReasonEnable,
    this.landmark,
    this.lastName,
    this.make,
    this.makeRs,
    this.maxnoofHoldAgency,
    this.maxnoofHoldBranch,
    this.maxnoofHoldCustomer,
    this.model,
    this.modelRs,
    this.modeofpayment,
    this.mysgisource,
    this.middleName,
    this.ncbPer,
    this.ncbPercentage,
    this.noofphotosalert,
    this.noofphotoscaptured,
    this.noofphotosrequired,
    this.odometerreading,
    this.partyname,
    this.photoattached,
    this.pifeesamount,
    this.pifeescollected,
    this.pioLogBook,
    this.pioUserFlag,
    this.policyno,
    this.preinspectionid,
    this.previousby,
    this.previousstatus,
    this.productcode,
    this.productname,
    this.proposaltype,
    this.pendingTimeClock,
    this.pincode,
    this.policyUrl,
    this.premiaCode,
    this.productCategory,
    this.productCategoryRs,
    this.rcverified,
    this.reasoncanrejhold,
    this.referencenumber,
    this.refmobileno,
    this.regNumberFormat,
    this.remarksifcancelled,
    this.reworkdone,
    this.reworkrecommended,
    this.rootorg,
    this.remarks,
    this.reopenRemarks,
    this.repositoryAlert,
    this.scratchedparts,
    this.seatingcapacity,
    this.seatingcapacityRs,
    this.sgicpolicyno,
    this.status,
    this.statusname,
    this.surveydate,
    this.surveydoneby,
    this.surveydonebyInsured,
    this.surveyid,
    this.surveyorid,
    this.surveyormailid,
    this.surveyorremark,
    this.surveyortype,
    this.surveyorAgencyName,
    this.surveySubmitDate,
    this.specialApprovalAlert,
    this.state,
    this.surveyBy,
    this.surveyorDoneFileList,
    this.surveyorList,
    this.typeofendor,
    this.title,
    this.vehicletype,
    this.vehicleRegNo,
    this.vehicleRegNoRs,
    this.vehCategory,
    this.vehCategoryRs,
    this.vehRunningCondition,
    this.videofileurl,
    this.yearofmanuf,
    this.yearofmanufRs,
    this.claimnotapprovedfor,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        abandonedreason: json["ABANDONEDREASON"],
        agencystatus: json["AGENCYSTATUS"],
        agencyHoldCount: json["AGENCY_HOLD_COUNT"],
        agtCategory: json["AGT_CATEGORY"],
        appointmentinfo: json["APPOINTMENTINFO"],
        approvalreason: json["APPROVALREASON"],
        approvalReqByRemarks: json["APPROVAL_REQ_BY_REMARKS"],
        approvedby: json["APPROVEDBY"],
        attachmentid: json["ATTACHMENTID"],
        auditfeedback: json["AUDITFEEDBACK"],
        auditremarks: json["AUDITREMARKS"],
        auditstatus: json["AUDITSTATUS"],
        adjustedApprovedDate: json["AdjustedApprovedDate"],
        approveddate: json["Approveddate"],
        branchid: json["BRANCHID"],
        branchname: json["BRANCHNAME"],
        branchClarification: json["BRANCH_CLARIFICATION"],
        branchClarificationOthers: json["BRANCH_CLARIFICATION_OTHERS"],
        branchClarificationRemarks: json["BRANCH_CLARIFICATION_REMARKS"],
        branchHoldCount: json["BRANCH_HOLD_COUNT"],
        brokenparts: json["BROKENPARTS"],
        chassisno: json["CHASSISNO"],
        chassisnoRs: json["CHASSISNO_RS"],
        contactmobileno: json["CONTACTMOBILENO"],
        contactnoPrimary: json["CONTACTNO_PRIMARY"],
        contactperson: json["CONTACTPERSON"],
        contacttoSendlink: json["CONTACTTO_SENDLINK"],
        conveyanceamount: json["CONVEYANCEAMOUNT"],
        currentyearclm: json["CURRENTYEARCLM"],
        currentyearclmremark: json["CURRENTYEARCLMREMARK"],
        customerremarks: json["CUSTOMERREMARKS"],
        customerHoldCount: json["CUSTOMER_HOLD_COUNT"],
        city: json["City"],
        completeReportSubmittedeDate: json["CompleteReportSubmittedeDate"],
        currentDate: json["CurrentDate"],
        declaration: json["DECLARATION"],
        dentedparts: json["DENTEDPARTS"],
        delayedCaseFlg: json["DelayedCaseFlg"],
        district: json["District"],
        engincover: json["ENGINCOVER"],
        engineno: json["ENGINENO"],
        enginenoRs: json["ENGINENO_RS"],
        errortype: json["ERRORTYPE"],
        errorToBeMarked: json["ERROR_TO_BE_MARKED"],
        extensionRemarks: json["ExtensionRemarks"],
        finalstatus: json["FINALSTATUS"],
        fueltype: json["FUELTYPE"],
        firstName: json["First_Name"],
        galleryimage: json["GALLERYIMAGE"],
        gvw: json["GVW"],
        gvwRs: json["GVW_RS"],
        holdtype: json["HOLDTYPE"],
        hoUserFlag: json["HO_USER_FLAG"] ?? "",
        idvvehicle: json["IDVVEHICLE"],
        importexcess: json["IMPORTEXCESS"],
        importexcessdetails: json["IMPORTEXCESSDETAILS"],
        inspectionlocation: json["INSPECTIONLOCATION"],
        insuredname: json["INSUREDNAME"],
        insurednameRs: json["INSUREDNAME_RS"],
        intermediariesname: json["INTERMEDIARIESNAME"],
        intimationcreatedby: json["INTIMATIONCREATEDBY"],
        intimationcreateddate: json["INTIMATIONCREATEDDATE"],
        intimationcreatorloginid: json["INTIMATIONCREATORLOGINID"],
        intimationpurpose: json["INTIMATIONPURPOSE"],
        intimationremarks: json["INTIMATIONREMARKS"],
        isforphone: json["ISFORPHONE"],
        imageresponse: json["Imageresponse"] == null
            ? []
            : List<Imageresponse>.from(
                json["Imageresponse"]!.map((x) => Imageresponse.fromJson(x))),
        inspectionLocation1: json["Inspection_Location1"],
        inspectionLocation2: json["Inspection_Location2"],
        insuredPhone: json["Insured_Phone"],
        isApprovalReasonEnable: json["IsApprovalReasonEnable"],
        landmark: json["Landmark"],
        lastName: json["Last_Name"],
        make: json["MAKE"],
        makeRs: json["MAKE_RS"],
        maxnoofHoldAgency: json["MAXNOOF_HOLD_AGENCY"],
        maxnoofHoldBranch: json["MAXNOOF_HOLD_BRANCH"],
        maxnoofHoldCustomer: json["MAXNOOF_HOLD_CUSTOMER"],
        model: json["MODEL"],
        modelRs: json["MODEL_RS"],
        modeofpayment: json["MODEOFPAYMENT"],
        mysgisource: json["MYSGISOURCE"],
        middleName: json["Middle_Name"],
        ncbPer: json["NCBPer"],
        ncbPercentage: json["NCB_PERCENTAGE"],
        noofphotosalert: json["NOOFPHOTOSALERT"],
        noofphotoscaptured: json["NOOFPHOTOSCAPTURED"],
        noofphotosrequired: json["NOOFPHOTOSREQUIRED"],
        odometerreading: json["ODOMETERREADING"],
        partyname: json["PARTYNAME"],
        photoattached: json["PHOTOATTACHED"],
        pifeesamount: json["PIFEESAMOUNT"],
        pifeescollected: json["PIFEESCOLLECTED"],
        pioLogBook: json["PIOLogBook"] ?? "",
        pioUserFlag: json["PIO_USER_FLAG"] ?? "",
        policyno: json["POLICYNO"],
        preinspectionid: json["PREINSPECTIONID"],
        previousby: json["PREVIOUSBY"],
        previousstatus: json["PREVIOUSSTATUS"],
        productcode: json["PRODUCTCODE"],
        productname: json["PRODUCTNAME"],
        proposaltype: json["PROPOSALTYPE"],
        pendingTimeClock: json["PendingTimeClock"],
        pincode: json["Pincode"],
        policyUrl: json["PolicyURL"],
        premiaCode: json["Premia_Code"],
        productCategory: json["ProductCategory"],
        productCategoryRs: json["ProductCategory_RS"],
        rcverified: json["RCVERIFIED"],
        reasoncanrejhold: json["REASONCANREJHOLD"],
        referencenumber: json["REFERENCENUMBER"],
        refmobileno: json["REFMOBILENO"],
        regNumberFormat: json["REG_NUMBER_FORMAT"],
        remarksifcancelled: json["REMARKSIFCANCELLED"],
        reworkdone: json["REWORKDONE"],
        reworkrecommended: json["REWORKRECOMMENDED"],
        rootorg: json["ROOTORG"],
        remarks: json["Remarks"],
        reopenRemarks: json["ReopenRemarks"] ?? "",
        repositoryAlert: json["RepositoryAlert"],
        scratchedparts: json["SCRATCHEDPARTS"],
        seatingcapacity: json["SEATINGCAPACITY"],
        seatingcapacityRs: json["SEATINGCAPACITY_RS"],
        sgicpolicyno: json["SGICPOLICYNO"],
        status: json["STATUS"],
        statusname: json["STATUSNAME"],
        surveydate: json["SURVEYDATE"],
        surveydoneby: json["SURVEYDONEBY"],
        surveydonebyInsured: json["SURVEYDONEBY_INSURED"],
        surveyid: json["SURVEYID"],
        surveyorid: json["SURVEYORID"],
        surveyormailid: json["SURVEYORMAILID"],
        surveyorremark: json["SURVEYORREMARK"],
        surveyortype: json["SURVEYORTYPE"],
        surveyorAgencyName: json["SURVEYOR_AGENCY_NAME"],
        surveySubmitDate: json["SURVEY_SUBMIT_DATE"],
        specialApprovalAlert: json["SpecialApprovalAlert"] ?? "",
        state: json["State"],
        surveyBy: json["SurveyBy"] ?? "",
        surveyorDoneFileList: json["SurveyorDoneFileList"] ?? [],
        surveyorList: json["SurveyorList"] == null
            ? []
            : List<SurveyorList>.from(
                json["SurveyorList"]!.map((x) => SurveyorList.fromJson(x))),
        typeofendor: json["TYPEOFENDOR"],
        title: json["Title"],
        vehicletype: json["VEHICLETYPE"],
        vehicleRegNo: json["VEHICLE_REG_NO"],
        vehicleRegNoRs: json["VEHICLE_REG_NO_RS"],
        vehCategory: json["VEH_CATEGORY"],
        vehCategoryRs: json["VEH_CATEGORY_RS"],
        vehRunningCondition: json["VEH_RUNNING_CONDITION"],
        videofileurl: json["VIDEOFILEURL"],
        yearofmanuf: json["YEAROFMANUF"],
        yearofmanufRs: json["YEAROFMANUF_RS"],
        claimnotapprovedfor: json["claimnotapprovedfor"],
      );

  Map<String, dynamic> toJson() => {
        "ABANDONEDREASON": abandonedreason,
        "AGENCYSTATUS": agencystatus,
        "AGENCY_HOLD_COUNT": agencyHoldCount,
        "AGT_CATEGORY": agtCategory,
        "APPOINTMENTINFO": appointmentinfo,
        "APPROVALREASON": approvalreason,
        "APPROVAL_REQ_BY_REMARKS": approvalReqByRemarks,
        "APPROVEDBY": approvedby,
        "ATTACHMENTID": attachmentid,
        "AUDITFEEDBACK": auditfeedback,
        "AUDITREMARKS": auditremarks,
        "AUDITSTATUS": auditstatus,
        "AdjustedApprovedDate": adjustedApprovedDate,
        "Approveddate": approveddate,
        "BRANCHID": branchid,
        "BRANCHNAME": branchname,
        "BRANCH_CLARIFICATION": branchClarification,
        "BRANCH_CLARIFICATION_OTHERS": branchClarificationOthers,
        "BRANCH_CLARIFICATION_REMARKS": branchClarificationRemarks,
        "BRANCH_HOLD_COUNT": branchHoldCount,
        "BROKENPARTS": brokenparts,
        "CHASSISNO": chassisno,
        "CHASSISNO_RS": chassisnoRs,
        "CONTACTMOBILENO": contactmobileno,
        "CONTACTNO_PRIMARY": contactnoPrimary,
        "CONTACTPERSON": contactperson,
        "CONTACTTO_SENDLINK": contacttoSendlink,
        "CONVEYANCEAMOUNT": conveyanceamount,
        "CURRENTYEARCLM": currentyearclm,
        "CURRENTYEARCLMREMARK": currentyearclmremark,
        "CUSTOMERREMARKS": customerremarks,
        "CUSTOMER_HOLD_COUNT": customerHoldCount,
        "City": city,
        "CompleteReportSubmittedeDate": completeReportSubmittedeDate,
        "CurrentDate": currentDate,
        "DECLARATION": declaration,
        "DENTEDPARTS": dentedparts,
        "DelayedCaseFlg": delayedCaseFlg,
        "District": district,
        "ENGINCOVER": engincover,
        "ENGINENO": engineno,
        "ENGINENO_RS": enginenoRs,
        "ERRORTYPE": errortype,
        "ERROR_TO_BE_MARKED": errorToBeMarked,
        "ExtensionRemarks": extensionRemarks,
        "FINALSTATUS": finalstatus,
        "FUELTYPE": fueltype,
        "First_Name": firstName,
        "GALLERYIMAGE": galleryimage,
        "GVW": gvw,
        "GVW_RS": gvwRs,
        "HOLDTYPE": holdtype,
        "HO_USER_FLAG": hoUserFlag ?? "",
        "IDVVEHICLE": idvvehicle,
        "IMPORTEXCESS": importexcess,
        "IMPORTEXCESSDETAILS": importexcessdetails,
        "INSPECTIONLOCATION": inspectionlocation,
        "INSUREDNAME": insuredname,
        "INSUREDNAME_RS": insurednameRs,
        "INTERMEDIARIESNAME": intermediariesname,
        "INTIMATIONCREATEDBY": intimationcreatedby,
        "INTIMATIONCREATEDDATE": intimationcreateddate,
        "INTIMATIONCREATORLOGINID": intimationcreatorloginid,
        "INTIMATIONPURPOSE": intimationpurpose,
        "INTIMATIONREMARKS": intimationremarks,
        "ISFORPHONE": isforphone,
        "Imageresponse": imageresponse == null
            ? []
            : List<dynamic>.from(imageresponse!.map((x) => x.toJson())),
        "Inspection_Location1": inspectionLocation1,
        "Inspection_Location2": inspectionLocation2,
        "Insured_Phone": insuredPhone,
        "IsApprovalReasonEnable": isApprovalReasonEnable,
        "Landmark": landmark,
        "Last_Name": lastName,
        "MAKE": make,
        "MAKE_RS": makeRs,
        "MAXNOOF_HOLD_AGENCY": maxnoofHoldAgency,
        "MAXNOOF_HOLD_BRANCH": maxnoofHoldBranch,
        "MAXNOOF_HOLD_CUSTOMER": maxnoofHoldCustomer,
        "MODEL": model,
        "MODEL_RS": modelRs,
        "MODEOFPAYMENT": modeofpayment,
        "MYSGISOURCE": mysgisource,
        "Middle_Name": middleName,
        "NCBPer": ncbPer,
        "NCB_PERCENTAGE": ncbPercentage,
        "NOOFPHOTOSALERT": noofphotosalert,
        "NOOFPHOTOSCAPTURED": noofphotoscaptured,
        "NOOFPHOTOSREQUIRED": noofphotosrequired,
        "ODOMETERREADING": odometerreading,
        "PARTYNAME": partyname,
        "PHOTOATTACHED": photoattached,
        "PIFEESAMOUNT": pifeesamount,
        "PIFEESCOLLECTED": pifeescollected,
        "PIOLogBook": pioLogBook ?? "",
        "PIO_USER_FLAG": pioUserFlag ?? "",
        "POLICYNO": policyno,
        "PREINSPECTIONID": preinspectionid,
        "PREVIOUSBY": previousby,
        "PREVIOUSSTATUS": previousstatus,
        "PRODUCTCODE": productcode,
        "PRODUCTNAME": productname,
        "PROPOSALTYPE": proposaltype,
        "PendingTimeClock": pendingTimeClock,
        "Pincode": pincode,
        "PolicyURL": policyUrl,
        "Premia_Code": premiaCode,
        "ProductCategory": productCategory,
        "ProductCategory_RS": productCategoryRs,
        "RCVERIFIED": rcverified,
        "REASONCANREJHOLD": reasoncanrejhold,
        "REFERENCENUMBER": referencenumber,
        "REFMOBILENO": refmobileno,
        "REG_NUMBER_FORMAT": regNumberFormat,
        "REMARKSIFCANCELLED": remarksifcancelled,
        "REWORKDONE": reworkdone,
        "REWORKRECOMMENDED": reworkrecommended,
        "ROOTORG": rootorg,
        "Remarks": remarks,
        "ReopenRemarks": reopenRemarks ?? "",
        "RepositoryAlert": repositoryAlert,
        "SCRATCHEDPARTS": scratchedparts,
        "SEATINGCAPACITY": seatingcapacity,
        "SEATINGCAPACITY_RS": seatingcapacityRs,
        "SGICPOLICYNO": sgicpolicyno,
        "STATUS": status,
        "STATUSNAME": statusname,
        "SURVEYDATE": surveydate,
        "SURVEYDONEBY": surveydoneby,
        "SURVEYDONEBY_INSURED": surveydonebyInsured,
        "SURVEYID": surveyid,
        "SURVEYORID": surveyorid,
        "SURVEYORMAILID": surveyormailid,
        "SURVEYORREMARK": surveyorremark,
        "SURVEYORTYPE": surveyortype,
        "SURVEYOR_AGENCY_NAME": surveyorAgencyName,
        "SURVEY_SUBMIT_DATE": surveySubmitDate,
        "SpecialApprovalAlert": specialApprovalAlert,
        "State": state,
        "SurveyBy": surveyBy ?? "",
        "SurveyorDoneFileList": surveyorDoneFileList ?? [],
        "SurveyorList": surveyorList == null
            ? []
            : List<dynamic>.from(surveyorList!.map((x) => x.toJson())),
        "TYPEOFENDOR": typeofendor,
        "Title": title,
        "VEHICLETYPE": vehicletype,
        "VEHICLE_REG_NO": vehicleRegNo,
        "VEHICLE_REG_NO_RS": vehicleRegNoRs,
        "VEH_CATEGORY": vehCategory,
        "VEH_CATEGORY_RS": vehCategoryRs,
        "VEH_RUNNING_CONDITION": vehRunningCondition,
        "VIDEOFILEURL": videofileurl,
        "YEAROFMANUF": yearofmanuf,
        "YEAROFMANUF_RS": yearofmanufRs,
        "claimnotapprovedfor": claimnotapprovedfor,
      };
}

class Imageresponse {
  String? active;
  String? applicationNo;
  String? deletedby;
  String? deleteddate;
  String? extension;
  String? fileName;
  String? fileUniqueName;
  String? tagId;
  String? tagName;
  String? uploadedby;
  String? uploadeddate;
  String? uploadfilemasterid;
  Uploadfrom? uploadfrom;
  String? xbizid;
  String? xbizurl;

  Imageresponse({
    this.active,
    this.applicationNo,
    this.deletedby,
    this.deleteddate,
    this.extension,
    this.fileName,
    this.fileUniqueName,
    this.tagId,
    this.tagName,
    this.uploadedby,
    this.uploadeddate,
    this.uploadfilemasterid,
    this.uploadfrom,
    this.xbizid,
    this.xbizurl,
  });

  factory Imageresponse.fromJson(Map<String, dynamic> json) => Imageresponse(
        active: json["ACTIVE"],
        applicationNo: json["ApplicationNo"],
        deletedby: json["DELETEDBY"],
        deleteddate: json["DELETEDDATE"],
        extension: json["Extension"],
        fileName: json["FileName"],
        fileUniqueName: json["FileUniqueName"],
        tagId: json["TagId"],
        tagName: json["TagName"],
        uploadedby: json["UPLOADEDBY"],
        uploadeddate: json["UPLOADEDDATE"],
        uploadfilemasterid: json["UPLOADFILEMASTERID"],
        uploadfrom: uploadfromValues.map[json["UPLOADFROM"]]!,
        xbizid: json["XBIZID"],
        xbizurl: json["XBIZURL"],
      );

  Map<String, dynamic> toJson() => {
        "ACTIVE": active,
        "ApplicationNo": applicationNo,
        "DELETEDBY": deletedby,
        "DELETEDDATE": deleteddate,
        "Extension": extension,
        "FileName": fileName,
        "FileUniqueName": fileUniqueName,
        "TagId": tagId,
        "TagName": tagName,
        "UPLOADEDBY": uploadedby,
        "UPLOADEDDATE": uploadeddate,
        "UPLOADFILEMASTERID": uploadfilemasterid,
        "UPLOADFROM": uploadfromValues.reverse[uploadfrom],
        "XBIZID": xbizid,
        "XBIZURL": xbizurl,
      };
}

enum Extension { JPG, MP4, PNG }

final extensionValues = EnumValues(
    {".jpg": Extension.JPG, ".mp4": Extension.MP4, ".png": Extension.PNG});

enum Uploadfrom { PI }

final uploadfromValues = EnumValues({"PI": Uploadfrom.PI});

class SurveyorList {
  String? surveyorDoneBy;
  int? surveyorId;
  String? surveyorName;
  String? surveyorPartyId;
  String? surveyorType;

  SurveyorList({
    this.surveyorDoneBy,
    this.surveyorId,
    this.surveyorName,
    this.surveyorPartyId,
    this.surveyorType,
  });

  factory SurveyorList.fromJson(Map<String, dynamic> json) => SurveyorList(
        surveyorDoneBy: json["SurveyorDoneBy"],
        surveyorId: json["SurveyorId"],
        surveyorName: json["SurveyorName"],
        surveyorPartyId: json["SurveyorPartyId"],
        surveyorType: json["SurveyorType"],
      );

  Map<String, dynamic> toJson() => {
        "SurveyorDoneBy": surveyorDoneBy,
        "SurveyorId": surveyorId,
        "SurveyorName": surveyorName,
        "SurveyorPartyId": surveyorPartyId,
        "SurveyorType": surveyorType,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
