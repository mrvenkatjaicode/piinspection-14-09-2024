import 'dart:convert';

// BRANCH NAME STARTS

PiBranchListResponse pibranchlistResponseFromJson(String str) =>
    PiBranchListResponse.fromJson(json.decode(str));

String pibranchlistResponseToJson(PiBranchListResponse data) =>
    json.encode(data.toJson());

class PiBranchListResponse {
  PiBranchListResponse({
    required this.messageResult,
    required this.response,
  });

  MessageResult messageResult;
  List<BranchListResponse> response;

  factory PiBranchListResponse.fromJson(Map<String, dynamic> json) =>
      PiBranchListResponse(
        messageResult: MessageResult.fromJson(json["MessageResult"]),
        response: json["Response"] != null
            ? List<BranchListResponse>.from(
                json["Response"].map((x) => BranchListResponse.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "MessageResult": messageResult.toJson(),
        "Response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class BranchListResponse {
  BranchListResponse({
    required this.action,
    required this.citymastername,
    required this.countryname,
    required this.partyid,
    required this.partyname,
    required this.partytype,
    required this.statename,
  });

  String action;
  String citymastername;
  String countryname;
  String partyid;
  String partyname;
  String partytype;
  String statename;

  factory BranchListResponse.fromJson(Map<String, dynamic> json) =>
      BranchListResponse(
        action: json["Action"],
        citymastername: json["CITYMASTERNAME"],
        countryname: json["COUNTRYNAME"],
        partyid: json["PARTYID"],
        partyname: json["PARTYNAME"],
        partytype: json["PARTYTYPE"],
        statename: json["STATENAME"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "CITYMASTERNAME": citymastername,
        "COUNTRYNAME": countryname,
        "PARTYID": partyid,
        "PARTYNAME": partyname,
        "PARTYTYPE": partytype,
        "STATENAME": statename,
      };
}

class MessageResult {
  MessageResult({
    this.errorMessage,
    required this.result,
    required this.successMessage,
  });

  dynamic errorMessage;
  String result;
  String successMessage;

  factory MessageResult.fromJson(Map<String, dynamic> json) => MessageResult(
        errorMessage: json["ErrorMessage"] ?? "",
        result: json["Result"] ?? "",
        successMessage: json["SuccessMessage"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ErrorMessage": errorMessage,
        "Result": result,
        "SuccessMessage": successMessage,
      };
}

// BRANCH NAME ENDS