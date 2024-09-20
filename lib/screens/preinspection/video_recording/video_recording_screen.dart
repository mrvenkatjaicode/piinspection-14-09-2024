import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_bloc.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_event.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_state.dart';

class VideoRecordingScreen extends StatelessWidget {
  const VideoRecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Record Video")),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoInitialState) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<VideoBloc>().add(StartRecordingEvent());
                  },
                  child: const Text("Start Recording"),
                ),
              );
            } else if (state is VideoRecordingState) {
              return Stack(
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
              );
            } else if (state is VideoRecordedState) {
              return Center(
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
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
