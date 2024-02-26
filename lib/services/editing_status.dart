import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:krosscutting_app/constants/edit_status_message.dart'
    as constants;

class EditingStatus extends StatefulWidget {
  final bool isEnable;

  const EditingStatus({super.key, required this.isEnable});

  @override
  _EditingStatus createState() => _EditingStatus();
}

class _EditingStatus extends State<EditingStatus> {
  static const int _statusRequestInterval = 1;

  late Timer _timer;
  String _currentStatus = constants.PROGRESS_MESSAGE["START"] ?? "Loading";

  @override
  void initState() {
    super.initState();
    fetchProgressStatus();

    if (widget.isEnable) {
      _timer = Timer.periodic(const Duration(seconds: _statusRequestInterval),
          (Timer t) async {
        String newStatus = await fetchProgressStatus();

        if (newStatus == "complete") {
          _timer.cancel();
        } else {
          setState(() {
            _currentStatus = newStatus;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<String> fetchProgressStatus() async {
    try {
      final response = await http
          .get(Uri.parse("${dotenv.env["SERVER_HOST"]}/videos/compilations"));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);

        return decodedBody.toString();
      } else {
        return "Error: Failed to load data";
      }
    } catch (e) {
      return "Error: Exception during fetch";
    }
  }

  @override
  Widget build(BuildContext context) {
    String message = _currentStatus;
    message = constants.PROGRESS_MESSAGE[_currentStatus.toUpperCase()] ??
        _currentStatus;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textAlign: TextAlign.center,
        message,
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontFamily: "lobster",
        ),
      ),
    );
  }
}
