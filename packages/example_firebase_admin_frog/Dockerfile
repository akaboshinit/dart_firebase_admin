FROM dart:latest AS builder

WORKDIR /app

# COPY pubspec* ./
COPY example_firebase_admin_frog/pubspec* ./
COPY dart_firebase_admin/pubspec* ../dart_firebase_admin/

RUN dart pub get
RUN dart pub global activate dart_frog_cli

# COPY . ./
COPY example_firebase_admin_frog/ ./
COPY dart_firebase_admin ../dart_firebase_admin/

RUN dart pub global run dart_frog_cli:dart_frog build

RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

FROM scratch

COPY --from=builder /runtime/ /
COPY --from=builder /app/build/bin/server /app/bin/
COPY example_firebase_admin_frog/service-account.json service-account.json

EXPOSE 8080
CMD ["/app/bin/server"]
