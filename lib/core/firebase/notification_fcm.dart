import 'package:dafactory/core/utils/logger.dart';
import 'package:dafactory/presentation/widgets/toast/app_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationsManager.instance.setupFlutterNotifications();
  await NotificationsManager.instance.showNotification(message);
}

class NotificationsManager {
  NotificationsManager._();

  static final NotificationsManager instance = NotificationsManager._();

  final _messaging = FirebaseMessaging.instance;

  final _localNotifications = FlutterLocalNotificationsPlugin();
  late final AndroidNotificationChannel productChannel;
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;
    // android setup
    productChannel = const AndroidNotificationChannel(
      'product_channel',
      'Product notifications',
      description: 'This channel is used for product notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(productChannel);

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleSelectNotificationBackground,
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    final hasPermission = await _requestPermission();
    if (!hasPermission) return;

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token
    try {
      final token = await _messaging.getToken();
      logger.d('FCM Token: $token');
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    logger.d(notification);
    if (!kIsWeb && notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            productChannel.id,
            productChannel.name,
            channelDescription: productChannel.description,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<bool> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    logger.d('User granted permission: ${settings.authorizationStatus}');
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onMessage.listen((message) {
      // todo update UI show badge or something
      AppToast.showInfo(title:message.notification?.title, message: message.notification?.body);
      // showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleForegroundMessage);
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleForegroundMessage(initialMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    logger.d('Handling a foreground message: ${message.messageId}');
    //todo open screen with message
  }

  void _handleSelectNotificationBackground(NotificationResponse? message) {
    logger.d('Handling a background message: ${message?.payload}');
    // todo open screen with message
  }
}
