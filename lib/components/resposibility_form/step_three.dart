import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ink_flow_manager/components/my_checkbox.dart';
import 'package:ink_flow_manager/components/my_textfield.dart';

class StepThree extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  final GlobalKey<FormFieldState> q4 = GlobalKey();
  final GlobalKey<FormFieldState> q5 = GlobalKey();
  final GlobalKey<FormFieldState> q6 = GlobalKey();
  final GlobalKey<FormFieldState> q7 = GlobalKey();

  StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyCheckbox(controller: q4),
          MyTextField(
            controller: q1,
            hintText: "Indique o valor da tatuagem",
            obscureText: false,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            padding: const EdgeInsets.symmetric(vertical: 10),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
          MyTextField(
            controller: q2,
            hintText: "Zona do corpo a ser feito",
            obscureText: false,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          MyTextField(
            controller: q3,
            hintText: "Desenho",
            obscureText: false,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );
  }
}
