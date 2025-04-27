import 'dart:convert';
import 'dart:developer';

import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/http/http.dart';
import 'package:medical_system/core/networking/services/payment/paymob_constants.dart';

class Paymob {
  final _httpHelper = HttpHelper(
    baseUrl: 'https://accept.paymob.com/api',
  );
  Future<String> getToken() async {
    try {
      final response = await _httpHelper.post(
          endpoint: PaymobConstants.getToken,
          body: {'api_key': PaymobConstants.apiKey});
      final decoded = jsonDecode(response.body);
      //await getOrderId(token: decoded['token'], amount: '100');

      log(decoded['token']);

      return decoded['token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getOrderId({
    required String token,
    required String amount,
  }) async {
    try {
      final response =
          await _httpHelper.post(endpoint: PaymobConstants.orderId, body: {
        'auth_token': token,
        'amount_cents': amount,
        'delivery_needed': 'false',
        'currency': 'EGP',
        'items': [],
      });
      log(' order response body ${response.body}');
      final decoded = jsonDecode(response.body);
      // await getPaymentKey(
      //     orderId: decoded['id'],
      //     token: token,
      //     amount: amount,
      //     user: UserModel(
      //       id: '',
      //       uid: '',
      //       firstName: 'Mostafa',
      //       lastName: 'Mahmoud',
      //       gender: 'Male',
      //       dateOfBirth: DateTime.now(),
      //       email: 'example@gmail.com',
      //       image: '',
      //       phone: '+20123456789',
      //       addresses: [],
      //     ));

      return decoded['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPaymentKey(
      {required int orderId,
      required String token,
      required String amount,
      required UserModel user}) async {
    try {
      final response = await _httpHelper
          .post(endpoint: PaymobConstants.getPaymentKey, body: {
        'integration_id': 4909831,
        'auth_token': token,
        'amount_cents': amount,
        'delivery_needed': 'false',
        'expiration': 3600,
        'currency': 'EGP',
        'items': [],
        'order_id': orderId,
        'billing_data': {
          'apartment': 'NA',
          'email': '${user.email}',
          'floor': 'NA',
          'first_name': '${user.firstName}',
          'last_name': '${user.lastName}',
          'street': 'NA',
          'building': 'NA',
          'phone_number': '${user.phone}',
          'shipping_method': 'NA',
          'city': 'NA',
          'country': 'EG',
          'postal_code': 'NA',
          'state': 'NA',
        }
      });
      log('payment key response: ${response.body}');
      final decoded = jsonDecode(response.body);
      log(decoded['token']);
      return decoded['token'];
    } catch (e) {
      rethrow;
    }
  }
}
