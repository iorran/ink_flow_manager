import 'package:flutter/material.dart';
import 'package:ink_flow_manager/components/my_textfield.dart';

class StepOne extends StatelessWidget {
  final nameController = TextEditingController();

  StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MyTextField(
            controller: nameController,
            hintText: "Nome",
            obscureText: false,
          ),
          const SizedBox(height: 25),
          MyTextField(
            controller: nameController,
            hintText: "Data de nascimento",
            obscureText: false,
          ),
          const SizedBox(height: 25),
          MyTextField(
            controller: nameController,
            hintText: "Documento de identificaçāo",
            obscureText: false,
          ),
          const SizedBox(height: 25),
          MyTextField(
            controller: nameController,
            hintText: "Telemóvel",
            obscureText: false,
          ),
          const SizedBox(height: 25),
          MyTextField(
            controller: nameController,
            hintText: "Como nos conheceu?",
            obscureText: false,
          ),
        ],
      ),
    );
  }
}
