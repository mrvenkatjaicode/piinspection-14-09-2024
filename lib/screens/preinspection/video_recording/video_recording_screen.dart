import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:mnovapi/bloc/preinspection/preinspection_state.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_bloc.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_event.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_state.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class VideoRecordingScreen extends StatelessWidget {
  VideoRecordingScreen({super.key});

  CameraController? cameraController;
  bool showStartRecording = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoBloc(),
      child: BlocConsumer<VideoBloc, VideoState>(
        listener: (context, state) {
          if (state is VideoRecordingState) {
            showStartRecording = state.isshowStartRecording!;
          } else if (state is VideoRecordedState) {
            showStartRecording = state.isshowStartRecording!;
          }
        },
        builder: (context, state) {
          if (state is VideoInitialState) {
            context.read<VideoBloc>().add(InitializeCameraEvent());
            /* return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<VideoBloc>().add(StartRecordingEvent());
                          },
                          child: const Text("Start Recording"),
                        ),
                      ); */
          }
          if (state is InitializedCameraState) {
            cameraController = state.controller;
          }
          if (state is VideoRecordingState) {
            /*  return Stack(
                        children: [
                          CameraPreview(state.controller),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<VideoBloc>().add(StopRecordingEvent());
                              },
                              child: const Text("Stop Recording"),
                            ),
                          ),
                        ],
                      ); */
          }
          if (state is VideoRecordedState) {
            showStartRecording = !showStartRecording;

            /*  return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Video Recorded: ${state.videoFile.path}"),
                            ElevatedButton(
                              onPressed: () {
                                context.read<VideoBloc>().add(ResetRecordingEvent());
                              },
                              child: const Text("Record Again"),
                            ),
                          ],
                        ),
                      ); */
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: cameraController == null,
            appIcon: Image.asset(
              'assest/loadgif.gif',
            ),
            child: Scaffold(
              appBar: AppBar(title: const Text("Record Video")),
              body: Stack(
                children: [
                  cameraController == null
                      ? const Center(child: CircularProgressIndicator())
                      : CameraPreview(cameraController!),
                  showStartRecording
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint("ONPRESSED *************");
                              context.read<VideoBloc>().add(StartRecordingEvent(
                                  context: context,
                                  isshowStartRecording: !showStartRecording));
                            },
                            child: const Text("Start Recording"),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<VideoBloc>().add(StopRecordingEvent(
                                  context: context,
                                  isshowStartRecording: !showStartRecording));
                            },
                            child: const Text("Stop Recording"),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
