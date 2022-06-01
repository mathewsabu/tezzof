import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

class CommonVeriables extends ChangeNotifier {
  int? role;

  int? get userRole => role;
}
