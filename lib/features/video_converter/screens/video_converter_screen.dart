import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_converter/core/services/file_picker_service.dart';
import 'package:file_converter/features/video_converter/services/video_conversion_service.dart';

class VideoConverterScreen extends StatefulWidget {
  const VideoConverterScreen({super.key});

  @override
  State<VideoConverterScreen> createState() => _VideoConverterScreenState();
}

class _VideoConverterScreenState extends State<VideoConverterScreen> {
  File? _selectedVideo;
  bool _isLoading = false;
  String _selectedFormat = 'mp4';
  String _selectedResolution = '1080p';

  final List<String> _formats = ['mp4', 'mkv', 'avi', 'mov'];
  final List<String> _resolutions = ['720p', '1080p', '4K', '8K'];

  Future<void> _pickVideo() async {
    final filePickerService = Provider.of<FilePickerService>(context, listen: false);
    final result = await filePickerService.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedVideo = File(result.files.single.path!);
      });
    }
  }

  Future<void> _convertVideo() async {
    if (_selectedVideo == null) return;

    setState(() {
      _isLoading = true;
    });

    final videoConversionService = Provider.of<VideoConversionService>(context, listen: false);

    // TODO: Call the service with the selected options
    // final convertedVideo = await videoConversionService.convertVideoFormat(
    //   _selectedVideo!.path,
    //   _selectedFormat,
    //   _selectedResolution,
    // );

    // TODO: Handle the result

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convert Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text('Select Video'),
              onPressed: _pickVideo,
            ),
            const SizedBox(height: 16),
            if (_selectedVideo != null)
              Text('Selected: ${_selectedVideo!.path.split('/').last}'),
            const SizedBox(height: 32),
            DropdownButtonFormField<String>(
              value: _selectedFormat,
              decoration: const InputDecoration(labelText: 'Target Format'),
              items: _formats.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFormat = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedResolution,
              decoration: const InputDecoration(labelText: 'Target Resolution'),
              items: _resolutions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedResolution = newValue!;
                });
              },
            ),
            const Spacer(),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _selectedVideo != null ? _convertVideo : null,
                child: const Text('Convert Video'),
              ),
          ],
        ),
      ),
    );
  }
}
