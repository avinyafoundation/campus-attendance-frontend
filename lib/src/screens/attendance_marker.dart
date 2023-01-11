// AttendanceMarker screen class

import 'package:ShoolManagementSystem/src/widgets/attedance_marker.dart';
import 'package:flutter/material.dart';

class AttendanceMarkerScreen extends StatefulWidget {
  const AttendanceMarkerScreen({Key? key}) : super(key: key);

  @override
  _AttendanceMarkerScreenState createState() => _AttendanceMarkerScreenState();
}

class _AttendanceMarkerScreenState extends State<AttendanceMarkerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Attendance Marker'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              AttendanceMarker(),
            ],
          ),
        ),
      );
}
