import 'package:equatable/equatable.dart';

abstract class SignatureEvent extends Equatable {
  const SignatureEvent();

  @override
  List<Object?> get props => [];
}

class ClearSignatureEvent extends SignatureEvent {}

class SaveSignatureEvent extends SignatureEvent {}
