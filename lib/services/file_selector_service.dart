import 'package:image_picker/image_picker.dart';

class FileSelectorService {

  Future<XFile?> pickFile() async {
    final _imagePicker = ImagePicker();
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
