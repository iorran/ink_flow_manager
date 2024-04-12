import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ink_flow_manager/components/my_checkbox.dart';
import 'package:ink_flow_manager/components/my_textfield.dart';

class StepThree extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> q1 = GlobalKey();
  final GlobalKey<FormFieldState> q2 = GlobalKey();
  final GlobalKey<FormFieldState> q3 = GlobalKey();
  final GlobalKey<FormFieldState> q4 = GlobalKey();
  final TextEditingController q5 = TextEditingController();
  final TextEditingController q6 = TextEditingController();
  final TextEditingController q7 = TextEditingController();

  StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyCheckbox(
            label:
                "Afirmo ter conferido todos os detalhes da tatuagem (posição, grafia, datas, desenho, etc). Estou ciente de que a tatuagem é um processo artístico.",
            controller: q1,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyCheckbox(
            label:
                "Não fiz uso de nenhum anestésico e estou ciente que caso seja descoberto o uso durante o procedimento, o mesmo será interrompido sem devolução do valor pago.",
            controller: q2,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyCheckbox(
            label: "Confirmo ter mais de 18 Anos.",
            controller: q3,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyCheckbox(
            label:
                "Afirmo ter ciência de há câmeras no ambiente laboral e autorizo a gravação de minha imagem.",
            controller: q4,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyTextField(
            controller: q5,
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
            controller: q6,
            hintText: "Zona do corpo a ser feito",
            obscureText: false,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          MyTextField(
            controller: q7,
            hintText: "Desenho",
            obscureText: false,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );
  }
}
