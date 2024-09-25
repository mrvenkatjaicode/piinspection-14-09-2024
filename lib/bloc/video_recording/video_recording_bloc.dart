import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_event.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  CameraController? _cameraController;
  Timer? _timer;

  VideoBloc() : super(VideoInitialState()) {
    on<InitializeCameraEvent>(_onInitializingCamera);
    on<StartRecordingEvent>(startVideoRecording);
    on<StopRecordingEvent>(_onStopRecording);
    on<ResetRecordingEvent>(_onResetRecording);
  }

  Future<void> _onInitializingCamera(
      InitializeCameraEvent event, Emitter<VideoState> emit) async {
    emit(LoadingCameraState());
    if (_cameraController == null) {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController!.initialize();
    }

    final directory = await getTemporaryDirectory();
    final videoPath = path.join(directory.path, '${DateTime.now()}.mp4');

    //_cameraController!.startVideoRecording();

    emit(InitializedCameraState(_cameraController!));
  }

  startVideoRecording(StartRecordingEvent event, Emitter<VideoState> emit) {
    emit(LoadingCameraState());
    _cameraController!.startVideoRecording();
    emit(VideoRecordingState(_cameraController!, event.isshowStartRecording));
    _timer = Timer(const Duration(seconds: 5), () {
      add(StopRecordingEvent(
          context: event.context,
          isshowStartRecording: event.isshowStartRecording));
    });
  }

  Future<void> _onStopRecording(
      StopRecordingEvent event, Emitter<VideoState> emit) async {
    emit(LoadingCameraState());
    if (_cameraController != null &&
        _cameraController!.value.isRecordingVideo) {
      final videoFile = await _cameraController!.stopVideoRecording();
      _timer!.cancel();
      Navigator.pop(event.context, videoFile);
      emit(VideoRecordedState(videoFile, event.isshowStartRecording));
    }
  }

  Future<void> _onResetRecording(
      ResetRecordingEvent event, Emitter<VideoState> emit) async {
    emit(LoadingCameraState());
    emit(VideoInitialState());
  }

  @override
  Future<void> close() {
    _cameraController?.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    return super.close();
  }
}
