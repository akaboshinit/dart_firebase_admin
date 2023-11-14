import 'dart:io';

import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

Future<void> main() async {
  final serviceAccountFile = File('service-account.json');
  final admin = FirebaseAdminApp.initializeApp(
    'template-dev-d032e',
    Credential.fromServiceAccount(serviceAccountFile),
  );

  // admin.useEmulator();

  final firestore = Firestore(admin);

  final collection = firestore.collection('notifications');

  await collection.doc(DateTime.now().toString()).set({
    'name': 'John Doe',
    'age': 30,
  });

  final snapshot = await collection.get();

  for (final doc in snapshot.docs) {
    print(doc.data());
  }

  await admin.close();
}
