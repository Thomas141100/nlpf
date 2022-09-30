import 'dart:io';

import 'package:conduit_config/conduit_config.dart';

class ApplicationConfiguration extends Configuration {
    ApplicationConfiguration(String fileName) :
        super.fromFile(File(fileName));

    late int port;
    late String mongoUri;
}
