import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ink_flow_manager/components/my_button.dart';
import 'package:ink_flow_manager/providers/artist_provider.dart';
import 'package:ink_flow_manager/services/artist_service.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class EditArtistPage extends StatefulWidget {
  const EditArtistPage({super.key});

  @override
  State<EditArtistPage> createState() => _EditArtistPageState();
}

class _EditArtistPageState extends State<EditArtistPage> {
  bool isLoading = false;
  bool changeSign = false;

  final ImagePicker picker = ImagePicker();

  final ArtistService artistService = ArtistService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistProvider>(
      builder: (context, value, child) {
        final artistProvider = context.read<ArtistProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              value.artist.name,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final pickedImage = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              String downloadUrl =
                                  await artistService.uploadAvatar(value.artist,
                                      await pickedImage.readAsBytes());
                              artistProvider.setImage(downloadUrl);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: getAvatar(value.artist.photo),
                        ),
                  const SizedBox(height: 25),
                  const Text('Assinatura'),
                  const SizedBox(height: 25),
                  showSignature(value),
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: () async {
                      if (signatureController.isNotEmpty) {
                        Uint8List signatureBytes =
                            await signatureController.toPngBytes() as Uint8List;
                        String downloadUrl = await artistService
                            .uploadSignature(value.artist, signatureBytes);
                        artistProvider.setSignature(downloadUrl);
                      }
                      artistService.save(value.artist);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    label: "Salvar",
                    margin: 0,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  CircleAvatar getAvatar(String? photo) {
    return CircleAvatar(
      radius: 100,
      backgroundImage: photo != null
          ? NetworkImage(photo) as ImageProvider<Object>?
          : const AssetImage('lib/images/avatar.png'),
      backgroundColor: Colors.transparent,
    );
  }

  showSignature(value) {
    if (!changeSign && value.artist.signature != null) {
      return GestureDetector(
        onTap: () {
          setState(() {
            changeSign = true;
          });
        },
        child: Image.network(value.artist.signature!),
      );
    } else {
      return Signature(
        controller: signatureController,
        width: double.infinity,
        height: 200,
        backgroundColor: Colors.lightBlue.shade100,
      );
    }
  }
}
