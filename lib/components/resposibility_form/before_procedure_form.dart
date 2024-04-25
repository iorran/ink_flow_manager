import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

enum YesNo { yes, no }

class BeforeProcedureForm extends StatefulWidget {
  BeforeProcedureForm({super.key});
  final formKey = GlobalKey<FormBuilderState>();

  @override
  State<BeforeProcedureForm> createState() => _BeforeProcedureFormState();
}

class _BeforeProcedureFormState extends State<BeforeProcedureForm> {
  List<dynamic> questions = [
    {
      'label':
          "Afirmo ter conferido todos os detalhes da tatuagem (posição, grafia, datas, desenho, etc). Estou ciente de que a tatuagem é um processo artístico.",
      'fieldname': 'q1',
    },
    {
      'label':
          "Não fiz uso de nenhum anestésico e estou ciente que caso seja descoberto o uso durante o procedimento, o mesmo será interrompido sem devolução do valor pago.",
      'fieldname': 'q2',
    },
    {
      'label': "Confirmo ter mais de 18 Anos.",
      'fieldname': 'q3',
    },
    {
      'label':
          "Afirmo ter ciência de há câmeras no ambiente laboral e autorizo a gravação de minha imagem.",
      'fieldname': 'q4',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        children: buildDynamicQuestions(),
      ),
    );
  }

  List<Column> buildDynamicQuestions() {
    return questions
        .map(
          (question) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderCheckbox(
                title: Text(question['label'], textAlign: TextAlign.justify),
                name: question['fieldname'],
                validator: FormBuilderValidators.required(),
              ),
              if (isLastQuestion(question)) const SizedBox(height: 20),
            ],
          ),
        )
        .toList();
  }

  bool isLastQuestion(question) {
    return question['label'] != questions[questions.length - 1]['label'];
  }
}
