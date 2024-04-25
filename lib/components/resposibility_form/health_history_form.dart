import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

enum YesNo { yes, no }

class HealthHistoryForm extends StatefulWidget {
  HealthHistoryForm({super.key});
  final formKey = GlobalKey<FormBuilderState>();

  @override
  State<HealthHistoryForm> createState() => _HealthHistoryFormState();
}

class _HealthHistoryFormState extends State<HealthHistoryForm> {
  List<dynamic> questions = [
    {
      'radioValue': '',
      'radioField': 'rq1',
      'label':
          "Indique se há diagnóstico positivo para Hepatite B e C, HIV/AIDS, sífilis, tuberculose, herpes, eczema, psoríase, acne, rosácea, diabetes, distúrbios de coagulação sanguínea, problemas cardíacos, doenças autoimunes, câncer, epilepsia, gravidez, queloide, anemia, hemofilia ou doença autoimune, vitiligo.",
      'fieldname': 'q1',
    },
    {
      'radioValue': '',
      'radioField': 'rq2',
      'label': "Faz de uso de medicação de uso contínuo?",
      'fieldname': 'q2',
    },
    {
      'radioValue': '',
      'radioField': 'rq3',
      'label': "Possui Alergia a algum cosmético?",
      'fieldname': 'q3',
    },
    {
      'radioValue': '',
      'radioField': 'rq4',
      'label': "Tem cirurgia recente no local?",
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
              Text(question['label'], textAlign: TextAlign.justify),
              FormBuilderRadioGroup(
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    question['radioValue'] = value;
                  });
                },
                name: question['radioField'],
                validator: FormBuilderValidators.required(),
                options: ['Sim', "Não"]
                    .map((value) => FormBuilderFieldOption(
                          value: value,
                        ))
                    .toList(growable: false),
              ),
              if (question['radioValue'] == "Sim")
                FormBuilderTextField(
                  name: question['fieldname'],
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(labelText: 'Especifique'),
                  textInputAction: TextInputAction.done,
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
