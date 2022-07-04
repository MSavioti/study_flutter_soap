import 'package:flutter/material.dart';
import 'package:study_flutter_soap/app/presentation/tracking/widgets/search_text_field.dart';
import 'package:study_flutter_soap/app/shared/models/tracked_object.dart';
import 'package:study_flutter_soap/app/shared/utils/xml_utils.dart';
import 'package:http/http.dart' as http;
import 'package:study_flutter_soap/env.dart';
import 'package:xml/xml.dart' as xml;

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  late final _controller = TextEditingController();
  bool _isLoading = false;
  TrackedObject? object;

  void _track(String code) async {
    _setIsLoading(true);
    final request = XmlUtils.correiosRequestFromTrackingCode(code);
    final response = await http.post(
      Env.correiosTrackingUri,
      headers: {
        "Content-Type": "text/xml",
      },
      body: request,
    );
    final xmlDocument = xml.XmlDocument.parse(response.body);
    final trackedObject = TrackedObject.fromXml(xmlDocument);
    _setIsLoading(false);
    setState(() {
      object = trackedObject;
    });
  }

  void _setIsLoading(bool set) {
    setState(() {
      _isLoading = set;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track an object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SearchTextField(
              onSubmit: _track,
              controller: _controller,
            ),
            const SizedBox(height: 20.0),
            if (!_isLoading && object == null)
              const Text('Enter a valid CORREIOS tracking code.'),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading && object != null)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 128.0,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        object!.trackingId,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        'Last event:\n${object!.lastEvent.time}: ${object!.lastEvent.description} - ${object!.lastEvent.city}, ${object!.lastEvent.state}'),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
