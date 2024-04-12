import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/my_checkbox.dart';

class StepFour extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> q1 = GlobalKey();
  final GlobalKey<FormFieldState> q2 = GlobalKey();
  final GlobalKey<FormFieldState> q3 = GlobalKey();

  StepFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyCheckbox(
            label:
                "Comprometo-me a seguir as instruções repassadas pelo profissional, a fim de que a cicatrização seja a melhor possível, estando ciente de que cada pessoa possui um tempo específico e próprio de reação.",
            controller: q1,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyCheckbox(
            label:
                "Estou ciente de que qualquer problema com a minha tatuagem deve ser tratado diretamente com o tatuador.",
            controller: q2,
            validator: (val) {
              if (val == false) return 'Compo obrigatório';
              return null;
            },
          ),
          MyCheckbox(
            label:
                "Autorizo a veiculação do trabalho executado através meio de comunicação isentando-o de qualquer bônus e/ou ônus advindo da exposição da imagem e qualquer processo decorrente.",
            controller: q3,
          ),
        ],
      ),
    );
  }
}
