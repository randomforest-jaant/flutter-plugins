import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<ActivityEvent> activityStream;
  ActivityEvent latestActivity = ActivityEvent.empty();
  List<ActivityEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (await Permission.activityRecognition.request().isGranted) {
      activityStream =
          ActivityRecognition.activityStream(runForegroundService: true);
      activityStream.listen(onData);
    }
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    setState(() {
      _events.add(activityEvent);
      latestActivity = activityEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Activity Recognition Demo'),
        ),
        body: new Center(
            child: new ListView.builder(
                itemCount: _events.length,
                reverse: true,
                itemBuilder: (BuildContext context, int idx) {
                  final entry = _events[idx];
                  return ListTile(
                      leading:
                          Text(entry.timeStamp.toString().substring(0, 19)),
                      trailing: Text(entry.type.toString().split('.').last));
                })),
      ),
    );
  }
}
