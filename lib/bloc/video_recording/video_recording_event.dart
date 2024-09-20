import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class StartRecordingEvent extends VideoEvent {}

class StopRecordingEvent extends VideoEvent {}

class ResetRecordingEvent extends VideoEvent {}
