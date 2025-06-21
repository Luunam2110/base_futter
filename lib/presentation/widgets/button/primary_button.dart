import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.color,
    this.width,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: const BoxConstraints(minHeight: SizeConstants.fieldHeight),
      child: Material(
        color: context.appColors.primaryColor,
        borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
          splashColor: context.appColors.splashColor,
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
                style: context.appTextStyles.lightBody,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
