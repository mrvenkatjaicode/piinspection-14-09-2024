import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../constant.dart';

class TextFieldPiWidget extends StatefulWidget {
  final bool? ignoring;
  final bool? visible;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final String? labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? inputformat;
  final TextCapitalization? textCapitalization;
  const TextFieldPiWidget(
      {super.key,
      this.ignoring,
      this.visible,
      this.readOnly,
      this.focusNode,
      this.controller,
      this.maxLength,
      this.maxLines,
      this.labelText,
      this.suffixIcon,
      this.keyboardType,
      this.onChanged,
      this.inputformat,
      this.textCapitalization});

  @override
  State<TextFieldPiWidget> createState() => _TextFieldPiWidgetState();
}

class _TextFieldPiWidgetState extends State<TextFieldPiWidget> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.ignoring ?? false,
      child: Visibility(
        visible: widget.visible ?? true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            cursorColor: Colors.black,
            cursorHeight: 20,
            readOnly: widget.readOnly ?? false,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.done,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            inputFormatters: widget.inputformat == null
                ? null
                : widget.inputformat == "number"
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ]
                    : <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                      ],
            decoration: InputDecoration(
              counterText: "",
              labelText: widget.labelText,
              hintTextDirection: ui.TextDirection.ltr,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: widget.suffixIcon,
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greycolor.shade400,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greycolor.shade400,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greycolor.shade400,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
