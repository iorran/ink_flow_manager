import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class StepFive extends StatelessWidget {
  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  Function() clear;

  StepFive({super.key, required this.clear});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Signature(
          controller: signatureController,
          width: double.infinity,
          height: 200,
          backgroundColor: Colors.lightBlue.shade100,
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            clear();
            signatureController.clear();
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
      ],
    );
  }
}
