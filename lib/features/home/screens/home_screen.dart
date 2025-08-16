import 'package:flutter/material.dart';
import 'package:file_converter/features/home/widgets/feature_card.dart';
import 'package:file_converter/features/image_resizer/screens/image_resizer_screen.dart';
// Import other feature screens as they are created
// import 'package:file_converter/features/video_converter/screens/video_converter_screen.dart';
// import 'package:file_converter/features/pdf_merger/screens/pdf_merger_screen.dart';
// import 'package:file_converter/features/pdf_resizer/screens/pdf_resizer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Converter'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            FeatureCard(
              icon: Icons.aspect_ratio,
              title: 'Resize Image',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImageResizerScreen()),
                );
              },
            ),
            FeatureCard(
              icon: Icons.movie_creation_outlined,
              title: 'Convert Video',
              onTap: () {
                // TODO: Navigate to VideoConverterScreen
              },
            ),
            FeatureCard(
              icon: Icons.audiotrack_outlined,
              title: 'Video to Audio',
              onTap: () {
                // TODO: Navigate to VideoToAudioScreen
              },
            ),
            FeatureCard(
              icon: Icons.picture_as_pdf_outlined,
              title: 'Merge PDFs',
              onTap: () {
                // TODO: Navigate to PdfMergerScreen
              },
            ),
            FeatureCard(
              icon: Icons.compress,
              title: 'Compress PDF',
              onTap: () {
                // TODO: Navigate to PdfResizerScreen
              },
            ),
          ],
        ),
      ),
    );
  }
}
