import 'package:study_flutter_soap/app/shared/models/tracking_event.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

class TrackedObject {
  final String trackingId;
  final String category;
  final TrackingEvent lastEvent;

  TrackedObject({
    required this.trackingId,
    required this.category,
    required this.lastEvent,
  });

  factory TrackedObject.fromXml(XmlDocument xmlDocument) {
    final objectXml = xmlDocument.findAllElements('objeto').first;
    final eventXml = objectXml.findAllElements('evento').first;

    final date = eventXml.findAllElements('data').first.text.split('/');
    final time = eventXml.findAllElements('hora').first.text.split(':');

    final eventDate = DateTime(
      int.parse(date[2]),
      int.parse(date[1]),
      int.parse(date[0]),
      int.parse(time[0]),
      int.parse(time[1]),
    );
    final description = eventXml.findAllElements('descricao').first.text;
    final place = eventXml.findAllElements('local').first.text;
    final city = eventXml.findAllElements('cidade').first.text;
    final state = eventXml.findAllElements('uf').first.text.toUpperCase();

    return TrackedObject(
      trackingId: objectXml.findAllElements('numero').first.text,
      category: objectXml.findAllElements('categoria').first.text,
      lastEvent: TrackingEvent(
        time: eventDate,
        description: description,
        place: place,
        city: city,
        state: state,
      ),
    );
  }
}
