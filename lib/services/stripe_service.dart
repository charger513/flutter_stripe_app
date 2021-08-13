import 'package:flutter_stripe_app/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey =
      'sk_test_51JO7VHFmxbmPUXeZNN6oz3wBG1YlVDTrMe7KYLC4wEmIpNW2DSwEIardkmiPUlc4gIhWu5MM65XrUZsTUxjliMFX00PSL0ttgC';
  String _apiKey =
      'pk_test_51JO7VHFmxbmPUXeZ2l7dOUnniGteGQftjGWuorQIKNUmJsu0dTWvAW8iZPgM6ZW6AejsnlVYzLoSS0mNuK9BgDtG00JVeDCvue';

  void init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: _apiKey,
      androidPayMode: 'test',
      merchantId: 'test',
    ));
  }

  Future pagarConTarjetaExistente({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {}

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      // TODO Crear intent

      return StripeCustomResponse(ok: true);
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {}

  Future _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async {}

  Future _realizarPago({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async {}
}
