import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
  });

  final String title;
  final VoidCallback? onPressed;
  final double? width;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: const BoxConstraints(minHeight: SizeConstants.fieldHeight),
      child: Material(
        color: context.appColors.background,
        borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
        child: Ink(
          decoration: BoxDecoration(
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
              child: Center(
                widthFactor: 1.0,
                child: Text(
                  widget.title,
                  style: context.appTextStyles.body,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
