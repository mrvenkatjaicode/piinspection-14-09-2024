import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends VideoEvent {}

class StartRecordingEvent extends VideoEvent {
  final BuildContext context;
  final bool isshowStartRecording;

  const StartRecordingEvent({required this.context, required this.isshowStartRecording});
}

class StopRecordingEvent extends VideoEvent {
  final BuildContext context;
  final bool isshowStartRecording;

  const StopRecordingEvent({required this.context, required this.isshowStartRecording});
}

class ResetRecordingEvent extends VideoEvent {}
