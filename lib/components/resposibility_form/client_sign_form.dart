import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:signature/signature.dart';

class ClientSignForm extends StatefulWidget {
  ClientSignForm({super.key});

  final formKey = GlobalKey<FormBuilderState>();
  final formFieldKey = GlobalKey<FormBuilderFieldState>();

  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  State<ClientSignForm> createState() => _ClientSignFormState();
}

class _ClientSignFormState extends State<ClientSignForm> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: FormBuilderField(
        key: widget.formFieldKey,
        name: "signature",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        builder: (FormFieldState<dynamic> field) {
          return Column(
            children: [
              Signature(
                controller: widget.signatureController,
                width: double.infinity,
                height: 200,
                backgroundColor: Colors.lightBlue.shade100,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  widget.formFieldKey.currentState?.reset();
                  widget.signatureController.clear();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Refazer',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.undo_sharp,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (widget.formFieldKey.currentState?.hasError == true)
                Text(
                  widget.formFieldKey.currentState!.errorText!,
                  style: const TextStyle(color: Colors.red),
                )
            ],
          );
        },
      ),
    );
  }
}
