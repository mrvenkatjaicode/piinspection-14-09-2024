import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitialState extends VideoState {}

class VideoRecordingState extends VideoState {
  final CameraController controller;

  const VideoRecordingState(this.controller);

  @override
  List<Object> get props => [controller];
}

class VideoRecordedState extends VideoState {
  final XFile videoFile;

  const VideoRecordedState(this.videoFile);

  @override
  List<Object> get props => [videoFile];
}
