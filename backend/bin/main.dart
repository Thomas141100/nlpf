import 'package:backend/backend.dart';

Future main() async {
  final app = Application<Channel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 6000;

  await app.start();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
