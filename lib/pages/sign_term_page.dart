import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_one.dart';

class SignTermPage extends StatefulWidget {
  const SignTermPage({super.key});

  @override
  State<SignTermPage> createState() => _SignTermPageState();
}

class _SignTermPageState extends State<SignTermPage> {
  int currentStep = 0;

  List<Step> getSteps() {
    return [
      Step(
          title: const Text("Dados pessoais"),
          content: StepOne(),
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Histórico de saúde"),
          content: StepOne(),
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Antes do procedimento"),
          content: StepOne(),
          isActive: currentStep >= 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Depois do procedimento"),
          content: StepOne(),
          isActive: currentStep >= 3,
          state: currentStep > 3 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Assinatura"),
          content: StepOne(),
          isActive: currentStep >= 4,
          state: currentStep > 4 ? StepState.complete : StepState.indexed),
    ];
  }

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
        child: Stepper(
          currentStep: currentStep,
          steps: getSteps(),
          onStepCancel: () {
            if (currentStep == 0) {
              return;
            }
            setState(() {
              currentStep -= 1;
            });
          },
          onStepContinue: () {
            if (currentStep == getSteps().length - 1) {
              return;
            }
            setState(() {
              currentStep += 1;
            });
          },
        ),
      ),
    );
  }
}
