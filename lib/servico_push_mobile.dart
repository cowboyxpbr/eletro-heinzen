import 'package:onesignal_flutter/onesignal_flutter.dart';

class ServicoPushApp {
  static Future<void> inicializar() async {
    try {
      OneSignal.initialize("5174ec50-0787-4708-ae16-f2674e42c657");
      await OneSignal.Notifications.requestPermission(true);
      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        event.notification.display();
      });
    } catch (_) {}
  }

  static Future<void> login(String user, String nome, String cargo) async {
    try {
      await OneSignal.login(user);
      OneSignal.User.addTagWithKey("usuario", user);
      OneSignal.User.addTagWithKey("nome", nome);
      OneSignal.User.addTagWithKey("cargo", cargo);
    } catch (_) {}
  }
}