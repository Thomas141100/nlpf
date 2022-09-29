FROM dart:2.17-sdk

WORKDIR /app
ADD pubspec.* /app/
RUN dart pub get --no-precompile
ADD . /app/
RUN dart pub get --offline --no-precompile

WORKDIR /app
EXPOSE 80
ENTRYPOINT ["dart", "run", "conduit:conduit", "serve", "--port", "8080"]
