import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

enum YesNo { yes, no }

class AfterProcedureForm extends StatefulWidget {
  AfterProcedureForm({super.key});
  final formKey = GlobalKey<FormBuilderState>();

  @override
  State<AfterProcedureForm> createState() => _AfterProcedureFormState();
}

class _AfterProcedureFormState extends State<AfterProcedureForm> {
  List<dynamic> questions = [
    {
      'label':
          "Comprometo-me a seguir as instruções repassadas pelo profissional, a fim de que a cicatrização seja a melhor possível, estando ciente de que cada pessoa possui um tempo específico e próprio de reação.",
      'fieldname': 'q1',
      'required': true,
    },
    {
      'label':
          "Estou ciente de que qualquer problema com a minha tatuagem deve ser tratado diretamente com o tatuador.",
      'fieldname': 'q2',
      'required': true,
    },
    {
      'label':
          "Autorizo a veiculação do trabalho executado através meio de comunicação isentando-o de qualquer bônus e/ou ônus advindo da exposição da imagem e qualquer processo decorrente.",
      'fieldname': 'q3',
      'required': false,
    },
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
                validator: question['required']
                    ? FormBuilderValidators.required()
                    : null,
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
