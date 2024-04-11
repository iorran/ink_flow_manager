import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/my_textfield.dart';
import 'package:intl/intl.dart';

class StepOne extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whereFoundUsController = TextEditingController();

  StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Column(
          children: [
            MyTextField(
              controller: nameController,
              hintText: "Nome",
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: birthdayController,
              hintText: "Data de nascimento",
              obscureText: false,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  birthdayController.value =
                      TextEditingValue(text: formattedDate);
                }
              },
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: documentController,
              hintText: "Documento de identificaçāo",
              obscureText: false,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: phoneController,
              hintText: "Telemóvel",
              obscureText: false,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: whereFoundUsController,
              hintText: "Como nos conheceu?",
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }
}
