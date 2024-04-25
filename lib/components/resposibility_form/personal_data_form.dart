import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PersonalDataForm extends StatelessWidget {
  PersonalDataForm({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
          ),
          FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(labelText: 'Email'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'phone',
            decoration: const InputDecoration(labelText: 'Telefone'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          FormBuilderTextField(
            name: 'document',
            decoration: const InputDecoration(labelText: 'Documento'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            textInputAction: TextInputAction.next,
          ),
          FormBuilderDateTimePicker(
            name: 'birthday',
            decoration: const InputDecoration(labelText: 'Data de nascimento'),
            inputType: InputType.date,
            textInputAction: TextInputAction.next,
          ),
          FormBuilderTextField(
            name: 'whereFoundUs',
            decoration: const InputDecoration(labelText: 'Onde nos encontrou?'),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
