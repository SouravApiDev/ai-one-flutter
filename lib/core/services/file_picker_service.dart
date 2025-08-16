import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<FilePickerResult?>pickFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );
      return result;
    } catch (e) {
      // Handle exceptions, e.g., platform-specific errors
      print('Error picking file: $e');
      return null;
    }
  }
}
