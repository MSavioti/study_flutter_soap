import 'package:flutter/material.dart';
import 'package:study_flutter_soap/app/presentation/tracking/tracking_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SOAP API',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.yellow[700]),
      ),
      home: const TrackingView(),
    );
  }
}
