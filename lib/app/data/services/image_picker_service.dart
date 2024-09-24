import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile?.path;
  }

  Future<String?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  Future<void> showImageSourceDialog(
      BuildContext context, Function updateImage) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  String? pickedPath = await pickImageFromCamera();
                  if (pickedPath != null) {
                    // Update profile image path
                    updateImage(pickedPath);
                    // You may want to setState here if using a StatefulWidget
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  String? pickedPath = await pickImageFromGallery();
                  if (pickedPath != null) {
                    updateImage(pickedPath);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
