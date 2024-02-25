import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/provider/video_path_provider.dart';
import 'package:krosscutting_app/screens/album_screen/embedded_album.dart';
import 'package:krosscutting_app/screens/album_screen/grant_button.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();

    _checkInitPermission();
  }

  Future<void> _checkInitPermission() async {
    PermissionStatus currentStatus = await Permission.photos.status;

    if (currentStatus.isGranted || currentStatus.isLimited) {
      setState(() {
        hasPermission = true;
      });
    } else {
      await Permission.photos.request();
      PermissionStatus currentStatus = await Permission.photos.status;

      if (currentStatus.isGranted || currentStatus.isLimited) {
        setState(() {
          hasPermission = true;
        });
      }
    }
  }

  void onClickGrantButton() async {
    openAppSettings();

    PermissionStatus newStatus = await Permission.photos.status;

    if (newStatus.isGranted || newStatus.isLimited) {
      setState(() {
        hasPermission = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<VideoPathProvider>(context, listen: false)
                .resetVideoPath();
            Navigator.pushNamed(context, "/home");
          },
        ),
        title: const Text(
          "Select Videos",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Image(
                    image:
                        const AssetImage("assets/images/white_logo_square.png"),
                    height: screenSize.height * 0.2,
                  ),
                ),
                hasPermission
                    ? const EmbeddedAlbum()
                    : Center(
                        child: GrantButton(
                          onClickGrantButton: onClickGrantButton,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
