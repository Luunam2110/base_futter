import 'package:flutter/material.dart';

class AppForm extends Form {
  const AppForm({
    super.key,
    required super.child,
    this.autoJump = true,
  });

  final bool autoJump;

  @override
  CustomFormState createState() => CustomFormState();
}

class CustomFormState extends FormState {
  final Set<FormFieldState<dynamic>> _customFields = <FormFieldState<dynamic>>{};

  void _registerCustomField(FormFieldState<dynamic> field) {
    _customFields.add(field);
  }

  void _unregisterCustomField(FormFieldState<dynamic> field) {
    _customFields.remove(field);
  }

  @override
  bool validate() {
    final result = super.validate();
    for (final field in _customFields) {
      if (field.hasError) {
        Scrollable.ensureVisible(
          field.context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        break;
      }
    }
    return result;
  }
}

class CustomFormFieldState<T> extends FormFieldState<T> {
  @override
  void deactivate() {
    final form = Form.maybeOf(context);
    if (form is CustomFormState) {
      form._unregisterCustomField(this);
    }
    super.deactivate();
  }

  @protected
  @override
  Widget build(BuildContext context) {
    final form = Form.maybeOf(context);
    if (form is CustomFormState) {
      form._registerCustomField(this);
    }
    return super.build(context);
  }
}
