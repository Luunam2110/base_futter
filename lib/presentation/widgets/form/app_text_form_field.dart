import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/string_ext.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/presentation/widgets/form/app_form.dart' show CustomFormFieldState;
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.validator,
    this.onChanged,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.showPreviewObscureText = true,
    this.suffixIcon,
    this.prefixIcon,
    this.title,
  });

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final bool showPreviewObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? title;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool showPreviewObscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isStrNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: SizeConstants.paddingSmall),
            child: Text(widget.title!, style: context.appTextStyles.body),
          ),
        _CustomTextFormField(
          context: context,
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          hintText: widget.hintText,
          obscureText: widget.obscureText && !showPreviewObscureText,
          suffixIcon: widget.showPreviewObscureText && widget.obscureText && widget.suffixIcon == null
              ? previewObscureText()
              : widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
      ],
    );
  }

  Widget previewObscureText() {
    return IconButton(
      onPressed: () {
        setState(() => showPreviewObscureText = !showPreviewObscureText);
      },
      icon: Icon(
        showPreviewObscureText ? Icons.visibility_off : Icons.visibility,
        size: SizeConstants.iconDefault,
        color: context.appColors.hintColor,
      ),
    );
  }
}

class _CustomTextFormField extends FormField<String> {
  _CustomTextFormField({
    this.controller,
    this.onChanged,
    super.validator,
    bool obscureText = false,
    String? initialValue,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? enabled,
    AutovalidateMode? autoValidateMode,
    super.restorationId,
    required BuildContext context,
  }) : super(
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? true,
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _CustomTextFormFieldState state = field as _CustomTextFormFieldState;
            void onChangedHandler(String value) {
              field.didChange(value);
              onChanged?.call(value);
            }
            final border = OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
              borderSide: BorderSide(color: context.appColors.borderColor),
            );
            final errorBorder = border.copyWith(
              borderSide: BorderSide(color: context.appColors.errorColor),
            );
            final errorFocusBorder = border.copyWith(
              borderSide: BorderSide(color: context.appColors.errorColor, width: 2),
            );
            final focusBorder = border.copyWith(
              borderSide: BorderSide(color: context.appColors.primaryColor, width: 2),
            );
            final disableBorder = border.copyWith(
              borderSide: BorderSide(color: context.appColors.borderColor.withAlpha((255.0 * 0.5).round())),
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnmanagedRestorationScope(
                  bucket: field.bucket,
                  child: TextField(
                    onChanged: onChangedHandler,
                    restorationId: restorationId,
                    controller: state._effectiveController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: field.hasError ? errorBorder : border,
                      enabledBorder: field.hasError ? errorBorder : border,
                      disabledBorder: disableBorder,
                      focusedBorder: field.hasError ? errorFocusBorder : focusBorder,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeConstants.paddingLarge,
                        vertical: SizeConstants.paddingMedium,
                      ),
                      suffixIcon: suffixIcon,
                      prefixIcon: prefixIcon,
                      hintText: hintText,
                      hintStyle: context.appTextStyles.body.copyWith(
                        color: context.appColors.hintColor,
                      ),
                    ),
                    style: context.appTextStyles.body,
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConstants.paddingMedium,
                    ),
                    child: Text(
                      field.errorText ?? '',
                      style: context.appTextStyles.caption.copyWith(
                        color: context.appColors.errorColor,
                      ),
                    ),
                  ),
              ],
            );
          },
        );

  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

  @override
  FormFieldState<String> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends CustomFormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => _customTextField.controller ?? _controller!.value;

  _CustomTextFormField get _customTextField => super.widget as _CustomTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_customTextField.controller == null) {
      _createLocalController(
        widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null,
      );
    } else {
      _customTextField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(_CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_customTextField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _customTextField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _customTextField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_customTextField.controller != null) {
        setValue(_customTextField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _customTextField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.value = TextEditingValue(text: value ?? '');
    }
  }

  @override
  void reset() {
    _effectiveController.value = TextEditingValue(text: widget.initialValue ?? '');
    super.reset();
    _customTextField.onChanged?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
