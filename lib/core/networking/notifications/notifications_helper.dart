// import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class NotificationsHelper {
  // creat instance of fbm
  final _messaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String>? getToken() async {
    await requestPermission();
    String? token = await _messaging.getToken();
    return token!;
  }

  // handle notifications when received
  // void handleMessages(RemoteMessage? message) {
  //   if (message != null) {
  //     // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
  //     showToast(
  //         text: 'on Background Message notification',
  //         state: ToastStates.SUCCESS);
  //   }
  // }

  // handel notifications in case app is terminated
  // void handleBackgroundNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  // }

 

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/academe-35669/messages:send";

      //Dio dio = Dio();
      // dio.options.headers['Content-Type'] = 'application/json';
      // dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      await http.post(
        Uri.parse(urlEndPoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKeyAuthorization',
        },
        body: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
        // data: getBody(
        //   userId: userId,
        //   fcmToken: fcmToken,
        //   title: title,
        //   body: body,
        //   type: type ?? "message",
        // ),
      );
      // Print response status code and body for debugging
    } catch (e) {
      // Print error message for debugging
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('Subscribed to $topic');
    } catch (e) {
      print('Error subscribing to $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic).then((value) {
      print('Unsubscribed from $topic');
    }).catchError((e) {
      print('Error unsubscribing from $e');
    });
  }

  void onBackgroundMessage(RemoteMessage message) {}
}
