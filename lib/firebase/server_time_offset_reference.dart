/*
This class contains code to get server's time offset from Firebase
To sync the device time with server time
 */

import 'package:firebase_database/firebase_database.dart';

Future<int> getServerTimeOffset() async {
  int offset = 0;
  var source = await FirebaseDatabase.instance
      .reference()
      .child(".info/serverTimeOffset")
      .once();
  offset = source.value;
  int estimatedServerTimeInMs = DateTime.now().millisecondsSinceEpoch + offset;
  return estimatedServerTimeInMs;
}
