import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_signature/signature.dart';

import '../../bloc/signature/signature_bloc.dart';
import '../../bloc/signature/signature_event.dart';
import '../../bloc/signature/signature_state.dart';

typedef ImageCallback = void Function(dynamic val);

class SignatureScreen extends StatelessWidget {
  final ImageCallback image64;
  final String title;
  final HandSignatureControl control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  SignatureScreen({super.key, required this.title, required this.image64});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignatureBloc(control),
      child: BlocConsumer<SignatureBloc, SignatureState>(
        listener: (context, state) {
          if (state is SignatureClearedState) {
            control.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Container(
                        constraints: const BoxConstraints.expand(),
                        color: const Color.fromARGB(255, 248, 245, 245),
                        child: HandSignature(
                          control: control,
                          type: SignatureDrawType.shape,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<SignatureBloc>()
                              .add(ClearSignatureEvent());
                        },
                        child: const Text('Clear'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<SignatureBloc>()
                              .add(SaveSignatureEvent());
                        },
                        child: const Text('Save Signature'),
                      ),
                    ],
                  ),
                  BlocListener<SignatureBloc, SignatureState>(
                    listener: (context, state) {
                      if (state is SignatureSavedState) {
                        // Pass the saved image back through the callback
                        image64(state.signatureImage);
                        Navigator.pop(context, state.signatureImage);
                      }
                      if (state is SignatureSavingErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    child: Container(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
