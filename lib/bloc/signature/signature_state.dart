import 'package:equatable/equatable.dart';
import 'dart:typed_data';

abstract class SignatureState extends Equatable {
  const SignatureState();

  @override
  List<Object?> get props => [];
}

class SignatureInitialState extends SignatureState {}

class SignatureClearedState extends SignatureState {}

class SignatureSavedState extends SignatureState {
  final Uint8List signatureImage;

  const SignatureSavedState(this.signatureImage);

  @override
  List<Object?> get props => [signatureImage];
}

class SignatureSavingErrorState extends SignatureState {
  final String error;

  const SignatureSavingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
