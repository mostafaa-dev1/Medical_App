import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static final Connectivity _connectivity = Connectivity();
  static final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  /// Public stream to listen for changes
  static Stream<bool> get onConnectionChanged => _connectionController.stream;

  /// Initialize the connectivity listener
  static void initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      final isConnected = result != ConnectivityResult.none;
      _connectionController.add(isConnected);
    });
  }

  /// One-time check
  static Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  /// Dispose when no longer needed (e.g., on app close)
  static void dispose() {
    _connectionController.close();
  }
}
