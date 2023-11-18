FROM dart:latest AS builder

WORKDIR /app

COPY pubspec* ./

RUN dart pub get
RUN dart pub global activate dart_frog_cli

COPY . ./

RUN dart pub global run dart_frog_cli:dart_frog build

RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

FROM alpine AS runtime
COPY --from=builder /runtime/ /
COPY --from=builder /app/build/bin/server /app/bin/

EXPOSE 8080
CMD ["/app/bin/server"]
