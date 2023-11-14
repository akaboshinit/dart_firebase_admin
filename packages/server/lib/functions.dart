// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

@CloudFunction()
Future<Response> function(Request request) async {
  final serviceAccountFile = File('service-account.json');
  final admin = FirebaseAdminApp.initializeApp(
    'template-dev-d032e',
    Credential.fromServiceAccount(serviceAccountFile),
  );

  // admin.useEmulator();

  final firestore = Firestore(admin);
  final collection = firestore.collection('test');

  await collection
      .doc(DateTime.now().toString())
      .withConverter(
        fromFirestore: _jsonFromFirestore,
        toFirestore: _jsonToFirestore,
      )
      .set({
    'name': 'John Doe',
    'age': 30,
  });

  final snapshot = await collection.get();

  final List<Map<String, Object?>> data = [];
  for (final doc in snapshot.docs) {
    data.add(doc.data());
  }

  await admin.close();

  return Response.ok('Hello, World! ${data.map((e) => e.toString())}');
}

// Overriding the default 'function' also works, but you will need
// to ensure to set the FUNCTION_TARGET environment variable for the
// process to 'handleGet' as well.
//@CloudFunction()
//Response handleGet(Request request) => Response.ok('Hello, World!');

typedef UpdateMap = Map<FieldPath, Object?>;

typedef FromFirestore<T> = T Function(
  QueryDocumentSnapshot<DocumentData> value,
);
typedef ToFirestore<T> = DocumentData Function(T value);
DocumentData _jsonFromFirestore(QueryDocumentSnapshot<DocumentData> value) {
  return value.data();
}

DocumentData _jsonToFirestore(DocumentData value) => value;

typedef FirestoreDataConverter<T> = ({
  FromFirestore<T> fromFirestore,
  ToFirestore<T> toFirestore,
});
const FirestoreDataConverter<DocumentData> jsonConverter = (
  fromFirestore: _jsonFromFirestore,
  toFirestore: _jsonToFirestore,
);
