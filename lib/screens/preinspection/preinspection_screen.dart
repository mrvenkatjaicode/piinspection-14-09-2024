import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/preinspection/preinspection_bloc.dart';
import '../../bloc/preinspection/preinspection_event.dart';
import '../../bloc/preinspection/preinspection_state.dart';
import '../../utils/constant.dart';
import '../../utils/widgets/bottom_button_widget.dart';
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
  static List<Tuple2<String?, String?>?> morelist = [];
  static List<Tuple2<String?, String?>?> signlist = [];

  static PageController pageController = PageController(initialPage: 0);
  static TabController? tabController;
  String? tabName;
  List<bool> isImageUploaded = [];
  List<String> imageUrl = [];
  List<Tuple2<String?, String?>?> tabNameList = [];
  List<bool> isImageAvilable = [];
  List<Tuple3<String?, String?, String?>?> commonStrings = [];

  static String videoPath = "";
  static bool isDone = false;
  static String fileUniqueName = "";

  Widget _buildMoreContent(String data, bool existsInTabData) {
    if (commonStrings.isNotEmpty &&
        existsInTabData &&
        commonStrings.length > tabController!.index) {}
    return morelist.isEmpty
        ? Image.memory(
            base64Decode(data),
            width: MediaQuery.of(context).size.width * 3.5,
            height: MediaQuery.of(context).size.height / 2,
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: morelist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: null,
                  leading: morelist[index]!.item2 == "pdf"
                      ? const Icon(Icons.picture_as_pdf)
                      : Image.network(
                          morelist[index]!.item1 ?? "",
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Text("Image Not Found"),
                            );
                          },
                        ),
                );
              },
            ),
          );
  }

  Widget _buildVideoRecordingContent(bool existsInTabData) {
    if (commonStrings.isNotEmpty && existsInTabData /*  && */
        /* commonStrings.length > tabController!.index */ /* tabController!
                .index >=
            commonStrings.length */
        ) {
      for (int i = 0; i < commonStrings.length; i++) {
        if (tabName == commonStrings[i]!.item1) {
          // If tabName matches item1, return the network image
          return InkWell(
            onTap: () {
              debugPrint(commonStrings[i]!.item2 ?? "");
              launchUrl(Uri.parse(commonStrings[i]!.item2 ?? ""),
                  mode: LaunchMode.externalApplication);
              //  OpenFilex.open(videoPath);
              debugPrint(videoPath);
            },
            child: Image.asset(
              'assest/playvideo.png',
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            ),
          );
        }
      }
      return Image.asset(
        'assest/addvideo.png',
        width: MediaQuery.of(context).size.width * 1.5,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.contain,
      );
    } else if (isImageUploaded.isNotEmpty &&
        isImageUploaded[tabController!.index]) {
      return InkWell(
        onTap: () {
          debugPrint(imageUrl[tabController!.index]);
          launchUrl(Uri.parse(imageUrl[tabController!.index]),
              mode: LaunchMode.externalApplication);
          //  OpenFilex.open(videoPath);
          debugPrint(videoPath);
        },
        child: Image.asset(
          'assest/playvideo.png',
          width: MediaQuery.of(context).size.width * 1.5,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Image.asset(
        'assest/addvideo.png',
        width: MediaQuery.of(context).size.width * 1.5,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.contain,
      );
    }
  }

  Widget _buildSignatureContent(
      String data, bool existsInTabData, preInspectionBloc) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Declaration: \n I/we hereby declare that I have carried out inspection of the proposed vehicle in the presence of proposer / authorized representative; attached images, videos, data, reports belong to current date/time and there is no manipulation in the vehicle detail.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                decoration: TextDecoration.underline,
                fontSize: 14,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Insured Signature",
            style: TextStyle(
              fontFamily: 'Poppins',
              decoration: TextDecoration.underline,
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          signlist.isEmpty
              ? _buildSignatureSection(
                  "", data, "Add Sign", preInspectionBloc, "INSign")
              : _buildSignatureSection(signlist[0]!.item1 ?? "", data,
                  "Add Sign", preInspectionBloc, "INSign"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              thickness: 1,
              color: Colors.black.withOpacity(.40),
            ),
          ),
          const Text(
            "Agent/Broker/Executive Signature",
            style: TextStyle(
              fontFamily: 'Poppins',
              decoration: TextDecoration.underline,
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          signlist.isEmpty || signlist.length < 2
              ? _buildSignatureSection(
                  "", data, "Add Sign", preInspectionBloc, "ABE Sign")
              : _buildSignatureSection(signlist[1]!.item1 ?? "", data,
                  "Add Sign", preInspectionBloc, "ABE Sign"),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSignatureSection(
      String url, String data, String buttonText, preInspectionBloc, signType) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: url == ""
              ? Image.memory(
                  base64Decode(data),
                  width: MediaQuery.of(context).size.width * 3.5,
                  height: MediaQuery.of(context).size.height / 5,
                )
              : Image.network(
                  url,
                  width: MediaQuery.of(context).size.width * 3.5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  preInspectionBloc.add(NavigateToSignScreenEvent(
                      context: context, signType: signType));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(buttonText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDefaultContent(int itemIndex, bool existsInTabData) {
    // Check if commonStrings is not empty, existsInTabData is true,
    // and itemIndex is within bounds
    if (commonStrings.isNotEmpty &&
        existsInTabData &&
        isImageAvilable[tabController!.index] &&
        itemIndex <= commonStrings.length &&
        tabController!.index <= commonStrings.length) {
      // Iterate over commonStrings
      for (int i = 0; i < commonStrings.length; i++) {
        if (tabName == commonStrings[i]!.item1) {
          // If tabName matches item1, return the network image
          return _buildImageFromNetwork(commonStrings[i]!.item2 ?? "");
        }
      }
      // If no match is found, return the decoded image from tabDetails
      return Image.memory(
        base64Decode(tabDetails[itemIndex].split(":")[1]),
        width: MediaQuery.of(context).size.width * 3.5,
        height: MediaQuery.of(context).size.height / 2,
      );
    } else if (isImageUploaded.isNotEmpty &&
        isImageAvilable[tabController!.index] &&
        tabController!.index < isImageUploaded.length &&
        isImageUploaded[tabController!.index]) {
      // If an image has been uploaded, return the network image
      return _buildImageFromNetwork(imageUrl[tabController!.index]);
    } else if (itemIndex < tabDetails.length) {
      // Ensure itemIndex is within bounds of tabDetails, then return the decoded image
      return Image.memory(
        base64Decode(tabDetails[itemIndex].split(":")[1]),
        width: MediaQuery.of(context).size.width * 3.5,
        height: MediaQuery.of(context).size.height / 2,
      );
    } else {
      // Return a default placeholder or error widget if all conditions fail
      return const Text("Content not available");
    }
  }

  Widget _buildImageFromNetwork(String url) {
    return Image.network(
      url,
      width: MediaQuery.of(context).size.width * 3.5,
      height: MediaQuery.of(context).size.height / 2,
      fit: BoxFit.fill,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(
          child: Text("Image Not Found"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreInspectionBloc(this),
      child: BlocConsumer<PreInspectionBloc, PreInspectionState>(
          listener: (context, state) async {
        if (state is PreInspectionImageSuccessState) {
          debugPrint("PreInspection");
          tabName = state.tabDetails.first.split(":").first;
          tabDetails = state.tabDetails;
          pageController = state.pageController;
          tabController = state.tabController;
          isImageUploaded = List.filled(tabDetails.length, false);
          isImageAvilable = List.filled(tabDetails.length, false);
          imageUrl = List.filled(tabDetails.length, "");
        } else if (state is FinalSubmitAPIState) {
          Navigator.pop(context);
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.resMsg),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is MoveToDoneState) {
          isDone = state.ismovetodone;
        } else if (state is SignCompletedState) {
          context.read<PreInspectionBloc>().add(
              const SelectDocIdEvent(title: "SIGNATURE", imageType: "Sign"));
        } else if (state is VideoRecordedCompletedState) {
          videoPath = state.videoPath;
          context.read<PreInspectionBloc>().add(const SelectDocIdEvent(
              title: "VIDEO RECORDING", imageType: "Video"));
        } else if (state is GetImageFromApiState) {
          for (int i = 0; i < tabDetails.length; i++) {
            tabNameList.add(Tuple2(tabDetails[i].split(":")[0],
                "" /* tabDetails[i].split(":")[1] */));
            isImageAvilable[i] = true;
          }
          List<Tuple3<String?, String?, String?>?> apiName = [];
          for (int i = 0;
              i < state.getImageResponse.response![0].imageresponse!.length;
              i++) {
            apiName.add(Tuple3(
                state.getImageResponse.response![0].imageresponse![i].tagName!,
                state.getImageResponse.response![0].imageresponse![i].xbizurl!,
                state.getImageResponse.response![0].imageresponse![i]
                    .fileUniqueName!));
            if (state
                    .getImageResponse.response![0].imageresponse![i].tagName! ==
                "MORE") {
              morelist.add(Tuple2(
                  state.getImageResponse.response![0].imageresponse![i].xbizurl,
                  state.getImageResponse.response![0].imageresponse![i]
                      .extension!));
            } /*  else {} */
            if (state
                    .getImageResponse.response![0].imageresponse![i].tagName! ==
                "Signature") {
              signlist.add(Tuple2(
                  state.getImageResponse.response![0].imageresponse![i].xbizurl,
                  state.getImageResponse.response![0].imageresponse![i]
                      .extension!));
            }
          }

          // Iterate over each tuple in tabNameList
          for (var tabTuple in tabNameList) {
            // Ensure the tuple and its first item are not null
            if (tabTuple != null && tabTuple.item1 != null) {
              String? tabName =
                  tabTuple.item1; // Extract the first value (tab name)

              // Check if apiNameList contains a tuple where the first value matches tabName
              var matchingApiTuple = apiName.firstWhere(
                (apiTuple) => apiTuple != null && apiTuple.item1 == tabName,
                orElse: () => null,
              );

              // If a match is found, add the matching tuple to commonStrings
              if (matchingApiTuple != null) {
                commonStrings.add(matchingApiTuple);
              }
            }
          }

          // debugPrint(commonStrings.toString());
        } else if (state is NextPageState) {
          tabController!.index = state.index;
          tabName = state.tabName;
          pageController.jumpToPage(tabController!.index);
        } else if (state is ShrigenUploadApiState) {
          debugPrint(state.imageURl);
          fileUniqueName = state.uniqueFileName;
          isImageUploaded[tabController!.index] = true;
          if (tabName == "MORE") {
            morelist.add(Tuple2(state.imageURl, state.extension));
          } else if (tabName == "SIGNATURE") {
            signlist.add(Tuple2(state.imageURl, state.extension));
          } else {
            imageUrl[tabController!.index] = state.imageURl;
          }
        } else if (state is FileAlreadyUploadedState) {
          fileUniqueName = state.uniqueFileName;
          showDialog(
            context: context,
            builder: (alertDialogContext) => AlertDialog(
              title: const Text("Already Uploaded"),
              content: const SizedBox(
                height: 60,
                width: 60,
                child: Text("Do You want to delete it?"),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    isImageAvilable[tabController!.index] = false;
                    Navigator.pop(context);
                    context.read<PreInspectionBloc>().add(DeleteFileApiEvent(
                        userPartyId: '',
                        userIp: "",
                        preInspectionId: preInspectionId,
                        uniqueFileName: fileUniqueName));
                  },
                  child: const Text("Yes"),
                )
              ],
            ),
          );
        } else if (state is DeleteFileApiState) {
          debugPrint(tabController!.index.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.deleteApiResponse.messageResult!.successMessage ?? ""),
              backgroundColor: Colors.green,
            ),
          );
          // context.read<PreInspectionBloc>().add(GetImageFromApiEvent());
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
          debugPrint(commonStrings.isNotEmpty &&
                  commonStrings.length > tabController!.index &&
                  isImageUploaded.isNotEmpty &&
                  isImageUploaded[tabController!.index]
              ? "***** true"
              : "***** false");
          if (/* commonStrings.isNotEmpty &&
              commonStrings.length > tabController!.index */
              (commonStrings.isNotEmpty &&
                      commonStrings.length > tabController!.index) ||
                  (isImageUploaded.isNotEmpty &&
                      isImageUploaded[tabController!.index])) {
            context.read<PreInspectionBloc>().add(FileAlreadyUploadedEvent(
                uniqueFileName:
                    commonStrings[tabController!.index]!.item3 ?? ""));
          } else {
            state.imageType == "Doc"
                ? context.read<PreInspectionBloc>().add(TakeDocumentEvent(
                      imageType: state.imageType,
                      referenceValue: '',
                      docType: state.tabType,
                      docId: '',
                      userId: '',
                      branch: '',
                      fileName: '',
                      base64Image: '',
                    ))
                : context.read<PreInspectionBloc>().add(TakePhotEvent(
                      imageType: state.imageType,
                      referenceValue: '',
                      docType: state.tabType,
                      docId: '',
                      userId: '',
                      branch: '',
                      fileName: '',
                      base64Image: '',
                    ));
          }
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
          morelist = [];
          signlist = [];
          isDone = false;
          context.read<PreInspectionBloc>().add(GetImageFromApiEvent());
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
                              // debugPrint(
                              //     " ${tabDetails[index].split(":")[0]} - ${isImageAvilable[index].toString()} ");
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
                          final String type =
                              tabDetails[itemIndex].split(":")[0];
                          final String data =
                              tabDetails[itemIndex].split(":")[1];
                          bool existsInTabData = tabNameList.any((tuple) =>
                              tuple != null &&
                              tuple.item1 ==
                                  tabDetails[itemIndex].split(":")[0]);

                          switch (type) {
                            case "MORE":
                              return _buildMoreContent(data, existsInTabData);
                            case "VIDEO RECORDING":
                              return _buildVideoRecordingContent(
                                  existsInTabData);
                            case "SIGNATURE":
                              return _buildSignatureContent(
                                  data,
                                  existsInTabData,
                                  BlocProvider.of<PreInspectionBloc>(context));
                            default:
                              return _buildDefaultContent(
                                  itemIndex, existsInTabData);
                          }
                        }),
                  ),
                ],
              ),
            ),
            floatingActionButton: tabName == "SIGNATURE"
                ? const SizedBox()
                : PreInspectionFabWidget(tabType: tabName ?? ""),
            bottomNavigationBar: isDone
                ? Container(
                    padding: const EdgeInsets.only(
                        bottom: 0.0, left: 20.0, right: 20.0, top: 0.0),
                    child: BottomButton(
                      bottonTitle: 'DONE',
                      backgroundColor: Colors.white.withOpacity(0.85),
                      titleColor: Colors.black,
                      borderColor: Colors.black.withOpacity(.85),
                      onTap: () async {
                        context.read<PreInspectionBloc>().add(
                            FinalSubmitAPIEvent(
                                userPartyId: userId,
                                preInspectionId: preInspectionId));
                      },
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        bottom: 0.0, left: 20.0, right: 20.0, top: 0.0),
                    child: BottomButton(
                      bottonTitle: 'NEXT',
                      backgroundColor: Colors.white.withOpacity(0.85),
                      titleColor: Colors.black,
                      borderColor: Colors.black.withOpacity(.85),
                      onTap: () async {
                        if (tabName == "SIGNATURE") {
                          // if (signlist.length < 2) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Upload Signature"),
                          //       backgroundColor: Colors.red,
                          //     ),
                          //   );
                          // } else {
                          context
                              .read<PreInspectionBloc>()
                              .add(MoveToDoneEvent(ismovetodone: !isDone));
                          //}
                        } else {
                          tabController!.animateTo((tabController!.index + 1));
                          pageController.jumpToPage(tabController!.index);
                        }
                        // debugPrint(isImageUploaded.length.toString());
                        // tabName == "SIGNATURE"
                        //     ? context
                        //         .read<PreInspectionBloc>()
                        //         .add(MoveToDoneEvent(ismovetodone: !isDone))
                        //     : tabController!
                        //         .animateTo((tabController!.index + 1));
                        // pageController.jumpToPage(tabController!.index);
                      },
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
