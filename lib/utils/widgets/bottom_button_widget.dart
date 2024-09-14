import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {super.key,
      required this.bottonTitle,
      this.backgroundColor,
      this.titleColor,
      this.borderColor,
      this.onTap});
  final String? bottonTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    WidgetStateProperty.all<Color>(backgroundColor as Color),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))),
            onPressed: onTap,
            child: Text(bottonTitle as String,
                style: TextStyle(
                    fontSize: 12, color: titleColor, letterSpacing: 2))),
      ),
    );
  }
}
