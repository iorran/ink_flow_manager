import 'package:flutter/material.dart';

class MyCheckbox extends StatelessWidget {
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState> controller;

  const MyCheckbox({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: controller,
      initialValue: false,
      validator: (val) {
        if (val == false) return 'Compo obrigatório';
        return null;
      },
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            enabledBorder: InputBorder.none,
          ),
          child: SwitchListTile(
            title: const Text(
              "Afirmo ter conferido todos os detalhes da tatuagem (posição, grafia, datas, desenho, etc). Estou ciente de que a tatuagem é um processo artístico.",
              style: TextStyle(fontWeight: FontWeight.bold),
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
