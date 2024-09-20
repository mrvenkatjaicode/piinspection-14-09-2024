import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_event.dart';
import 'package:mnovapi/bloc/video_recording/video_recording_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  CameraController? _cameraController;
  late Timer _timer;

  VideoBloc() : super(VideoInitialState()) {
    on<StartRecordingEvent>(_onStartRecording);
    on<StopRecordingEvent>(_onStopRecording);
    on<ResetRecordingEvent>(_onResetRecording);
  }

  Future<void> _onStartRecording(
      StartRecordingEvent event, Emitter<VideoState> emit) async {
    if (_cameraController == null) {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController!.initialize();
    }

    final directory = await getTemporaryDirectory();
    final videoPath = path.join(directory.path, '${DateTime.now()}.mp4');

    _cameraController!.startVideoRecording();

    emit(VideoRecordingState(_cameraController!));

    _timer = Timer(const Duration(seconds: 60), () {
      add(StopRecordingEvent());
    });
  }

  Future<void> _onStopRecording(
      StopRecordingEvent event, Emitter<VideoState> emit) async {
    if (_cameraController != null &&
        _cameraController!.value.isRecordingVideo) {
      final videoFile = await _cameraController!.stopVideoRecording();
      _timer.cancel();
      emit(VideoRecordedState(videoFile));
    }
  }

  Future<void> _onResetRecording(
      ResetRecordingEvent event, Emitter<VideoState> emit) async {
    emit(VideoInitialState());
  }

  @override
  Future<void> close() {
    _cameraController?.dispose();
    _timer.cancel();
    return super.close();
  }
}
