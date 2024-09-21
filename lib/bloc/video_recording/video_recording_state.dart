import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class LoadingCameraState extends VideoState {}

class InitializedCameraState extends VideoState {
  final CameraController controller;

  const InitializedCameraState(this.controller);

  @override
  List<Object> get props => [controller];
}

class VideoInitialState extends VideoState {}

class VideoRecordingState extends VideoState {
  final CameraController controller;
  final bool? isshowStartRecording;

  const VideoRecordingState(this.controller, this.isshowStartRecording);

  @override
  List<Object> get props => [controller];
}

class VideoRecordedState extends VideoState {
  final XFile videoFile;
 final bool? isshowStartRecording;
  const VideoRecordedState(this.videoFile, this.isshowStartRecording);

  @override
  List<Object> get props => [videoFile];
}
