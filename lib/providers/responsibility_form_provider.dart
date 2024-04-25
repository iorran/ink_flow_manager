import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ink_flow_manager/components/resposibility_form/after_procedure_form.dart';
import 'package:ink_flow_manager/components/resposibility_form/before_procedure_form.dart';
import 'package:ink_flow_manager/components/resposibility_form/client_sign_form.dart';
import 'package:ink_flow_manager/components/resposibility_form/health_history_form.dart';
import 'package:ink_flow_manager/components/resposibility_form/personal_data_form.dart';
import 'package:ink_flow_manager/components/resposibility_form/select_artist_form.dart';
import 'package:ink_flow_manager/models/term.dart';
import 'package:ink_flow_manager/services/term_service.dart';

class ResponsibilityFormProvider extends ChangeNotifier {
  int currentStep = 0;
  TermService termService = TermService();
  SelectArtistForm selectArtistForm = SelectArtistForm();
  PersonalDataForm personalDataForm = PersonalDataForm();
  HealthHistoryForm healthHistoryForm = HealthHistoryForm();
  BeforeProcedureForm beforeProcedureForm = BeforeProcedureForm();
  AfterProcedureForm afterProcedureForm = AfterProcedureForm();
  ClientSignForm clientSignForm = ClientSignForm();

  void reset() {
    currentStep = 0;
    termService = TermService();
    selectArtistForm = SelectArtistForm();
    personalDataForm = PersonalDataForm();
    healthHistoryForm = HealthHistoryForm();
    beforeProcedureForm = BeforeProcedureForm();
    afterProcedureForm = AfterProcedureForm();
    clientSignForm = ClientSignForm();
  }

  Future<Term?> nextStep() async {
    bool isFinalStep = currentStep == getSteps().length - 1;
    if (!isFinalStep) {
      List validator = [
        () => selectArtistForm.formKey.currentState?.saveAndValidate(),
        () => personalDataForm.formKey.currentState?.saveAndValidate(),
        () => healthHistoryForm.formKey.currentState?.saveAndValidate(),
        () => beforeProcedureForm.formKey.currentState?.saveAndValidate(),
        () => afterProcedureForm.formKey.currentState?.saveAndValidate(),
      ];
      if (validator[currentStep]()) {
        currentStep = currentStep + 1;
      }
      notifyListeners();
      return null;
    } else if (clientSignForm.signatureController.isEmpty) {
      clientSignForm.formKey.currentState?.validate();
      notifyListeners();
      return null;
    }

    DateTime? bday = getFormValue(personalDataForm, 'birthday')?.value;

    Term newTerm = Term(
      artistId: getFormValue(selectArtistForm, 'artist')?.value,
      name: getFormValue(personalDataForm, 'name')?.value,
      email: getFormValue(personalDataForm, 'email')?.value,
      birthday: bday != null ? Timestamp.fromDate(bday) : null,
      document: getFormValue(personalDataForm, 'document')?.value,
      phone: getFormValue(personalDataForm, 'phone')?.value,
      whereFoundUs: getFormValue(personalDataForm, 'whereFoundUs')?.value,
      s2Q1: getFormValue(healthHistoryForm, 'q1')?.value,
      s2Q2: getFormValue(healthHistoryForm, 'q2')?.value,
      s2Q3: getFormValue(healthHistoryForm, 'q3')?.value,
      s2Q4: getFormValue(healthHistoryForm, 'q4')?.value,
      s3Q1: getFormValue(beforeProcedureForm, 'q1')?.value,
      s3Q2: getFormValue(beforeProcedureForm, 'q2')?.value,
      s3Q3: getFormValue(beforeProcedureForm, 'q3')?.value,
      s3Q4: getFormValue(beforeProcedureForm, 'q4')?.value,
      s4Q1: getFormValue(beforeProcedureForm, 'q1')?.value,
      s4Q2: getFormValue(beforeProcedureForm, 'q2')?.value,
      s4Q3: getFormValue(beforeProcedureForm, 'q3')?.value,
    );
    termService.save(
        newTerm, await clientSignForm.signatureController.toPngBytes());
    notifyListeners();
    return newTerm;
  }

  FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>? getFormValue(
          dynamic form, dynamic field) =>
      form.formKey.currentState?.fields[field];

  void previousStep() {
    if (currentStep == 0) return;
    currentStep = currentStep - 1;
    notifyListeners();
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text("Selecione o artista"),
        content: selectArtistForm,
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Dados pessoais"),
        content: personalDataForm,
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Histórico de saúde"),
        content: healthHistoryForm,
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Antes do procedimento"),
        content: beforeProcedureForm,
        isActive: currentStep >= 3,
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Depois do procedimento"),
        content: afterProcedureForm,
        isActive: currentStep >= 4,
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Assinatura"),
        content: clientSignForm,
        isActive: currentStep >= 4,
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
    ];
  }
}
