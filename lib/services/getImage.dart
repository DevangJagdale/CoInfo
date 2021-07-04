import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

Future uploadImage(email, profile) async {
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('$email/profile');
  firebase_storage.UploadTask uploadTask = ref.putFile(profile);
  firebase_storage.TaskSnapshot taskSnapshot =
      await uploadTask.whenComplete(() async {
    // String downloadURL = await firebase_storage.FirebaseStorage.instance
    //     .ref('$email/profile')
    //     .getDownloadURL()
    //     .then((value) {
    //   return value;
    // });
    // print(downloadURL);
    return 1;
  });
}

Future<PickedFile> pickImageFromGallery() async {
  final picker = ImagePicker();

  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  if (pickedFile == null) {
    return null;
  } else {
    return pickedFile;
  }
}

Future<PickedFile> pickImageFromCamera() async {
  final picker = ImagePicker();

  final pickedFile = await picker.getImage(source: ImageSource.camera);
  if (pickedFile == null) {
    return null;
  } else {
    return pickedFile;
  }
}
