import 'package:flutter/material.dart';

class MyCheckbox extends StatelessWidget {
  final String? Function(bool?)? validator;
  final GlobalKey<FormFieldState> controller;
  final String label;

  const MyCheckbox({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: controller,
      initialValue: false,
      validator: validator,
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            enabledBorder: InputBorder.none,
          ),
          child: SwitchListTile(
            title: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            contentPadding: EdgeInsets.zero,
            value: field.value!,
            onChanged: (val) {
              field.didChange(val);
            },
          ),
        );
      },
    );
  }
}
