import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'signature_event.dart';
import 'signature_state.dart';
import 'package:flutter/services.dart';
import 'package:hand_signature/signature.dart';

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  final HandSignatureControl control;

  SignatureBloc(this.control) : super(SignatureInitialState()) {
    on<ClearSignatureEvent>(_onClearSignature);
    on<SaveSignatureEvent>(_onSaveSignature);
  }

  void _onClearSignature(
      ClearSignatureEvent event, Emitter<SignatureState> emit) {
    control.clear();
    emit(SignatureClearedState());
  }

  Future<void> _onSaveSignature(
      SaveSignatureEvent event, Emitter<SignatureState> emit) async {
    try {
      final ByteData? rawImage = await control.toImage(
        color: Colors.black,
        background: Colors.white,
        fit: true,
      );

      if (rawImage != null) {
        Uint8List imageBytes = rawImage.buffer.asUint8List();
        emit(SignatureSavedState(imageBytes));
      } else {
        emit(const SignatureSavingErrorState('Failed to save signature'));
      }
    } catch (e) {
      emit(SignatureSavingErrorState(e.toString()));
    }
  }
}
