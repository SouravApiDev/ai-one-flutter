import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_converter/features/home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:file_converter/core/services/file_picker_service.dart';
import 'package:file_converter/features/image_resizer/services/image_resizing_service.dart';
import 'package:file_converter/features/video_converter/services/video_conversion_service.dart';
import 'package:file_converter/features/pdf_merger/services/pdf_merging_service.dart';
import 'package:file_converter/features/pdf_resizer/services/pdf_resizing_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FilePickerService>(create: (_) => FilePickerService()),
        Provider<ImageResizingService>(create: (_) => ImageResizingService()),
        Provider<VideoConversionService>(create: (_) => VideoConversionService()),
        Provider<PdfMergingService>(create: (_) => PdfMergingService()),
        Provider<PdfResizingService>(create: (_) => PdfResizingService()),
      ],
      child: MaterialApp(
        title: 'File Converter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
