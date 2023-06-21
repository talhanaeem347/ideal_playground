
import 'package:file_picker/file_picker.dart';

class PickImage {
  static Future<String?> getImage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
    if (result != null) {
      return result.files.single.path!;
    } else {
      return null;
    }
  }
}