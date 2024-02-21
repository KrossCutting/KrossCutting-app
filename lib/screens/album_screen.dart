import 'package:flutter/material.dart';
import 'package:krosscutting_app/widgets/Imbedded_album.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  bool hasPermission = false;
  bool isFull = false;
  late List<String> videoPaths = [];

  @override
  void initState() {
    super.initState();

    _checkInitPermission();
    isFull = videoPaths.length >= 3 ? true : false;
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

  Future<void> _pickXFiles() async {
    if (isFull) {
      return;
    }

    XFile? selectedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (selectedVideo != null) {
      String videoPath = selectedVideo.path;

      setState(() {
        videoPaths.add(videoPath);

        isFull = videoPaths.length >= 3 ? true : false;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Album",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    hasPermission
                        ? IconButton(
                            icon: const Icon(
                              size: 40,
                              Icons.video_collection_rounded,
                            ),
                            onPressed: _pickXFiles,
                          )
                        : const SizedBox(
                            height: 40,
                            width: 40,
                          ),
                  ],
                ),
                isFull
                    ? const SizedBox(
                        child: Text(
                          "You have already selected 3 or more videos",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "notoSansItalic",
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 104, 224, 210),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                hasPermission
                    ? videoPaths.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(
                              top: 200,
                            ),
                            child: Text(
                              "Welcome to KrossCutting!",
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: "notoSansItalic",
                              ),
                            ),
                          )
                        : Expanded(
                            child: ImbeddedAlbum(videoPathList: videoPaths),
                          )
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
