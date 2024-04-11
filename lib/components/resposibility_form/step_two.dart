import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/my_textfield.dart';

class StepTwo extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final q1 = TextEditingController();
  final q2 = TextEditingController();
  final q3 = TextEditingController();
  final q4 = TextEditingController();

  StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Indique se há diagnóstico positivo para Hepatite B e C, HIV/AIDS, sífilis, tuberculose, herpes, eczema, psoríase, acne, rosácea, diabetes, distúrbios de coagulação sanguínea, problemas cardíacos, doenças autoimunes, câncer, epilepsia, gravidez, queloide, anemia, hemofilia ou doença autoimune, vitiligo.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: q1,
            hintText: "Especifique.",
            obscureText: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            padding: const EdgeInsets.all(0),
          ),
          const SizedBox(height: 25),
          const Text(
            "Faz de uso de medicação de uso contínuo?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: q2,
            hintText: "Especifique.",
            obscureText: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            padding: const EdgeInsets.all(0),
          ),
          const SizedBox(height: 25),
          const Text(
            "Possui Alergia a algum cosmético?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: q3,
            hintText: "Especifique.",
            obscureText: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            padding: const EdgeInsets.all(0),
          ),
          const SizedBox(height: 25),
          const Text(
            "Tem cirurgia recente no local?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: q4,
            hintText: "Especifique.",
            obscureText: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            padding: const EdgeInsets.all(0),
          )
        ],
      ),
    );
  }
}
