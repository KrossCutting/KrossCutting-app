import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
                Image(
                  image: const AssetImage("assets/images/logo_square.png"),
                  height: screenSize.height * 0.2,
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Choose videos",
                        style: TextStyle(
                          fontSize: screenSize.height * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                  ],
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
