import 'package:firebase_database/firebase_database.dart';

final DBRef = FirebaseDatabase.instance.reference();

void writeDataFirebase(i, cmd, output) {
  DBRef.child(i.toString()).set({'Command': cmd, 'Output': output});
  print("Data Uploaded");
}
