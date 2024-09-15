import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mnovapi/bloc/preinspection/preinspection_event.dart';

import '../../../bloc/preinspection/preinspection_bloc.dart';

class PreInspectionFabWidget extends StatefulWidget {
  final String tabType;
  const PreInspectionFabWidget({super.key, required this.tabType});
  @override
  State<PreInspectionFabWidget> createState() => _PreInspectionFabWidgetState();
}

class _PreInspectionFabWidgetState extends State<PreInspectionFabWidget> {
  void showAlertDialogWidget() {
    showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(letterSpacing: 1),
          ),
          content: const Text(
            'Please keep your vehicle started and capture the VIDEO..!',
            style: TextStyle(letterSpacing: 0.5),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(letterSpacing: 1, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final preInspectionBloc = BlocProvider.of<PreInspectionBloc>(context);

    return SpeedDial(
      icon: Icons.add,
      label: const Text(
        "ADD",
        style: TextStyle(color: Colors.black),
      ),
      activeIcon: Icons.close,
      buttonSize: const Size(56, 56),
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        if (widget.tabType == "VIDEO RECORDING")
          SpeedDialChild(
            child: const Icon(Icons.videocam_rounded),
            foregroundColor: const Color(0xFF000000),
            label: 'Take Video',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              showAlertDialogWidget();
            },
          ),
        if (widget.tabType == "MORE")
          SpeedDialChild(
            child: const Icon(Icons.image),
            foregroundColor: const Color(0xFF000000),
            label: 'From Gallery',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              preInspectionBloc.add(SelectDocIdEvent(
                  title: widget.tabType, imageType: "Gallery"));
            },
          ),
        if (widget.tabType == "MORE")
          SpeedDialChild(
            child: const Icon(Icons.edit_document),
            foregroundColor: const Color(0xFF000000),
            label: 'From Docs & Pdf',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
               preInspectionBloc.add(
                  SelectDocIdEvent(title: widget.tabType, imageType: "Doc"));
             // preInspectionBloc.add(TakeDocumentEvent());
            },
          ),
        if (widget.tabType != "VIDEO RECORDING")
          SpeedDialChild(
            child: const Icon(Icons.camera),
            foregroundColor: const Color(0xFF000000),
            label: 'Take Photo',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              preInspectionBloc.add(
                  SelectDocIdEvent(title: widget.tabType, imageType: "Camera"));
            },
          ),
      ],
    );
  }
}
