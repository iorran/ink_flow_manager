import 'package:flutter/material.dart';
import 'package:ink_flow_manager/models/term.dart';
import 'package:ink_flow_manager/providers/responsibility_form_provider.dart';
import 'package:provider/provider.dart';

class SignTermPage2 extends StatelessWidget {
  const SignTermPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termo de Responsabilidade"),
      ),
      backgroundColor: Colors.grey[300],
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        child: Consumer<ResponsibilityFormProvider>(
          builder: (context, value, child) {
            ResponsibilityFormProvider provider =
                context.read<ResponsibilityFormProvider>();
            return Stepper(
              currentStep: value.currentStep,
              steps: provider.getSteps(),
              controlsBuilder: (buildContext, controlsDetails) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controlsDetails.onStepContinue,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            child: const Text('Próximo'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (value.currentStep > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controlsDetails.onStepCancel,
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                              child: const Text('Anterior'),
                            ),
                          ),
                      ]),
                    ],
                  ),
                );
              },
              onStepCancel: provider.previousStep,
              onStepContinue: () async {
                Term? term = await provider.nextStep();
                if (context.mounted && term != null) {
                  provider.reset();
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
