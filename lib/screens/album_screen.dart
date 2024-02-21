import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:krosscutting_app/widgets/imbedded_album.dart';

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
                  height: screenSize.height * 0.15,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Album",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
                hasPermission
                    ? const ImbeddedAlbum()
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

class GrantButton extends StatelessWidget {
  final Function()? onClickGrantButton;

  const GrantButton({
    super.key,
    this.onClickGrantButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(45),
            border: const Border(
              top: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              bottom: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              left: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              right: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
            ),
          ),
          child: TextButton(
            onPressed: onClickGrantButton,
            child: const Text(
              "Get Permission",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "notoSansItalic",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
