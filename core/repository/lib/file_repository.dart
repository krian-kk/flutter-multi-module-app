import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class FileRepository {
  Future<String> selectImageFromMobile(String imageType);

  File? getFileFromPath(String path);
}

enum ImagePickerType { camera, gallery }

class FileRepositoryImpl extends FileRepository {
  @override
  Future<String> selectImageFromMobile(String imageType) {
    if (imageType == ImagePickerType.gallery.toString()) {
      return selectImageFromGallery();
    } else {
      return selectImageFromCamera();
    }
  }

  Future<String> selectImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Future<String> selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  @override
  File? getFileFromPath(String path) {
    return File(path);
  }
}
