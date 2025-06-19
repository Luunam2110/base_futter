abstract class NotificationHelper {
  static late final NotificationHelper _instance;
  static bool isInit = false;

  static NotificationHelper get instance {
    assert(isInit, 'NotificationHelper not initialized');
    return _instance;
  }

  static void init(NotificationHelper platform) {
    if (isInit) return;
    isInit = true;
    _instance = platform;
  }

  bool showNotification(String title, String body);
}
