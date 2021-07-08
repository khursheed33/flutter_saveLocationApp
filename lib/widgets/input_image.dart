import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class InputImage extends StatefulWidget {
  final Function imageHandler;
  InputImage(this.imageHandler);
  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File _inputImage;

  Future<void> _imagePicker() async {
    final getImage = ImagePicker();
    final imageFile = await getImage.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      print("Image Not Selected");
      return;
    }
    setState(() {
      _inputImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage = await _inputImage.copy('${appDir.path}/$fileName');
    widget.imageHandler(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
            ),
            child: _inputImage != null
                ? Image.file(
                    _inputImage,
                    fit: BoxFit.cover,
                  )
                : Text(
                    "No Image Selected",
                    textAlign: TextAlign.center,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: FlatButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Select Image"),
              onPressed: _imagePicker,
            ),
          )
        ],
      ),
    );
  }
}
