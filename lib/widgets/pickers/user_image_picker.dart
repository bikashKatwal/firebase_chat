import 'package:chat_app/widgets/common/common_ui.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: _image == null ? null : Image.file(_image),
        ),
        FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              await showChoiceDialog(context,
                  openCamera: getImageFromCamera,
                  openGallary: getImageFromGallery);
            },
            icon: Icon(Icons.image),
            label: Text('Add Image')),
      ],
    );
  }
}
