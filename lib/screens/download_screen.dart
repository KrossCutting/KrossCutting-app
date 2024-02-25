import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:krosscutting_app/provider/download_url_provider.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  _DownloadScreen createState() => _DownloadScreen();
}

class _DownloadScreen extends State<DownloadScreen>
    with TickerProviderStateMixin {
  bool _isDownloading = true;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _downloadAndSaveVideo();
    });
  }

  Future<File?> _downloadVideo(String url) async {
    try {
      Dio dio = Dio();
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/final-video.mp4");
      await dio.download(url, file.path);
      return file;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> _saveVideoToGallery(String filePath) async {
    try {
      bool? isSaved =
          await GallerySaver.saveVideo(filePath, albumName: "krosscutting");
      return isSaved ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _downloadAndSaveVideo() async {
    final String videoUrl =
        Provider.of<DownloadUrlProvider>(context, listen: false).finalVideoUrl;
    if (videoUrl.isNotEmpty) {
      File? downloadedFile = await _downloadVideo(videoUrl);
      if (downloadedFile != null) {
        bool saved = await _saveVideoToGallery(downloadedFile.path);
        if (saved) {
          setState(() {
            _isDownloading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isDownloading
            ? SpinKitWaveSpinner(
                color: Colors.green,
                waveColor: Colors.green[100]!,
                size: 129,
              )
            : Lottie.asset(
                'assets/images/checkmark.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller!
                    ..duration = composition.duration
                    ..forward()
                    ..addStatusListener(
                      (status) {
                        if (status == AnimationStatus.completed) {
                          Future.delayed(
                            const Duration(milliseconds: 300),
                            () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                    );
                },
              ),
      ),
    );
  }
}
