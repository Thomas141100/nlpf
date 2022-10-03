FROM dart:2.17-sdk

WORKDIR /app
ADD pubspec.* /app/
RUN dart pub get --no-precompile
ADD . /app/
RUN mv config.prod.yaml config.yaml
RUN dart pub get --offline --no-precompile

EXPOSE 42069
ENTRYPOINT ["dart", "bin/main.dart"]
