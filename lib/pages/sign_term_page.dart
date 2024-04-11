import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_five.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_four.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_one.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_three.dart';
import 'package:ink_flow_manager/components/resposibility_form/step_two.dart';
import 'package:ink_flow_manager/models/term.dart';
import 'package:ink_flow_manager/services/term_service.dart';
import 'package:toastification/toastification.dart';

class SignTermPage extends StatefulWidget {
  const SignTermPage({super.key});

  @override
  State<SignTermPage> createState() => _SignTermPageState();
}

class _SignTermPageState extends State<SignTermPage> {
  int currentStep = 0;
  String message = '';
  final toastification = Toastification();
  final TermService termService = TermService();
  final StepOne stepOne = StepOne();
  final StepTwo stepTwo = StepTwo();
  final StepThree stepThree = StepThree();
  final StepFour stepFour = StepFour();
  late StepFive stepFive;

  @override
  initState() {
    super.initState();
    stepFive = StepFive(clear: clear);
  }

  clear() {
    setState(() {
      message = '';
    });
  }

  List<Step> getSteps() {
    return [
      Step(
          title: const Text("Dados pessoais"),
          content: stepOne,
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Histórico de saúde"),
          content: stepTwo,
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Antes do procedimento"),
          content: stepThree,
          isActive: currentStep >= 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Depois do procedimento"),
          content: stepFour,
          isActive: currentStep >= 3,
          state: currentStep > 3 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text("Assinatura"),
          content: stepFive,
          isActive: currentStep >= 4,
          state: currentStep > 4 ? StepState.complete : StepState.indexed),
    ];
  }

  onStepCancel() {
    if (currentStep == 0) {
      return;
    }
    setState(() {
      currentStep -= 1;
    });
  }

  onStepContinue() async {
    bool isFinalStep = currentStep == getSteps().length - 1;
    if (!isFinalStep) {
      Map validator = {
        0: () => stepOne.formKey.currentState!.validate(),
        1: () => stepTwo.formKey.currentState!.validate(),
        2: () => stepThree.formKey.currentState!.validate(),
        3: () => stepFour.formKey.currentState!.validate(),
      };
      bool isValidStep = validator[currentStep]();
      if (isValidStep) {
        setState(() {
          currentStep += 1;
        });
      }
      return;
    }

    if (stepFive.signatureController.isEmpty) {
      setState(() {
        message = "Por favor, assine o documento.";
      });
      return;
    }

    Uint8List? signature = await stepFive.signatureController.toPngBytes();
    Term newTerm = Term(
      name: stepOne.nameController.text,
      birthday: stepOne.birthdayController.text,
      document: stepOne.documentController.text,
      phone: stepOne.phoneController.text,
      whereFoundUs: stepOne.whereFoundUsController.text,
      s2Q1: stepTwo.q1.text,
      s2Q2: stepTwo.q2.text,
      s2Q3: stepTwo.q3.text,
      s2Q4: stepTwo.q4.text,
      s3Q1: stepThree.q1.text,
      s3Q2: stepThree.q2.text,
      s3Q3: stepThree.q3.text,
      s4Q1: stepFour.q1.text,
      s4Q2: stepFour.q2.text,
      s4Q3: stepFour.q3.text,
      s4Q4: stepFour.q4.text,
      signature: signature,
    );
    termService.save(newTerm);
    if (context.mounted) {
      toastification.show(
        context: context,
        title: const Text("Termo de consentimento salvo."),
        autoCloseDuration: const Duration(seconds: 2),
      );
      Navigator.pop(context);
    }
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
          controlsBuilder: (buildContext, controlsDetails) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  if (message != "") Text(message),
                  if (message != "") const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                        child: const Text('Próximo'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (currentStep != 0)
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
          onStepCancel: onStepCancel,
          onStepContinue: onStepContinue,
        ),
      ),
    );
  }
}
