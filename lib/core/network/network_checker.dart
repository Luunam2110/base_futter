import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  static Future<bool> check() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.any((e) => [
          ConnectivityResult.wifi,
          ConnectivityResult.mobile,
          ConnectivityResult.vpn,
          ConnectivityResult.other,
          ConnectivityResult.ethernet
        ].contains(e));
  }
}
