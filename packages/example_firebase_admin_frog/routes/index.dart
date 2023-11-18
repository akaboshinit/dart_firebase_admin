// import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final admin = FirebaseAdminApp.initializeApp(
    'template-dev-d032e',
    Credential.fromApplicationDefaultCredentials(
      serviceAccountId:
          'firebase-adminsdk-b9utb@template-dev-d032e.iam.gserviceaccount.com',
    ),
  );
  // admin.useEmulator();

  final firestore = Firestore(admin);
  final collection = firestore.collection('test');
  await collection.doc(DateTime.now().toString()).set({
    'age': 32,
    'time': DateTime.now().toIso8601String(),
  });

  // final auth =Auth(admin);

  final snapshot = await collection.get();

  final data = <Map<String, Object?>>[];
  for (final doc in snapshot.docs) {
    data.add(doc.data());
  }

  await admin.close();

  return Response(
    body: 'Welcome to Dart Frog!! ${data.map((e) => e.toString())}}',
  );
}
