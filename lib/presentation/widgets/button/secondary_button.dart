import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({super.key, required this.title, this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: context.appColors.background,
        border: Border.all(color: context.appColors.primaryColor),
        borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
        splashColor: context.appColors.background,
        onTap: widget.onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.paddingMedium,
            vertical: SizeConstants.paddingSmall,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: context.appTextStyles.body,
            ),
          ),
        ),
      ),
    );
  }
}
