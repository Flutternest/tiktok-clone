import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

mixin FullPageProgressMixin<T extends StatefulWidget> on State<T> {
  void showLoader(BuildContext context, Function callback) async {
    final progressHud = ProgressHUD.of(context);
    progressHud?.show();
    try {
      await callback();
    } finally {
      progressHud?.dismiss();
    }
  }
}
