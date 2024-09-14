import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/preinspection/preinspection_bloc.dart';
import '../../bloc/preinspection/preinspection_event.dart';
import '../../bloc/preinspection/preinspection_state.dart';
import '../../utils/constant.dart';
import '../../utils/widgets/bottom_button_widget.dart';
import '../signature/signature_screen.dart';
import 'speeddail/preinspection_speed_dail.dart';

class PreInspectionScreen extends StatefulWidget {
  final String preInspectionId;
  const PreInspectionScreen({super.key, required this.preInspectionId});

  @override
  State<PreInspectionScreen> createState() => _PreInspectionScreenState();
}

class _PreInspectionScreenState extends State<PreInspectionScreen>
    with TickerProviderStateMixin {
  static List<String> tabDetails = [];
  static PageController pageController = PageController(initialPage: 0);
  static TabController? tabController;
  String? tabName;
  List<bool> isImageUploaded = [];
  List<String> imageUrl = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreInspectionBloc(this),
      child: BlocConsumer<PreInspectionBloc, PreInspectionState>(
          listener: (context, state) async {
        if (state is PreInspectionImageSuccessState) {
          tabName = state.tabDetails.first.split(":").first;
          tabDetails = state.tabDetails;
          pageController = state.pageController;
          tabController = state.tabController;
          isImageUploaded = List.filled(tabDetails.length, false);
          imageUrl = List.filled(tabDetails.length, "");
        } else if (state is NextPageState) {
          tabController!.index = state.index;
          tabName = state.tabName;
          pageController.jumpToPage(tabController!.index);
        } else if (state is ShrigenUploadApiState) {
          debugPrint(state.imageURl);
          isImageUploaded[tabController!.index] = true;
          imageUrl[tabController!.index] = state.imageURl;
        } else if (state is FileUploadedSuccessfully) {
          debugPrint("FileUploadedSuccessfully");
          context.read<PreInspectionBloc>().add(ShrigenUploadApiEvent(
              referenceValue: state.referenceValue,
              docType: state.docType,
              docId: state.docId,
              userId: state.userId,
              branch: state.branch,
              fileName: state.fileName,
              base64Image: state.base64Image));
        } else if (state is SelectDocIdState) {
          context.read<PreInspectionBloc>().add(TakePhotEvent(
                imageType: state.imageType,
                referenceValue: '',
                docType: state.tabType,
                docId: '',
                userId: '',
                branch: '',
                fileName: '',
                base64Image: '',
              ));
        } else if (state is PreInspectionFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, builder: (context, state) {
        if (state is PreInspectionInitialState) {
          debugPrint("Init");
        }

        return OverlayLoaderWithAppIcon(
          appIconSize: 60,
          circularProgressColor: Colors.transparent,
          overlayBackgroundColor: Colors.black87,
          isLoading: state is PreInspectionLoadingState,
          appIcon: Image.asset(
            'assest/loadgif.gif',
          ),
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: appcolor,
                title: const Text('PreInspection'),
                centerTitle: true),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultTabController(
                    length: tabDetails.length,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 40.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 10),
                        child: IgnorePointer(
                          ignoring: false,
                          child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            indicatorColor: Colors.black,
                            labelColor: Colors.black,
                            onTap: (value) {
                              context.read<PreInspectionBloc>().add(
                                  UpdateTabIndexEvent(
                                      value, tabDetails[value].split(":")[0]));
                            },
                            labelStyle: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                                letterSpacing: 1),
                            unselectedLabelColor: Colors.black26,
                            tabs: List<Widget>.generate(tabDetails.length,
                                (int index) {
                              return Tab(
                                child: Text(
                                  tabDetails[index].split(":")[0],
                                  style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 11,
                                      letterSpacing: 0.5),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.23,
                    child: PageView.builder(
                      itemCount: tabDetails.length,
                      controller: pageController,
                      onPageChanged: (value) {
                        context.read<PreInspectionBloc>().add(
                            UpdateTabIndexEvent(
                                value, tabDetails[value].split(":")[0]));
                      },
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return tabDetails[itemIndex].split(":")[0] ==
                                "VIDEO RECORDING"
                            ? Image.asset(
                                'assest/addvideo.png',
                                width: MediaQuery.of(context).size.width * 1.5,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.contain,
                              )
                            : tabDetails[itemIndex].split(":")[0] == "SIGNATURE"
                                ? SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Text(
                                            'Declaration: \n I/we hereby declare that I have carried out inspection of the proposed vehicle in the presence of proposer / authorized representative; attached images, videos, data, reports belong to current date/time and there is no manipulation in the vehicle detail.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Insured Signature",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Image.memory(
                                                base64Decode(
                                                    tabDetails[itemIndex]
                                                        .split(":")[1]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    3.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10),
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        // Open Signature Screen and wait for the result
                                                        dynamic signatureImage =
                                                            await Navigator
                                                                .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SignatureScreen(
                                                              title:
                                                                  "Signature",
                                                              image64:
                                                                  (signature) {
                                                                print(
                                                                    "Signature captured!");
                                                              },
                                                            ),
                                                          ),
                                                        );

                                                        if (signatureImage !=
                                                            null) {
                                                          // Handle the returned signature image
                                                          print(
                                                              "Signature received!");
                                                          // You can now use the signatureImage, e.g., display it or send to an API.
                                                        }
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.add_sharp,
                                                            color: Colors.black,
                                                            size: 30,
                                                          ),
                                                          Text("Add Sign")
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Divider(
                                            thickness: 1,
                                            color:
                                                Colors.black.withOpacity(.40),
                                          ),
                                        ),
                                        const Text(
                                          "Agent/Broker/Excutive Signature",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Image.memory(
                                                base64Decode(
                                                    tabDetails[itemIndex]
                                                        .split(":")[1]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    3.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    child: const Row(children: [
                                                      Icon(
                                                        Icons.add_sharp,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                      Text("Add Sign")
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        )
                                      ],
                                    ),
                                  )
                                : isImageUploaded.isEmpty
                                    ? null
                                    : isImageUploaded[tabController!.index]
                                        ? Image.network(
                                            imageUrl[tabController!.index],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                          )
                                        : Image.memory(
                                            base64Decode(tabDetails[itemIndex]
                                                .split(":")[1]),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: tabName == "SIGNATURE"
                ? const SizedBox()
                : PreInspectionFabWidget(tabType: tabName ?? ""),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(
                  bottom: 0.0, left: 20.0, right: 20.0, top: 0.0),
              child: BottomButton(
                bottonTitle: 'NEXT',
                backgroundColor: Colors.white.withOpacity(0.85),
                titleColor: Colors.black,
                borderColor: Colors.black.withOpacity(.85),
                onTap: () async {
                  debugPrint(isImageUploaded.length.toString());
                  tabName == "SIGNATURE"
                      ? null
                      : tabController!.animateTo((tabController!.index + 1));
                  pageController.jumpToPage(tabController!.index);
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
