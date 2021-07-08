import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/input_image.dart';
import '../providers/great_places.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = '/add-places';
  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  File _pickedImage;
  var _titleController = TextEditingController();

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
    print("Image Selected");
  }

  void _savePlace() {
    if (_titleController.text == null || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
    );
    Navigator.of(context).pop();

    print("Place Added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Place"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: "Location"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Image Input
                    InputImage(_selectedImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 15),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).canvasColor,
            onPressed: _savePlace,
            child: Text("Add Place"),
          ),
        ],
      ),
    );
  }
}
