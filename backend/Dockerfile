FROM dart:2.17-sdk

WORKDIR /app
ADD pubspec.* /app/
RUN dart pub get --no-precompile
ADD . /app/
RUN dart pub get --offline --no-precompile

EXPOSE 42069
ENTRYPOINT ["dart", "pub", "run", "conduit:conduit", "serve", "--port", "42069", "--config-path", "config.prod.yaml"]
