import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ink_flow_manager/models/artist.dart';
import 'package:ink_flow_manager/services/artist_Service.dart';

class SelectArtistForm extends StatefulWidget {
  SelectArtistForm({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  State<SelectArtistForm> createState() => _SelectArtistFormState();
}

class _SelectArtistFormState extends State<SelectArtistForm> {
  final ArtistService artistService = ArtistService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: artistService.listAvailable(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          List<Artist>? artists = snapshot.data;
          if (artists == null) {
            return const Text('Precisa registrar um artista primeiro');
          }
          return FormBuilder(
            key: widget.formKey,
            child: FormBuilderField(
              name: "artist",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              builder: (FormFieldState<dynamic> field) {
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: artists
                            .map((artist) => artistItem(artist))
                            .toList(),
                      ),
                    ),
                    if (field.hasError == true)
                      Text(
                        field.errorText!,
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget artistItem(Artist artist) {
    return GestureDetector(
      onTap: () {
        widget.formKey.currentState?.fields['artist']?.didChange(artist.id);
      },
      child: SizedBox(
        height: 130,
        width: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: isSelectedDecoration(artist),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: artist.photo != null
                    ? NetworkImage(artist.photo!) as ImageProvider<Object>?
                    : const AssetImage('lib/images/avatar.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(
              artist.name,
              style: isSelectedBorder(artist),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle isSelectedBorder(Artist artist) {
    if (artist.id == widget.formKey.currentState?.fields['artist']?.value) {
      return const TextStyle(color: Colors.red);
    }
    return const TextStyle(color: Colors.black);
  }

  BoxDecoration isSelectedDecoration(Artist artist) {
    return BoxDecoration(
      shape: BoxShape.circle,
      border:
          (artist.id == widget.formKey.currentState?.fields['artist']?.value)
              ? Border.all(color: Colors.red, width: 2.0)
              : null,
    );
  }
}
