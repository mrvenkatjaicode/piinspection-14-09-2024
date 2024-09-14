import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';
import '../../models/dashboard/pi_dashboard_model.dart';
import '../../utils/constant.dart';
import '../../utils/widgets/speed_dail_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static List<PiDetail>? dashboardList = [];
  static ScrollController controller = ScrollController();
  static int pagecount = 1;
  static String partyId = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardBloc(),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              partyId = state.partyId;
              context.read<DashboardBloc>().add(PIDashboardDetailsEvent(
                  userPartyId: state.partyId,
                  pagination: pagecount,
                  list: 10,
                  searchType: '',
                  searchValue: ''));
            } else if (state is DashboardPISuccessState) {
              dashboardList = state.dashboardList;
            } /* else if (state is NavigateToPIDetailScreenState) {
              
            } */
          },
          builder: (context, state) {
            controller.addListener(
              () {
                if (controller.position.atEdge) {
                  bool isTop = controller.position.pixels == 0;
                  if (isTop) {
                    debugPrint('At the top');
                  } else {
                    pagecount++;
                    context.read<DashboardBloc>().add(PIDashboardDetailsEvent(
                        userPartyId: partyId,
                        pagination: pagecount,
                        list: 10,
                        searchType: '',
                        searchValue: ''));
                  }
                }
              },
            );

            if (state is DashboardInitial) {
              context.read<DashboardBloc>().add(const LoginApiEvent(
                  userId: "abhinaw.sgi@gmail.com", password: "cherry123"));
            }
            return OverlayLoaderWithAppIcon(
              appIconSize: 60,
              circularProgressColor: Colors.transparent,
              overlayBackgroundColor: Colors.black87,
              isLoading: state is DashboardLoadingState,
              appIcon: Image.asset(
                'assest/loadgif.gif',
              ),
              child: Scaffold(
                appBar: AppBar(title: const Text('Dashboard')),
                body: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: dashboardList!
                      .length /*  snapshot.data!.length +
                                      (provider.isLoading ? 1 : 0) */
                  ,
                  itemBuilder: (context, index) {
                    if (index < dashboardList!.length) {
                      return GestureDetector(
                        onTap: () {
                          if (dashboardList![index].currentStatus.toString() ==
                              "Cancel By HO") {
                            showDialog(
                              context: context,
                              builder: (alertDialogContext) =>
                                  const AlertDialog(
                                content: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                        child: Text(
                                      "Canceled by HO.",
                                      style: TextStyle(color: Colors.red),
                                    ))),
                              ),
                            );
                          } else {
                            preInspectionId =
                                dashboardList![index].preinspectionId ?? "";
                            FocusScope.of(context).unfocus();
                            context.read<DashboardBloc>().add(
                                NavigateToPIDetailScreenEvent(
                                    preInspectionId: dashboardList![index]
                                        .preinspectionId
                                        .toString(),
                                    isHitApi: true,
                                    context: context));
                            /* snapshot.data![index].currentStatus
                                                            .toString() ==
                                                        "Survey On Hold" ||
                                                    snapshot.data![index]
                                                            .currentStatus
                                                            .toString() ==
                                                        "Report Pending"
                                                ? /* position == null
                                                    ? */
                                                await Provider.of<
                                                            DashboardScreenNotifier>(
                                                        context,
                                                        listen: false)
                                                    .fetchlocation(context)
                                                //: null
                                                : null; */
                            // provider.preinspectionid = snapshot
                            //     .data![index].preinspectionId
                            //     .toString();
                            // provider.productcode = snapshot
                            //     .data![index].productCode;
                            // navigatetotherscreen(
                            //     snapshot.data![index]
                            //         .preinspectionId
                            //         .toString(),
                            //     snapshot
                            //         .data![index].currentStatus
                            //         .toString(),
                            //     snapshot
                            //         .data![index].currentStatus
                            //         .toString());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      // width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          dashboardList![index].productCode ==
                                                  "MOT-PRD-001"
                                              ? "assest/caricon.png"
                                              : dashboardList![index]
                                                          .productCode ==
                                                      "MOT-PRD-002"
                                                  ? "assest/bikeicon.png"
                                                  : dashboardList![index]
                                                              .productCode ==
                                                          "MOT-PRD-003"
                                                      ? "assest/gccvicon.png"
                                                      : dashboardList![index]
                                                                  .productCode ==
                                                              "MOT-PRD-005"
                                                          ? "assest/pccvbusicon.png"
                                                          : dashboardList![
                                                                          index]
                                                                      .productCode ==
                                                                  "MOT-PRD-004"
                                                              ? "assest/pccvbusicon.png"
                                                              : "assest/miscdicon.png",
                                          color: dashboardList![index]
                                                      .productCode ==
                                                  "MOT-PRD-006"
                                              ? appcolor
                                              : null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    dashboardList![index]
                                                        .insuredName
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Text(dashboardList![index]
                                                  .preinspectionId
                                                  .toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                    size: 12,
                                                  ),
                                                  Text(dashboardList![index]
                                                      .date
                                                      .toString()
                                                      .split(" ")
                                                      .first),
                                                ],
                                              ),
                                              Text(dashboardList![index]
                                                  .regNumber
                                                  .toString()
                                                  .toUpperCase()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dashboardList![index]
                                                    .currentStatus
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  color: dashboardList![index]
                                                                  .currentStatus
                                                                  .toString() ==
                                                              "Report Pending" ||
                                                          dashboardList![index]
                                                                  .currentStatus
                                                                  .toString() ==
                                                              "Request Assign to Surveyor"
                                                      ? Colors.orange
                                                      : dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Report Submitted" ||
                                                              dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Survey Report Approved"
                                                          ? Colors.green
                                                          : dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Survey On Hold"
                                                              ? appcolor
                                                              : dashboardList![index].currentStatus.toString() == "Cancel By HO" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Survey Report Rejected" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Intimation canceled by HO" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Intimation Rejected"
                                                                  ? Colors.red
                                                                  : Colors.black,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                    color: whitecolor),
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 22,
                                                  color: dashboardList![index]
                                                                  .currentStatus
                                                                  .toString() ==
                                                              "Report Pending" ||
                                                          dashboardList![index]
                                                                  .currentStatus
                                                                  .toString() ==
                                                              "Request Assign to Surveyor"
                                                      ? Colors.orange
                                                      : dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Report Submitted" ||
                                                              dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Survey Report Approved"
                                                          ? Colors.green
                                                          : dashboardList![index]
                                                                      .currentStatus
                                                                      .toString() ==
                                                                  "Survey On Hold"
                                                              ? appcolor
                                                              : dashboardList![index].currentStatus.toString() == "Cancel By HO" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Survey Report Rejected" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Intimation canceled by HO" ||
                                                                      dashboardList![index]
                                                                              .currentStatus
                                                                              .toString() ==
                                                                          "Intimation Rejected"
                                                                  ? Colors.red
                                                                  : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                floatingActionButton: const SpeedDailFabWidget(),
              ),
            );
          },
        ));
  }
}
