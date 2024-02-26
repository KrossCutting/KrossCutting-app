import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krosscutting_app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:krosscutting_app/provider/download_url_provider.dart';

Future<void> postPoints({
  required BuildContext context,
  required Map pointResultData,
  required String direction,
}) async {
  try {
    String jsonEncodedData = json.encode(pointResultData);
    var url = Uri.parse(
        "${dotenv.env["SERVER_HOST"]}/videos/compilations/$direction");
    var response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncodedData,
    );

    if (response.statusCode == 201) {
      final decodedBody = json.decode(response.body);
      final downloadUrl =
          Provider.of<DownloadUrlProvider>(context, listen: false);

      downloadUrl.setVideoUrl(decodedBody['s3ClientFinalVideoUrl']);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  } catch (e) {
    print("error: $e");
  }
}
