import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/utils/screen_size.dart' show ScreenSize;
import 'package:dafactory/presentation/widgets/button/primary_button.dart';
import 'package:dafactory/presentation/widgets/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum DialogSize {
  medium,
  large,
}

class BaseDialog extends StatefulWidget {
  const BaseDialog({
    super.key,
    required this.title,
    this.primaryButtonText,
    this.secondaryButtonText,
    required this.size,
    this.primaryButtonAction,
    this.secondaryButtonAction,
    required this.builder,
  });

  final String title;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final Function? primaryButtonAction;
  final Function? secondaryButtonAction;
  final DialogSize size;
  final Widget Function(BuildContext context) builder;

  @override
  State<BaseDialog> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.appColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          widget.size == DialogSize.medium ? SizeConstants.dialogMedium : SizeConstants.dialogLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConstants.paddingMedium,
                horizontal: SizeConstants.paddingLarge,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: context.appTextStyles.title,
                  ),
                  Gap(SizeConstants.spacingMedium),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: context.appColors.textColor,
                      size: SizeConstants.iconDefault,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: context.appColors.dividerColor,
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConstants.paddingMedium,
                horizontal: SizeConstants.paddingLarge,
              ),
              child: widget.builder.call(context),
            ),
            Divider(
              color: context.appColors.dividerColor,
              thickness: 1,
              height: 1,
            ),
            if (widget.primaryButtonText != null || widget.secondaryButtonText != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConstants.paddingMedium,
                  horizontal: SizeConstants.paddingLarge,
                ),
                child: SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      if (widget.secondaryButtonText != null) _secondaryButton(),
                      if (widget.secondaryButtonText != null && widget.primaryButtonText != null)
                        Gap(SizeConstants.paddingMedium),
                      if (widget.primaryButtonText != null) _primaryButton(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _secondaryButton() {
    if (widget.secondaryButtonText == null) return const SizedBox();
    final button = SecondaryButton(
      title: widget.secondaryButtonText!,
      onPressed: () {
        widget.secondaryButtonAction?.call();
        Navigator.pop(context);
      },
    );
    if (ScreenSize.isMobile) return Expanded(child: button);
    return button;
  }

  Widget _primaryButton() {
    if (widget.primaryButtonText == null) return const SizedBox();
    final button = PrimaryButton(
      title: widget.primaryButtonText!,
      onPressed: () {
        widget.primaryButtonAction?.call();
        Navigator.pop(context);
      },
    );
    if (ScreenSize.isMobile) return Expanded(child: button);
    return button;
  }
}
