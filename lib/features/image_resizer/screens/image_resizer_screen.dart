import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_converter/core/services/file_picker_service.dart';
import 'package:file_converter/features/image_resizer/services/image_resizing_service.dart';

class ImageResizerScreen extends StatefulWidget {
  const ImageResizerScreen({super.key});

  @override
  State<ImageResizerScreen> createState() => _ImageResizerScreenState();
}

class _ImageResizerScreenState extends State<ImageResizerScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _qualityController = TextEditingController(text: '85');

  Future<void> _pickImage() async {
    final filePickerService = Provider.of<FilePickerService>(context, listen: false);
    final result = await filePickerService.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> _resizeImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    final imageResizingService = Provider.of<ImageResizingService>(context, listen: false);

    // TODO: Get width, height, and quality from text controllers and call the service.
    // final resizedImage = await imageResizingService.resizeImage(...);
    // final compressedImage = await imageResizingService.compressImage(...);

    // TODO: Handle the result (e.g., show a dialog with the new file)

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resize Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Select Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16),
            if (_selectedImage != null)
              Text('Selected: ${_selectedImage!.path.split('/').last}'),
            const SizedBox(height: 32),
            TextField(
              controller: _widthController,
              decoration: const InputDecoration(labelText: 'Width (pixels)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (pixels)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _qualityController,
              decoration: const InputDecoration(labelText: 'Quality (1-100)'),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _selectedImage != null ? _resizeImage : null,
                child: const Text('Resize & Compress'),
              ),
          ],
        ),
      ),
    );
  }
}
