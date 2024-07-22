import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HistoryKkhScreen extends StatelessWidget {
  final String day;
  final String date;
  final String subtitle;
  final String totalJamTidur;
  final String role;
  final String imageUrl;
  final bool isValidated;

  const HistoryKkhScreen({
    super.key,
    required this.day,
    required this.date,
    required this.totalJamTidur,
    required this.role,
    required this.imageUrl,
    required this.isValidated,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History KKH'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        toolbarHeight: 45,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 69,
              height: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHistoryCard(
                context,
                day: day,
                date: date,
                totalJamTidur: totalJamTidur,
                role: role,
                imageUrl: imageUrl,
                isValidated: isValidated,
              ),
              // Add more _buildHistoryCard widgets here as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
      BuildContext context, {
        required String day,
        required String date,
        required String totalJamTidur,
        required String role,
        required String imageUrl,
        required bool isValidated,
      }) {

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isValidated ? 'Validated' : 'Not Yet Validated',
                  style: TextStyle(
                    color: isValidated ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$day, $date',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Total Jam Tidur:', totalJamTidur),
            const SizedBox(height: 8),
            if (imageUrl.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _showImageDialog(context, imageUrl);
                },
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (role == 'foreman')
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // function submit
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF304FFE),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: const Text('Validation'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<ImageInfo>(
          future: _getImageInfo(imageUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              final imageInfo = snapshot.data!;
              final imageWidth = imageInfo.image.width.toDouble();
              final imageHeight = imageInfo.image.height.toDouble();

              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 100,
                        maxWidth: MediaQuery.of(context).size.width - 40,
                      ),
                      child: AspectRatio(
                        aspectRatio: imageWidth / imageHeight,
                        child: PhotoView(
                          imageProvider: NetworkImage(imageUrl),
                          backgroundDecoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                          minScale: PhotoViewComputedScale.contained,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            } else {
              return const Dialog(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<ImageInfo> _getImageInfo(String imageUrl) async {
    final completer = Completer<ImageInfo>();
    final image = NetworkImage(imageUrl);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info);
      }),
    );
    return completer.future;
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
