import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class ImageTile extends StatelessWidget {
  final Map<String, dynamic> image;

  const ImageTile({required this.image, Key? key}) : super(key: key);

  Future<void> downloadImage(
      String imageUrl, String fileName, BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
      return;
    }

    try {
      final dio = Dio();
      final directory = '/storage/emulated/0/Download';
      final savePath = '$directory/$fileName.jpg';

      await dio.download(imageUrl, savePath);
      print('Image downloaded to $savePath');

      // Show a Snackbar after the download is complete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Image downloaded successfully!'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = image['urls']?['regular'] as String? ?? '';
    final highResUrl = image['urls']?['full'] as String? ?? '';
    final imageId = image['id']?.toString() ?? 'unknown';

    if (imageUrl.isEmpty || highResUrl.isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.error, color: Colors.red),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        downloadImage(highResUrl, imageId, context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
