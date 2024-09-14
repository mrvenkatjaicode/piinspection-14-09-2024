import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../constant.dart';

class DropDownPiWidget extends StatefulWidget {
  final bool? ignoring;
  final bool? visible;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  const DropDownPiWidget({
    super.key,
    this.ignoring,
    this.visible,
    this.focusNode,
    this.controller,
    this.labelText,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
  });

  @override
  State<DropDownPiWidget> createState() => _DropDownPiWidgetState();
}

class _DropDownPiWidgetState extends State<DropDownPiWidget> {
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
            readOnly: true,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onTapOutside: widget.onTapOutside,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintTextDirection: ui.TextDirection.ltr,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(Icons.arrow_forward_rounded),
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
