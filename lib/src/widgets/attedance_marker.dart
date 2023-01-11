import 'package:flutter/material.dart';

class AttendanceMarker extends StatefulWidget {
  @override
  _AttendanceMarkerState createState() => _AttendanceMarkerState();
}

class _AttendanceMarkerState extends State<AttendanceMarker> {
  bool _isCheckedIn = false;
  bool _isCheckedOut = false;

  void _handleCheckIn() {
    // call the API to check-in
    setState(() {
      _isCheckedIn = true;
    });
    print('Checked in for today.');
  }

  void _handleCheckOut() {
    // call the API to check-out
    setState(() {
      _isCheckedOut = true;
    });
    print('Checked out for today.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_isCheckedIn)
          ElevatedButton(
            child: Text('Check-In'),
            onPressed: _handleCheckIn,
            style: ButtonStyle(
              // increase the fontSize
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 20),
              ),
              elevation:
                  MaterialStateProperty.all(20), // increase the elevation
              // Add outline around button
              backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
          )
        else if (_isCheckedIn && !_isCheckedOut)
          ElevatedButton(
            child: Text('Check-Out'),
            onPressed: _handleCheckOut,
            style: ButtonStyle(
              // increase the fontSize
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 20),
              ),
              elevation:
                  MaterialStateProperty.all(20), // increase the elevation
              // Add outline around button
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
          )
        else if (_isCheckedOut)
          Text('Attendance marked for today.'),
      ],
    );
  }
}
