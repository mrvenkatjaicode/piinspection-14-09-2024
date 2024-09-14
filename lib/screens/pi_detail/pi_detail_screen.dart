import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mnovapi/utils/widgets/drop_down_pi_widget.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:intl/intl.dart';

import 'dart:ui' as ui;

import '../../bloc/pi_detail/pi_detail_bloc.dart';
import '../../bloc/pi_detail/pi_detail_event.dart';
import '../../bloc/pi_detail/pi_detail_state.dart';
import '../../utils/constant.dart';
import '../../utils/widgets/custom_bottom_clipper.dart';
import '../../utils/widgets/text_field_pi_widget.dart';

class PIDetailScreen extends StatefulWidget {
  final String preinsid;
  final bool hitapiflow;
  final bool iseditable;
  final bool otherflow;
  final bool ownflow;
  final Position? position;
  final Placemark? place;

  const PIDetailScreen({
    super.key,
    required this.preinsid,
    required this.hitapiflow,
    required this.iseditable,
    required this.otherflow,
    required this.ownflow,
    this.position,
    this.place,
  });
  @override
  State<PIDetailScreen> createState() => _PIDetailScreenState();
}

class _PIDetailScreenState extends State<PIDetailScreen> {
  final TextEditingController branchnametextcontoller = TextEditingController();
  final TextEditingController surveyornametextcontoller =
      TextEditingController();
  final TextEditingController producttextcontoller = TextEditingController();
  final TextEditingController vehiclecategorytextcontoller =
      TextEditingController();
  final TextEditingController seatingCapcitytextcontoller =
      TextEditingController();
  final TextEditingController gvwtextcontoller = TextEditingController();
  final TextEditingController pipurposetextcontoller = TextEditingController();

  final TextEditingController endoresementtypetextcontoller =
      TextEditingController();
  final TextEditingController epcrtextcontoller = TextEditingController();
  final TextEditingController policynumbertextcontoller =
      TextEditingController();
  final TextEditingController maketextcontoller = TextEditingController();
  final TextEditingController modeltextcontoller = TextEditingController();
  final TextEditingController fueltypetextcontoller = TextEditingController();
  final TextEditingController rtocodetextcontoller = TextEditingController();
  final TextEditingController rtonametextcontoller = TextEditingController();
  final TextEditingController registrationnumberformattextcontoller =
      TextEditingController(text: "New Format");

  final TextEditingController r1textcontoller = TextEditingController();
  final TextEditingController r2textcontoller = TextEditingController();
  final TextEditingController r3textcontoller = TextEditingController();
  final TextEditingController r4textcontoller = TextEditingController();

  final TextEditingController yearofmanuftextcontoller =
      TextEditingController();
  final TextEditingController enginenumbertextcontoller =
      TextEditingController();
  final TextEditingController chassisnumbertextcontoller =
      TextEditingController();
  final TextEditingController idvtextcontoller = TextEditingController();
  final TextEditingController prefixtextcontoller = TextEditingController();
  final TextEditingController insurednametextcontoller =
      TextEditingController();
  final TextEditingController inspectionlocationtextcontoller =
      TextEditingController();
  final TextEditingController proposaltypetextcontoller =
      TextEditingController();
  final TextEditingController sgicpolicynumbertextcontoller =
      TextEditingController();
  final TextEditingController odometertextcontoller = TextEditingController();
  final TextEditingController preinspectionstatustextcontoller =
      TextEditingController();
  final TextEditingController ncbtextcontoller = TextEditingController();
  final TextEditingController dentedpartstextcontoller =
      TextEditingController();
  final TextEditingController scratchedpartstextcontoller =
      TextEditingController();
  final TextEditingController brokenpartstextcontoller =
      TextEditingController();
  final TextEditingController modeofpaymenttextcontoller =
      TextEditingController();
  final TextEditingController intimationstatustextcontoller =
      TextEditingController();
  final TextEditingController contactpersontextcontoller =
      TextEditingController();
  final TextEditingController surveyorremarkstextcontoller =
      TextEditingController();
  final TextEditingController currentstatustextcontoller =
      TextEditingController();
  final TextEditingController arhtextcontoller = TextEditingController();
  final TextEditingController detailremarkstextcontoller =
      TextEditingController();
  final TextEditingController contactmobienumbertextcontoller =
      TextEditingController();
  final TextEditingController pifeecollectedtextcontoller =
      TextEditingController(text: "No");
  final TextEditingController pifeeamounttextcontoller =
      TextEditingController();
  final TextEditingController conveyanceamounttextcontoller =
      TextEditingController();
  final TextEditingController contactnoforsmstextcontoller =
      TextEditingController();
  final TextEditingController selfpitextcontoller = TextEditingController();
  final TextEditingController vehicleTypetextcontoller =
      TextEditingController(text: "New");
  final TextEditingController rcverifiedtextcontoller =
      TextEditingController(text: "Yes");
  final TextEditingController vehiclerunningconditiontextcontoller =
      TextEditingController(text: "Yes");

  int registrationtypeselectedvalue = 1;

  bool pifeecollectedswitchValue = false;
  bool vehicleTypeswitchValue = true;
  bool registrationnumberformatswitchValue = true;
  bool rcverifiedswitchValue = true;
  bool vehiclerunningconditionswitchValue = true;

  bool isrccopyuploaded = false;
  bool ispreviouspolicyuploaded = false;
  bool isinvoicecopyuploaded = false;

  void showYearPicker(BuildContext context, PIDetailBloc yearPickerBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: BlocProvider.value(
            value: yearPickerBloc,
            child: BlocBuilder<PIDetailBloc, PIDetailState>(
              builder: (context, state) {
                return SizedBox(
                  height: 250,
                  child: YearPicker(
                    selectedDate: DateTime(state is YearPickerUpdatedState
                        ? state.selectedYear
                        : DateTime.now().year),
                    onChanged: (DateTime? year) {
                      if (year != null) {
                        context
                            .read<PIDetailBloc>()
                            .add(YearSelectedEvent(year.year));

                        // Update the year to the controller
                        yearofmanuftextcontoller.text = year.year.toString();
                        Navigator.of(context).pop();
                      }
                    },
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // This method is used to display the bottom sheet
  void showCustomBottomSheet(
      BuildContext context, PIDetailBloc pidetailbloc, String type) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: pidetailbloc,
            child:
                BlocBuilder<PIDetailBloc, PIDetailState>(builder: (ctx, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Gallery'),
                    onTap: () async {
                      Navigator.pop(context);
                      ctx
                          .read<PIDetailBloc>()
                          .add(GetFromCameraEvent(type, "Gallery", context));

                      //   await getFromGallery(doctype, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      ctx
                          .read<PIDetailBloc>()
                          .add(GetFromCameraEvent(type, "Camera", context));
                      // getFromCamera(doctype, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.picture_as_pdf),
                    title: const Text('PDF'),
                    onTap: () {
                      Navigator.pop(context);
                      ctx
                          .read<PIDetailBloc>()
                          .add(PickPdfEvent(type, "PDF", context));
                      //  pickpdf(doctype, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_document),
                    title: const Text('Document'),
                    onTap: () {
                      Navigator.pop(context);
                      ctx
                          .read<PIDetailBloc>()
                          .add(PickPdfEvent(type, "DOC", context));
                      // pickdoc(doctype, context);
                    },
                  ),
                ],
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => PIDetailBloc(),
      child: BlocConsumer<PIDetailBloc, PIDetailState>(
          listener: (context, state) async {
        if (state is PIDetailGetApiState) {
         attachmentId = state.pidetailsresponse.response![0].attachmentid ?? "";
          branchnametextcontoller.text =
              state.pidetailsresponse.response![0].branchname ?? "";
          surveyornametextcontoller.text = state
              .pidetailsresponse.response![0].surveyorAgencyName
              .toString();
          producttextcontoller.text =
              state.pidetailsresponse.response![0].productname.toString();
          epcrtextcontoller.text =
              state.pidetailsresponse.response![0].engincover.toString();
          vehiclecategorytextcontoller.text =
              state.pidetailsresponse.response![0].productCategory.toString();
          seatingCapcitytextcontoller.text =
              state.pidetailsresponse.response![0].seatingcapacity.toString();
          gvwtextcontoller.text =
              state.pidetailsresponse.response![0].gvw.toString();
          pipurposetextcontoller.text =
              state.pidetailsresponse.response![0].intimationpurpose.toString();
          // endoresementtypetextcontoller.text =
          //     state.pidetailsresponse.response![0].endorsementType.toString() == "null"
          //         ? ""
          //         : state.pidetailsresponse.response![0].endorsementType.toString();
          policynumbertextcontoller.text =
              state.pidetailsresponse.response![0].policyno.toString();
          maketextcontoller.text =
              state.pidetailsresponse.response![0].make.toString();
          modeltextcontoller.text =
              state.pidetailsresponse.response![0].model.toString();
          fueltypetextcontoller.text =
              state.pidetailsresponse.response![0].fueltype.toString();
          vehicleTypetextcontoller.text =
              state.pidetailsresponse.response![0].vehicletype.toString();
          state.pidetailsresponse.response![0].vehicleRegNo
                      .toString()
                      .split("-")[1] ==
                  "BH"
              ? null
              : rtocodetextcontoller.text =
                  "${state.pidetailsresponse.response![0].vehicleRegNo.toString().split("-")[0]}-${state.pidetailsresponse.response![0].vehicleRegNo.toString().split("-")[1]}";
          // rtonametextcontoller.text = state.pidetailsresponse.response![0].rtoname.toString();
          r1textcontoller.text = state
              .pidetailsresponse.response![0].vehicleRegNo
              .toString()
              .split("-")[0];
          r2textcontoller.text = state
              .pidetailsresponse.response![0].vehicleRegNo
              .toString()
              .split("-")[1];
          r3textcontoller.text = state
              .pidetailsresponse.response![0].vehicleRegNo
              .toString()
              .split("-")[2];
          r4textcontoller.text = state
              .pidetailsresponse.response![0].vehicleRegNo
              .toString()
              .split("-")[3];
          yearofmanuftextcontoller.text =
              state.pidetailsresponse.response![0].yearofmanuf.toString();
          enginenumbertextcontoller.text =
              state.pidetailsresponse.response![0].engineno.toString();
          chassisnumbertextcontoller.text =
              state.pidetailsresponse.response![0].chassisno.toString();
          idvtextcontoller.text =
              state.pidetailsresponse.response![0].idvvehicle.toString();
          contactpersontextcontoller.text =
              state.pidetailsresponse.response![0].contactperson.toString();
          contactmobienumbertextcontoller.text =
              state.pidetailsresponse.response![0].contactmobileno.toString();
          prefixtextcontoller.text =
              state.pidetailsresponse.response![0].title.toString();
          insurednametextcontoller.text =
              state.pidetailsresponse.response![0].insuredname.toString();
          inspectionlocationtextcontoller.text = state
              .pidetailsresponse.response![0].inspectionLocation1
              .toString();
          proposaltypetextcontoller.text =
              state.pidetailsresponse.response![0].proposaltype.toString();
          sgicpolicynumbertextcontoller.text =
              state.pidetailsresponse.response![0].sgicpolicyno.toString();
          odometertextcontoller.text =
              state.pidetailsresponse.response![0].odometerreading.toString();
          preinspectionstatustextcontoller.text = state
                      .pidetailsresponse.response![0].agencystatus
                      .toString() ==
                  "Reffered To Underwriter"
              ? "Recommended"
              : state.pidetailsresponse.response![0].agencystatus.toString();
          ncbtextcontoller.text =
              state.pidetailsresponse.response![0].ncbPer.toString();
          rcverifiedtextcontoller.text =
              state.pidetailsresponse.response![0].rcverified.toString() == "1"
                  ? "Yes"
                  : "No";
          dentedpartstextcontoller.text =
              state.pidetailsresponse.response![0].dentedparts.toString();
          scratchedpartstextcontoller.text =
              state.pidetailsresponse.response![0].scratchedparts.toString();
          brokenpartstextcontoller.text =
              state.pidetailsresponse.response![0].brokenparts.toString();
          vehiclerunningconditiontextcontoller.text = state
                      .pidetailsresponse.response![0].vehRunningCondition
                      .toString() ==
                  "Y"
              ? "Yes"
              : "No";
          surveyorremarkstextcontoller.text =
              state.pidetailsresponse.response![0].surveyorremark.toString();
          // currentstatustextcontoller.text =
          //       /*   intimationstatus  *//* Provider.of<DashboardScreenNotifier>(
          //         navigatorKey.currentContext!,
          //         listen: false)
          //     .iseditdata */
          //     ;
          arhtextcontoller.text = state
              .pidetailsresponse.response![0].remarksifcancelled
              .toString();
          detailremarkstextcontoller.text =
              state.pidetailsresponse.response![0].remarks.toString();
          pifeecollectedtextcontoller.text =
              state.pidetailsresponse.response![0].pifeescollected.toString();
          pifeeamounttextcontoller.text =
              state.pidetailsresponse.response![0].pifeesamount.toString();
          conveyanceamounttextcontoller.text = state
                  .pidetailsresponse.response![0].conveyanceamount
                  .toString()
                  .contains("#")
              ? ""
              : state.pidetailsresponse.response![0].conveyanceamount
                  .toString();
          modeofpaymenttextcontoller.text =
              state.pidetailsresponse.response![0].modeofpayment.toString();
          intimationstatustextcontoller.text =
              state.pidetailsresponse.response![0].intimationremarks.toString();
          contactnoforsmstextcontoller.text =
              state.pidetailsresponse.response![0].contacttoSendlink.toString();
        } else if (state is PIDetailSaveApiState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.piDetailSaveResponse.messageResult!.successMessage ??
                      ""),
              backgroundColor: Colors.red,
            ),
          );
          context.read<PIDetailBloc>().add(PISubmitEvent());
        } else if (state is BranchListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: branchnametextcontoller,
              getList: state.getList,
              screenName: "Branch",
              context: context));
        } else if (state is SurveyourListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: surveyornametextcontoller,
              getList: state.getList,
              screenName: "Surveyor Name",
              context: context));
        } else if (state is ProductListLoaded) {
          producttextcontoller.text = "";
          vehiclecategorytextcontoller.text = "";
          seatingCapcitytextcontoller.text = "";
          pipurposetextcontoller.text = "";
          endoresementtypetextcontoller.text = "";
          policynumbertextcontoller.text = "";
          gvwtextcontoller.text = "";
          idvtextcontoller.text = "";
          epcrtextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: producttextcontoller,
              getList: state.getList,
              screenName: "Product",
              context: context));
        } /* else if (state is VehicleCategoryShow) {
          debugPrint("*****");
          context.read<PIDetailBloc>().add(
              ShowVehicleCategory(product: vehiclecategorytextcontoller.text));
        } */
        else if (state is ShowBottomSheetState) {
          showCustomBottomSheet(context, context.read<PIDetailBloc>(),
              state.type); // Call the method to display the bottom sheet
        } else if (state is FuelTypeListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: fueltypetextcontoller,
              getList: state.getList,
              screenName: "Fuel Type",
              context: context));
        } else if (state is PIDetailProductCodeFetched) {
          state.api == "vc"
              ? {
                  context.read<PIDetailBloc>().add(FetchVehicleCategoryApi(
                      partyId: "100000000138661", vehCode: state.productCode))
                }
              : state.api == "make"
                  ? {
                      context.read<PIDetailBloc>().add(FetchMakeApi(
                          partyId: "100000000138661",
                          productCode: state.productCode))
                    }
                  : {
                      context.read<PIDetailBloc>().add(FetchModelApi(
                          partyId: "100000000138661",
                          productCode: state.productCode,
                          makeCode: ''))
                    };
          debugPrint(state.productCode);
        } else if (state is VehicleTypeState) {
          vehicleTypeswitchValue = state.isCollected;
          if (vehicleTypeswitchValue == true) {
            vehicleTypetextcontoller.text = "New";
          } else {
            vehicleTypetextcontoller.text = "Old";
          }
        } else if (state is RegistrationNumberFormatState) {
          registrationnumberformatswitchValue = state.isCollected;
          if (registrationnumberformatswitchValue == true) {
            registrationnumberformattextcontoller.text = "New Format";
          } else {
            registrationnumberformattextcontoller.text = "Old Format";
          }
        } else if (state is EPShowState) {
          epcrtextcontoller.text = state.value;
        } else if (state is VehicleCategoryListLoaded) {
          pipurposetextcontoller.text = "";
          seatingCapcitytextcontoller.text = "";
          gvwtextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: vehiclecategorytextcontoller,
              getList: state.getList,
              screenName: "Vehicle Category",
              context: context));
        } else if (state is SeatingCapacityLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: seatingCapcitytextcontoller,
              getList: state.getList,
              screenName: "Seating Capacity",
              context: context));
        } else if (state is GVWLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: gvwtextcontoller,
              getList: state.getList,
              screenName: "Gross Vehicle Weight",
              context: context));
        } else if (state is RegistrationTypeState) {
          registrationtypeselectedvalue = state.selectedValue;
          rtocodetextcontoller.text = state.rtoCode;
          rtonametextcontoller.text = state.rtoName;
          r1textcontoller.text = state.regisNumberOne;
          r2textcontoller.text = state.regisNumberTwo;
          r3textcontoller.text = state.regisNumberThree;
          r4textcontoller.text = state.regisNumberFour;
        } else if (state is PiPuroseListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: pipurposetextcontoller,
              getList: state.getList,
              screenName: "PI Purpose",
              context: context));
        } else if (state is EndoresementTypeListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: endoresementtypetextcontoller,
              getList: state.getList,
              screenName: "Endoresement Type",
              context: context));
        } else if (state is MakeListLoaded) {
          modeltextcontoller.text = "";
          fueltypetextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: maketextcontoller,
              getList: state.getList,
              screenName: "Make",
              context: context));
        } else if (state is ModelListLoaded) {
          fueltypetextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: modeltextcontoller,
              getList: state.getList,
              screenName: "Model",
              context: context));
        } else if (state is PIDetailRtoCodeLoaded) {
          context.read<PIDetailBloc>().add(ChooseRTOValue(
              rtocodecontroller: rtocodetextcontoller,
              rtonamecontroller: rtonametextcontoller,
              r1controller: r1textcontoller,
              r2controller: r2textcontoller,
              getList: state.rtoCodeList,
              screenName: "RTO Code",
              context: context));
        } else if (state is IdvLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: idvtextcontoller,
              getList: state.getList,
              screenName: "IDV",
              context: context));
        } else if (state is PrefixLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: prefixtextcontoller,
              getList: state.getList,
              screenName: "Prefix",
              context: context));
        } else if (state is ProposalTypeLoaded) {
          sgicpolicynumbertextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: proposaltypetextcontoller,
              getList: state.getList,
              screenName: "Proposal Type",
              context: context));
        } else if (state is PreInspectionLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: preinspectionstatustextcontoller,
              getList: state.getList,
              screenName: "Pre Inspection",
              context: context));
        } else if (state is NCBLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: ncbtextcontoller,
              getList: state.getList,
              screenName: "NCB",
              context: context));
        } else if (state is PaymentLoaded) {
          pifeeamounttextcontoller.text = "";
          conveyanceamounttextcontoller.text = "";
          modeofpaymenttextcontoller.text = "";
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: modeofpaymenttextcontoller,
              getList: state.getList,
              screenName: "Mode of Payment",
              context: context));
        } else if (state is PIDetailShowEndorsementState) {
          debugPrint("isShowEndorsementType: ${state.isShowEndorsementType}");
          debugPrint("isShowPolicyNumber: ${state.isShowPolicyNumber}");
        } /* else if (state is PISubimtState) {
          context.read<PIDetailBloc>().add(PISubmitEvent());
        }  */
        else if (state is PIDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, builder: (context, state) {
        producttextcontoller.addListener(
          () {
            if (producttextcontoller.text.isNotEmpty) {
              context
                  .read<PIDetailBloc>()
                  .add(ShowVehicleCategory(product: producttextcontoller.text));
              context
                  .read<PIDetailBloc>()
                  .add(ShowGVW(product: producttextcontoller.text));
              context.read<PIDetailBloc>().add(ShowIDV(
                  product: producttextcontoller.text, vehiclecategory: ""));
            } else {
              context
                  .read<PIDetailBloc>()
                  .add(ShowVehicleCategory(product: producttextcontoller.text));
              context
                  .read<PIDetailBloc>()
                  .add(ShowGVW(product: producttextcontoller.text));
              context.read<PIDetailBloc>().add(ShowIDV(
                  product: producttextcontoller.text, vehiclecategory: ""));
            }
          },
        );
        pipurposetextcontoller.addListener(
          () {
            if (pipurposetextcontoller.text.isNotEmpty) {
              context.read<PIDetailBloc>().add(
                  ShowEndorsementType(piPurpose: pipurposetextcontoller.text));
            } else {
              context.read<PIDetailBloc>().add(
                  ShowEndorsementType(piPurpose: pipurposetextcontoller.text));
            }
            if (producttextcontoller.text.isNotEmpty &&
                pipurposetextcontoller.text.isNotEmpty) {
              context.read<PIDetailBloc>().add(ShowEPCR(
                  product: producttextcontoller.text,
                  pipurpose: pipurposetextcontoller.text));
            } else {
              context.read<PIDetailBloc>().add(ShowEPCR(
                  product: producttextcontoller.text,
                  pipurpose: pipurposetextcontoller.text));
            }
          },
        );
        vehiclecategorytextcontoller.addListener(
          () {
            if (producttextcontoller.text.isNotEmpty &&
                vehiclecategorytextcontoller.text.isNotEmpty) {
              context.read<PIDetailBloc>().add(ShowSeatingCapacity(
                  product: producttextcontoller.text,
                  vehiclecategory: vehiclecategorytextcontoller.text));
              context.read<PIDetailBloc>().add(ShowIDV(
                  product: producttextcontoller.text,
                  vehiclecategory: vehiclecategorytextcontoller.text));
            } else {
              context.read<PIDetailBloc>().add(ShowSeatingCapacity(
                  product: producttextcontoller.text,
                  vehiclecategory: vehiclecategorytextcontoller.text));
              context.read<PIDetailBloc>().add(ShowIDV(
                  product: producttextcontoller.text,
                  vehiclecategory: vehiclecategorytextcontoller.text));
            }
          },
        );
        proposaltypetextcontoller.addListener(
          () {
            if (proposaltypetextcontoller.text.isNotEmpty) {
              context.read<PIDetailBloc>().add(
                  ShowSGICEvent(proposaltype: proposaltypetextcontoller.text));
            } else {
              context.read<PIDetailBloc>().add(
                  ShowSGICEvent(proposaltype: proposaltypetextcontoller.text));
            }
          },
        );
        intimationstatustextcontoller.addListener(
          () {
            if (intimationstatustextcontoller.text.isNotEmpty) {
              context.read<PIDetailBloc>().add(ShowCurrentStatusEvent(
                  intimationStatus: intimationstatustextcontoller.text));
            } else {
              context.read<PIDetailBloc>().add(ShowCurrentStatusEvent(
                  intimationStatus: intimationstatustextcontoller.text));
            }
          },
        );
        if (state is PIDetailInitial) {
          widget.hitapiflow
              ? context.read<PIDetailBloc>().add(PIDetailsGetApiEvent(
                  preInspectionId: preInspectionId, userPartyId: userId))
              : {
                  widget.ownflow
                      ? surveyornametextcontoller.text = userName
                      : "",
                  inspectionlocationtextcontoller.text =
                      '${widget.place!.street}, ${widget.place!.thoroughfare}, ${widget.place!.subLocality}, ${widget.place!.locality}, ${widget.place!.administrativeArea}, ${widget.place!.country}, ${widget.place!.postalCode}'
                };
        }

        if (state is PiFeeCollectedState) {
          pifeecollectedswitchValue = state.isCollected;
          if (pifeecollectedswitchValue == true) {
            pifeecollectedtextcontoller.text = "Yes";
          } else {
            pifeecollectedtextcontoller.text = "No";
          }
        }

        if (state is RcVerifiedState) {
          rcverifiedswitchValue = state.isCollected;
          if (rcverifiedswitchValue == true) {
            rcverifiedtextcontoller.text = "Yes";
          } else {
            rcverifiedtextcontoller.text = "No";
          }
        }
        if (state is VehicleRunningConditionState) {
          vehiclerunningconditionswitchValue = state.isCollected;
          if (vehiclerunningconditionswitchValue == true) {
            vehiclerunningconditiontextcontoller.text = "Yes";
          } else {
            vehiclerunningconditiontextcontoller.text = "No";
          }
        }

        return OverlayLoaderWithAppIcon(
          appIconSize: 60,
          circularProgressColor: Colors.transparent,
          overlayBackgroundColor: Colors.black87,
          isLoading: state is PIDetailLoading,
          appIcon: Image.asset(
            'assest/loadgif.gif',
          ),
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: appcolor,
                title: const Text('PreInspection'),
                centerTitle: true),
            body: SingleChildScrollView(
              child: Container(
                height: height / 1.1,
                width: width,
                color: Colors.grey.shade300,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CurvedBottomClipper(),
                      child: Container(
                        height: height / 4,
                        width: width,
                        color: appcolor,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: SizedBox(
                          height: height / 1.13,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                child: Form(
                                  //   key: provider.formKey,
                                  child: IgnorePointer(
                                    ignoring:
                                        false /* provider.allowedit(context) */,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DropDownPiWidget(
                                          controller: branchnametextcontoller,
                                          labelText: "Branch Name",
                                          onTap: () async {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(FetchBranchNameApi());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: !widget.otherflow,
                                          visible: true,
                                          controller: surveyornametextcontoller,
                                          labelText: "Surveyor Name",
                                          suffixIcon: widget.otherflow
                                              ? IconButton(
                                                  onPressed: () {
                                                    if (surveyornametextcontoller
                                                            .text.length >=
                                                        4) {
                                                      context.read<PIDetailBloc>().add(
                                                          FetchSurveyorNameApi(
                                                              partyId:
                                                                  "100000000138661",
                                                              //branchId: ,
                                                              searchValue:
                                                                  surveyornametextcontoller
                                                                      .text));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              "Enter atleast 4 characters"),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  icon:
                                                      const Icon(Icons.search))
                                              : null,
                                        ),
                                        DropDownPiWidget(
                                          controller: producttextcontoller,
                                          labelText: "Product",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Product",
                                                    productname:
                                                        producttextcontoller
                                                            .text,
                                                    vehcategory:
                                                        vehiclecategorytextcontoller
                                                            .text,
                                                    seatingcap:
                                                        seatingCapcitytextcontoller
                                                            .text));
                                          },
                                        ),
                                        //  if (state is VehicleCategoryShow)
                                        DropDownPiWidget(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowVehicleCategory,
                                          controller:
                                              vehiclecategorytextcontoller,
                                          labelText: "Vehicle Category",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "vc"));

                                            // context.read<PIDetailBloc>().add(
                                            //     FetchVehicleCategoryApi(
                                            //         partyId: "100000000138661",
                                            //         vehCode: state
                                            //                 is PIDetailProductCodeFetched
                                            //             ? state.productCode
                                            //             : ""));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowSeatingCapacity,
                                          controller:
                                              seatingCapcitytextcontoller,
                                          labelText: "Seating Capacity",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(FetchSeatingCapacity());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowgvw,
                                          controller: gvwtextcontoller,
                                          labelText: "Gross Vehicle Weight",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(Fetchgvw());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: pipurposetextcontoller,
                                          labelText: "PI Purpose",
                                          onTap: () async {
                                            if (producttextcontoller.text ==
                                                "PCCV") {
                                              if (vehiclecategorytextcontoller
                                                      .text ==
                                                  "") {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) =>
                                                          const AlertDialog(
                                                    content: SizedBox(
                                                        height: 60,
                                                        width: 60,
                                                        child: Center(
                                                            child: Text(
                                                                "Please Select Vehicle Category First"))),
                                                  ),
                                                );
                                              } else {
                                                context
                                                    .read<PIDetailBloc>()
                                                    .add(FetchLoadComboApi(
                                                        partyId:
                                                            "100000000138661",
                                                        name: "PI Purpose",
                                                        productname:
                                                            producttextcontoller
                                                                .text,
                                                        vehcategory:
                                                            vehiclecategorytextcontoller
                                                                .text,
                                                        seatingcap:
                                                            seatingCapcitytextcontoller
                                                                .text));
                                              }
                                            } else {
                                              producttextcontoller.text == ""
                                                  ? showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) =>
                                                              const AlertDialog(
                                                        content: SizedBox(
                                                            height: 60,
                                                            width: 60,
                                                            child: Center(
                                                                child: Text(
                                                                    "Please Select Product List First"))),
                                                      ),
                                                    )
                                                  : context
                                                      .read<PIDetailBloc>()
                                                      .add(FetchLoadComboApi(
                                                          partyId:
                                                              "100000000138661",
                                                          name: "PI Purpose",
                                                          productname:
                                                              producttextcontoller
                                                                  .text,
                                                          vehcategory:
                                                              vehiclecategorytextcontoller
                                                                  .text,
                                                          seatingcap:
                                                              seatingCapcitytextcontoller
                                                                  .text));
                                            }
                                          },
                                        ),
                                        Visibility(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowepcr,
                                          child: Column(
                                            children: [
                                              Visibility(
                                                visible: context
                                                    .read<PIDetailBloc>()
                                                    .isShowepcr /*  provider
                                                                              .pipuposecontroller
                                                                              .text ==
                                                                          "Nil Dep." ||
                                                                      provider.pipuposecontroller
                                                                              .text ==
                                                                          "Break-In with Nil Dep." */
                                                ,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                  child: TextFormField(
                                                    controller:
                                                        epcrtextcontoller,
                                                    onTap: () {
                                                      context
                                                          .read<PIDetailBloc>()
                                                          .add(ShowEP(
                                                              value:
                                                                  epcrtextcontoller
                                                                      .text));
                                                      // provider
                                                      //     .showprotectorcoverselectvalue();
                                                    },
                                                    cursorColor: Colors.black,
                                                    cursorHeight: 20,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Does Engine Protector Cover Required?",
                                                      hintTextDirection:
                                                          ui.TextDirection.ltr,
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      suffixIcon: const IconButton(
                                                          onPressed: null,
                                                          icon: Icon(Icons
                                                              .arrow_drop_down)),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 14.0,
                                                              bottom: 8.0,
                                                              top: 8.0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: context
                                                    .read<PIDetailBloc>()
                                                    .isShowep /* provider
                                                                              .productcontroller
                                                                              .text ==
                                                                          "PRIVATE CAR" &&
                                                                      provider
                                                                          .isprotectedcoverrequired */
                                                ,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        tileColor:
                                                            greycolor.shade100,
                                                        title: const Center(
                                                            child: Text("Yes")),
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  PIDetailBloc>()
                                                              .add(const ShowEP(
                                                                  value:
                                                                      "Yes"));
                                                          // provider
                                                          //     .selectyesprotectorcovervalue();
                                                        },
                                                      ),
                                                      const Divider(),
                                                      ListTile(
                                                        tileColor:
                                                            greycolor.shade100,
                                                        title: const Center(
                                                            child: Text("No")),
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  PIDetailBloc>()
                                                              .add(const ShowEP(
                                                                  value: "No"));
                                                          // provider
                                                          //     .selectnoprotectorcovervalue();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowepcr /* provider
                                                                        .pipuposecontroller
                                                                        .text ==
                                                                    "Nil Dep." ||
                                                                provider.pipuposecontroller
                                                                        .text ==
                                                                    "Break-In with Nil Dep." */
                                          ,
                                          child: const SizedBox(
                                            height: 10,
                                          ),
                                        ),
                                        DropDownPiWidget(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowEndorsementType,
                                          controller:
                                              endoresementtypetextcontoller,
                                          labelText: "Endorsement Type",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Endorsement Type",
                                                    productname:
                                                        producttextcontoller
                                                            .text,
                                                    vehcategory:
                                                        vehiclecategorytextcontoller
                                                            .text,
                                                    seatingcap:
                                                        seatingCapcitytextcontoller
                                                            .text));
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowEndorsementType,
                                          controller: policynumbertextcontoller,
                                          labelText: "Policy Number",
                                        ),
                                        DropDownPiWidget(
                                          controller: maketextcontoller,
                                          labelText: "Make",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "make"));
                                            //  context.read<PIDetailBloc>().add(
                                            //     FetchMakeApi(
                                            //       partyId: ,
                                            //       productCode: ,
                                            //        ));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: modeltextcontoller,
                                          labelText: "Model",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "model"));
                                            // BlocProvider.of<PIDetailBloc>(
                                            //         context)
                                            //     .add(
                                            //   const FetchModelApi(
                                            //       partyId: "100000000138661",
                                            //       productCode: "",
                                            //       makeCode: ),
                                            // );
                                            // context.read<PIDetailBloc>().add(
                                            //     ProductSelected(
                                            //         producttextcontoller.text,
                                            //         "model"));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: fueltypetextcontoller,
                                          labelText: "Fuel Type",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Fuel Type",
                                                    productname:
                                                        producttextcontoller
                                                            .text,
                                                    vehcategory:
                                                        vehiclecategorytextcontoller
                                                            .text,
                                                    seatingcap:
                                                        seatingCapcitytextcontoller
                                                            .text));
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          controller: vehicleTypetextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          readOnly: true,
                                          labelText: "Vehicle Type",
                                          suffixIcon: Switch(
                                            onChanged: (value) {
                                              context.read<PIDetailBloc>().add(
                                                  VehicleTypeToggleSwitch(
                                                      isCollected: value));
                                            } /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                vehicleTypeswitchValue /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Registration Type",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue:
                                                    registrationtypeselectedvalue /*  provider
                                                                      .selectedregistrationtypeRadio */
                                                ,
                                                activeColor: appcolor,
                                                onChanged: (value) {
                                                  context.read<PIDetailBloc>().add(
                                                      RegistrationTypeSelectedEvent(
                                                          selectedValue:
                                                              value ?? 1));
                                                  // provider
                                                  //     .setregistrationtypeSelectedRadio(
                                                  //         value!);
                                                },
                                              ),
                                              const Text('Normal'),
                                              const SizedBox(width: 20),
                                              Radio(
                                                value: 2,
                                                groupValue:
                                                    registrationtypeselectedvalue /*  provider
                                                                      .selectedregistrationtypeRadio */
                                                ,
                                                activeColor: appcolor,
                                                onChanged: (value) {
                                                  context.read<PIDetailBloc>().add(
                                                      RegistrationTypeSelectedEvent(
                                                          selectedValue:
                                                              value ?? 2));
                                                  // provider
                                                  //     .setregistrationtypeSelectedRadio(
                                                  //         value!);
                                                },
                                              ),
                                              const Text('Bharat'),
                                            ],
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          controller: rtocodetextcontoller,
                                          ignoring:
                                              registrationtypeselectedvalue ==
                                                  2,
                                          visible: true,
                                          labelText: "RTO Code",
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                if (rtocodetextcontoller
                                                        .text.length <
                                                    2) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) =>
                                                            const AlertDialog(
                                                      content: SizedBox(
                                                          height: 60,
                                                          width: 60,
                                                          child: Center(
                                                              child: Text(
                                                                  "Please Enter at least 2 digits"))),
                                                    ),
                                                  );
                                                } else {
                                                  context
                                                      .read<PIDetailBloc>()
                                                      .add(GetRtoCodeEvent(
                                                          partyId:
                                                              "100000000138661",
                                                          name:
                                                              rtocodetextcontoller
                                                                  .text));
                                                }
                                              },
                                              icon: const Icon(Icons.search)),
                                        ),
                                        TextFieldPiWidget(
                                          controller: rtonametextcontoller,
                                          ignoring:
                                              registrationtypeselectedvalue ==
                                                  2,
                                          visible: true,
                                          labelText: "RTO Name",
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              registrationnumberformattextcontoller,
                                          visible: widget.otherflow,
                                          readOnly: true,
                                          labelText:
                                              "Registration Number Format",
                                          suffixIcon: Switch(
                                            onChanged: (value) {
                                              context.read<PIDetailBloc>().add(
                                                  RegistrationNumberFormatToggleSwitch(
                                                      isCollected: value));
                                            } /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                registrationnumberformatswitchValue /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Registration Number",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: r1textcontoller,
                                                  maxLength: 2,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            "[0-9a-zA-Z]")),
                                                  ],
                                                  onChanged: (value) {
                                                    if (registrationtypeselectedvalue ==
                                                        2) {
                                                      if (value.length == 2) {
                                                        var dateTime =
                                                            DateTime.now();
                                                        var currentyear =
                                                            DateFormat("yy")
                                                                .format(
                                                                    dateTime);
                                                        var currectyearone =
                                                            int.parse(
                                                                    currentyear) -
                                                                1;
                                                        var currectyeartwo =
                                                            int.parse(
                                                                    currentyear) -
                                                                2;
                                                        var currectyearthree =
                                                            int.parse(
                                                                    currentyear) -
                                                                3;
                                                        debugPrint(
                                                            "$currentyear $currectyearone $currectyeartwo $currectyearthree");
                                                        if (r1textcontoller
                                                                    .text ==
                                                                currentyear ||
                                                            r1textcontoller
                                                                    .text ==
                                                                currectyearone
                                                                    .toString() ||
                                                            r1textcontoller
                                                                    .text ==
                                                                currectyeartwo
                                                                    .toString()) {
                                                        } else {
                                                          r1textcontoller.text =
                                                              "";
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) =>
                                                                    AlertDialog(
                                                              content: SizedBox(
                                                                  height: 60,
                                                                  width: 60,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "Please enter the value greater than $currectyearthree and lesser than or equal to current year",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ))),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    }
                                                  },
                                                  // focusNode: provider
                                                  //     .focusregisnumberone,
                                                  readOnly:
                                                      registrationtypeselectedvalue ==
                                                              2
                                                          ? false
                                                          : true,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  keyboardType:
                                                      registrationtypeselectedvalue ==
                                                              2
                                                          ? TextInputType.number
                                                          : TextInputType.name,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor:
                                                        const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: r2textcontoller,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Visibility(
                                                visible:
                                                    registrationtypeselectedvalue ==
                                                            2 ||
                                                        registrationnumberformatswitchValue,
                                                child: Expanded(
                                                  child: TextFormField(
                                                    controller: r3textcontoller,
                                                    maxLength:
                                                        registrationtypeselectedvalue ==
                                                                2
                                                            ? 4
                                                            : 3,
                                                    onChanged: (value) {
                                                      // if (provider
                                                      //         .selectedregistrationtypeRadio ==
                                                      //     1) {
                                                      //   if (value
                                                      //       .isNotEmpty) {
                                                      //     if (RegExp(
                                                      //             r'^[0-9]*$')
                                                      //         .hasMatch(
                                                      //             value)) {
                                                      //       provider
                                                      //           .regisnumberthreecontroller
                                                      //           .text = "";
                                                      //       showDialog(
                                                      //         context:
                                                      //             context,
                                                      //         builder:
                                                      //             (alertDialogContext) =>
                                                      //                 const AlertDialog(
                                                      //           content: SizedBox(
                                                      //               height: 60,
                                                      //               width: 60,
                                                      //               child: Center(
                                                      //                   child: Text(
                                                      //                 "Only alphabets are allowed",
                                                      //                 style:
                                                      //                     TextStyle(color: redcolor),
                                                      //               ))),
                                                      //         ),
                                                      //       );
                                                      //     }
                                                      //   }
                                                      // }
                                                    },
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              "[0-9a-zA-Z]")),
                                                    ],

                                                    // focusNode: provider
                                                    //     .focusregisnumberthree,
                                                    cursorColor: Colors.black,
                                                    cursorHeight: 20,
                                                    keyboardType:
                                                        registrationtypeselectedvalue == 2
                                                            ? TextInputType
                                                                .number
                                                            : TextInputType
                                                                .text,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                      hintTextDirection:
                                                          ui.TextDirection.ltr,
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 14.0,
                                                              bottom: 8.0,
                                                              top: 8.0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    registrationtypeselectedvalue ==
                                                            2 ||
                                                        registrationnumberformatswitchValue,
                                                child: const SizedBox(
                                                  width: 10,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: r4textcontoller,
                                                  maxLength:
                                                      registrationtypeselectedvalue ==
                                                              2
                                                          ? 2
                                                          : 4,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            "[0-9a-zA-Z]")),
                                                  ],
                                                  onChanged: (value) {
                                                    // if (provider
                                                    //         .selectedregistrationtypeRadio ==
                                                    //     2) {
                                                    //   if (RegExp(
                                                    //           r'^[a-zA-Z]*$')
                                                    //       .hasMatch(
                                                    //           value)) {
                                                    //     if (value
                                                    //             .toUpperCase()
                                                    //             .contains(
                                                    //                 "I") ||
                                                    //         value
                                                    //             .toUpperCase()
                                                    //             .contains(
                                                    //                 "O")) {
                                                    //       provider
                                                    //           .regisnumberfourcontroller
                                                    //           .text = "";
                                                    //       showDialog(
                                                    //         context:
                                                    //             context,
                                                    //         builder:
                                                    //             (alertDialogContext) =>
                                                    //                 const AlertDialog(
                                                    //           content: SizedBox(
                                                    //               height: 60,
                                                    //               width: 60,
                                                    //               child: Center(
                                                    //                   child: Text(
                                                    //                 "Registration Number Should Not Contain \"I\" and \"O\"",
                                                    //                 style:
                                                    //                     TextStyle(color: redcolor),
                                                    //               ))),
                                                    //         ),
                                                    //       );
                                                    //     }
                                                    //   } else {
                                                    //     provider
                                                    //         .regisnumberfourcontroller
                                                    //         .text = "";
                                                    //     showDialog(
                                                    //       context:
                                                    //           context,
                                                    //       builder:
                                                    //           (alertDialogContext) =>
                                                    //               const AlertDialog(
                                                    //         content: SizedBox(
                                                    //             height: 60,
                                                    //             width: 60,
                                                    //             child: Center(
                                                    //                 child: Text(
                                                    //               "Only alphabets are allowed",
                                                    //               style: TextStyle(
                                                    //                   color:
                                                    //                       redcolor),
                                                    //             ))),
                                                    //       ),
                                                    //     );
                                                    //   }
                                                    // }
                                                  },

                                                  // focusNode: provider
                                                  //     .focusregistrationfournumber,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  keyboardType:
                                                      registrationtypeselectedvalue ==
                                                              2
                                                          ? TextInputType.text
                                                          : TextInputType
                                                              .number,
                                                  textCapitalization:
                                                      registrationtypeselectedvalue ==
                                                              2
                                                          ? TextCapitalization
                                                              .characters
                                                          : TextCapitalization
                                                              .none,
                                                  onTapOutside: (event) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          controller: yearofmanuftextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          readOnly: true,
                                          labelText: "Year Of Manufacturing",
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                showYearPicker(
                                                    context,
                                                    context
                                                        .read<PIDetailBloc>());
                                              },
                                              icon:
                                                  const Icon(Icons.date_range)),
                                        ),
                                        TextFieldPiWidget(
                                          controller: enginenumbertextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Engine Number",
                                          maxLength: 30,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              chassisnumbertextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Chassis Number",
                                          maxLength: 30,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                        ),
                                        DropDownPiWidget(
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowidv,
                                          controller: idvtextcontoller,
                                          labelText: "IDV Of Vehicle",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(IdvSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              contactpersontextcontoller,
                                          ignoring: false,
                                          visible: widget.otherflow,
                                          labelText: "Contact Person",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: widget.otherflow,
                                          controller:
                                              contactmobienumbertextcontoller,
                                          labelText: "Contact Mobile Number",
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: prefixtextcontoller,
                                          labelText: "Prefix",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PrefixSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          controller: insurednametextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Insured Name",
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              inspectionlocationtextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Inspection Location",
                                          suffixIcon: const IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                  Icons.my_location_sharp)),
                                        ),
                                        DropDownPiWidget(
                                          controller: proposaltypetextcontoller,
                                          labelText: "Proposal Type",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(ProposalTypeSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: context
                                              .read<PIDetailBloc>()
                                              .isShowsgic,
                                          controller:
                                              sgicpolicynumbertextcontoller,
                                          labelText: "SGIC Policy Number",
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          controller: odometertextcontoller,
                                          labelText: "Odometer Reading",
                                          keyboardType: TextInputType.number,
                                          maxLength: 8,
                                          inputformat: "number",
                                          onChanged: (value) {},
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              preinspectionstatustextcontoller,
                                          visible: !widget.otherflow,
                                          labelText: "Pre-Inspection Status",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PreInspectionSelect());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: ncbtextcontoller,
                                          labelText: "Eligible NCB%",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(NCBSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          controller: rcverifiedtextcontoller,
                                          readOnly: true,
                                          labelText: "RC Verified",
                                          suffixIcon: Switch(
                                            onChanged: (value) {
                                              context.read<PIDetailBloc>().add(
                                                  RcVerifiedToggleSwitchEvent(
                                                      isCollected: value));
                                            } /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                rcverifiedswitchValue /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          controller: dentedpartstextcontoller,
                                          labelText: "Dented Parts",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          controller:
                                              scratchedpartstextcontoller,
                                          labelText: "Scratched Parts",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          controller: brokenpartstextcontoller,
                                          labelText: "Broken Parts",
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          controller:
                                              vehiclerunningconditiontextcontoller,
                                          readOnly: true,
                                          labelText:
                                              "Vehicle Runninig Condition",
                                          suffixIcon: Switch(
                                            onChanged: (value) {
                                              context.read<PIDetailBloc>().add(
                                                  VehicleRunningConditionSwitchEvent(
                                                      isCollected: value));
                                            },
                                            value:
                                                vehiclerunningconditionswitchValue /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          controller:
                                              surveyorremarkstextcontoller,
                                          labelText: "Surveyor Remarks",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: context
                                                  .read<PIDetailBloc>()
                                                  .isShowcurrentstatus ||
                                              widget.hitapiflow,
                                          controller:
                                              currentstatustextcontoller,
                                          labelText: "Current Status",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.hitapiflow,
                                          controller: arhtextcontoller,
                                          labelText:
                                              "Approve/Reject/Hold Remarks",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.hitapiflow,
                                          controller:
                                              detailremarkstextcontoller,
                                          labelText: "Details Remarks",
                                        ),
                                        IgnorePointer(
                                          ignoring: false
                                          //  provider
                                          //             .currentstatuscontroller
                                          //             .text ==
                                          //         "Survey On Hold"
                                          //     ? false
                                          //     :
                                          /*     widget.ishitapi ||
                                                                    provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "RC Copy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /*  provider
                                                                                    .isrccopyupload
                                                                                ? null
                                                                                : */
                                                              () {
                                                            context
                                                                .read<
                                                                    PIDetailBloc>()
                                                                .add(const ShowBottomSheetEvent(
                                                                    type:
                                                                        "RC Copy"));
                                                            // provider
                                                            //         .isrccopyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deleterccopy("RC Copy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "RC Copy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /*  provider
                                                                                    .isrccopyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .isrccopyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deleterccopy("RC Copy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              isrccopyuploaded /*  provider
                                                                                .isrccopyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Previous Policy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /* provider
                                                                                    .ispreviouspolicyupload
                                                                                ? null
                                                                                :  */
                                                              () {
                                                            context
                                                                .read<
                                                                    PIDetailBloc>()
                                                                .add(const ShowBottomSheetEvent(
                                                                    type:
                                                                        "Previous Policy"));
                                                            // provider
                                                            //         .ispreviouspolicyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deletepreviouspolicy("Previous Policy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "Previous Policy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /* provider
                                                                                    .ispreviouspolicyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .ispreviouspolicyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deletepreviouspolicy("Previous Policy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              ispreviouspolicyuploaded /*  provider
                                                                                .ispreviouspolicyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Invoice Copy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /* provider
                                                                                    .isinvoicecopyupload
                                                                                ? null
                                                                                :  */
                                                              () {
                                                            context
                                                                .read<
                                                                    PIDetailBloc>()
                                                                .add(const ShowBottomSheetEvent(
                                                                    type:
                                                                        "Invoice Copy"));
                                                            // provider
                                                            //         .isinvoicecopyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deleteinvoicecopy("Invoice Copy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "Invoice Copy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /*  provider
                                                                                    .isinvoicecopyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .isinvoicecopyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deleteinvoicecopy("Invoice Copy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              isinvoicecopyuploaded /*  provider
                                                                                .isinvoicecopyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              pifeecollectedtextcontoller,
                                          visible: !widget.otherflow,
                                          readOnly: true,
                                          labelText: "PI Fee Collected",
                                          suffixIcon: Switch(
                                            onChanged: (value) {
                                              context.read<PIDetailBloc>().add(
                                                  PiFeeCollectedToggleSwitch(
                                                      isCollected: value));
                                            },
                                            value: pifeecollectedswitchValue,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: pifeecollectedswitchValue,
                                          controller: pifeeamounttextcontoller,
                                          labelText: "PI Fee Amount",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: pifeecollectedswitchValue &&
                                              (!widget.otherflow ||
                                                  widget.hitapiflow),
                                          controller:
                                              conveyanceamounttextcontoller,
                                          labelText: "Conveyance Amount",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              modeofpaymenttextcontoller,
                                          visible: pifeecollectedswitchValue &&
                                              widget.ownflow,
                                          labelText: "Mode Of Payment",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PaymentSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          controller:
                                              contactnoforsmstextcontoller,
                                          maxLength: 10,
                                          labelText: "Contact no for SMS",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              intimationstatustextcontoller,
                                          visible: widget.otherflow,
                                          labelText: "Intimation Remarks",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          controller: selfpitextcontoller,
                                          maxLength: 10,
                                          labelText:
                                              "Contact no to send link for self PI",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),

                                        /*   !(provider.intimationstatus ==
                                                                          "Survey On Hold" ||
                                                                      provider.intimationstatus ==
                                                                          "Request Assign to Surveyor") &&
                                                                  (widget.ishitapi ||
                                                                      provider.issubmitted)
                                                              ? const SizedBox()
                                                              : */
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<PIDetailBloc>()
                                                      .add(
                                                          PIDetailsSaveApiEvent(
                                                        /// add this
                                                        branchPartyId:
                                                            branchCode,

                                                        /// addd this
                                                        surveyorPartyId: userId,
                                                        productType:
                                                            producttextcontoller
                                                                .text,
                                                        productCategory:
                                                            vehiclecategorytextcontoller
                                                                .text,
                                                        vehicleType:
                                                            vehicleTypetextcontoller
                                                                .text,
                                                        registrationFormat: widget
                                                                .ownflow
                                                            ? ""
                                                            : registrationnumberformattextcontoller
                                                                .text,
                                                        registrationNo:
                                                            "${r1textcontoller.text.trim()}-${r2textcontoller.text.trim()}-${r3textcontoller.text.trim()}-${r4textcontoller.text.trim()}",
                                                        engineNo:
                                                            enginenumbertextcontoller
                                                                .text,
                                                        chassisNo:
                                                            chassisnumbertextcontoller
                                                                .text,
                                                        make: maketextcontoller
                                                            .text,
                                                        model:
                                                            modeltextcontoller
                                                                .text,
                                                        yearOfManufacturing:
                                                            yearofmanuftextcontoller
                                                                .text,
                                                        fueltype:
                                                            fueltypetextcontoller
                                                                .text,
                                                        inspectionLocation:
                                                            inspectionlocationtextcontoller
                                                                .text,
                                                        contactPerson:
                                                            contactpersontextcontoller
                                                                .text,
                                                        contactMobileNo:
                                                            contactmobienumbertextcontoller
                                                                .text,
                                                        insuredName:
                                                            insurednametextcontoller
                                                                .text,
                                                        piPurpose:
                                                            pipurposetextcontoller
                                                                .text,
                                                        endorsementType:
                                                            endoresementtypetextcontoller
                                                                .text,
                                                        policyNo:
                                                            policynumbertextcontoller
                                                                .text,
                                                        ncbPercentage:
                                                            ncbtextcontoller
                                                                .text,
                                                        contactNoforSms:
                                                            contactnoforsmstextcontoller
                                                                .text,
                                                        intimationRemarks: widget
                                                                .ownflow
                                                            ? "SELF PI"
                                                            : intimationstatustextcontoller
                                                                .text,

                                                        /// add this
                                                        userPartyId: userId,
                                                        sourceFrom:
                                                            "I-Nova", // TODO ASK
                                                        /// add this
                                                        loginId: userMailId,
                                                        idvofvehicle:
                                                            idvtextcontoller
                                                                .text,
                                                        proposalType:
                                                            proposaltypetextcontoller
                                                                .text,
                                                        sgicPolicyNumber:
                                                            sgicpolicynumbertextcontoller
                                                                .text,
                                                        engineprotectorcover:
                                                            epcrtextcontoller
                                                                .text,
                                                        contactnoToSendlink:
                                                            selfpitextcontoller
                                                                .text,
                                                        gvw: gvwtextcontoller
                                                            .text,
                                                        seatingcapacity:
                                                            seatingCapcitytextcontoller
                                                                .text,

                                                        /// add this
                                                        requestPifilesuploadObj: [],
                                                        attachmentId:
                                                            "", // TODO ASK
                                                        preInspectionId:
                                                            "", // TODO ASK
                                                        title:
                                                            prefixtextcontoller
                                                                .text,
                                                        odometerReading:
                                                            odometertextcontoller
                                                                .text,
                                                        agencyStatus:
                                                            preinspectionstatustextcontoller
                                                                .text, // TODO ASK ///add this
                                                        rcVerified: widget
                                                                .ownflow
                                                            ? rcverifiedtextcontoller
                                                                        .text ==
                                                                    "Yes"
                                                                ? "1"
                                                                : "0"
                                                            : "",
                                                        surveyorRemark:
                                                            surveyorremarkstextcontoller
                                                                .text,
                                                        vehRunningCondition: widget
                                                                .ownflow
                                                            ? vehiclerunningconditiontextcontoller
                                                                        .text ==
                                                                    "Yes"
                                                                ? "Y"
                                                                : "N"
                                                            : "",
                                                        piFeesAmount:
                                                            pifeeamounttextcontoller
                                                                .text,
                                                        conveyanceAmount:
                                                            conveyanceamounttextcontoller
                                                                .text,
                                                        modeofPayment:
                                                            modeofpaymenttextcontoller
                                                                .text,
                                                        referenceNumber:
                                                            "", // TODO ASK
                                                        piFeesCollected:
                                                            pifeecollectedtextcontoller
                                                                .text,
                                                        branch:
                                                            branchnametextcontoller
                                                                .text,
                                                      ));
                                                  // provider.ifelsecondigtionforsubmit(
                                                  //     widget.ownpi,
                                                  //     widget
                                                  //         .otherpi,
                                                  //     widget
                                                  //         .ishitapi,
                                                  //     context);
                                                },
                                                child: const Text("Submit")),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: (context.read<PIDetailBloc>().isPiSubmitted &&
                        !widget.otherflow) ||
                    widget.hitapiflow
                ? FloatingActionButton(
                    onPressed: () {
                      debugPrint(preInspectionId);
                      context.read<PIDetailBloc>().add(
                          NavigateToNcxtScreenEvent(
                              preInspectionId: preInspectionId,
                              context: context));
                    },
                    child: const Icon(Icons.image),
                  )
                : const SizedBox(),
          ),
        );
      }),
    );
  }
}
