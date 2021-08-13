import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey =
      'sk_test_51JO7VHFmxbmPUXeZNN6oz3wBG1YlVDTrMe7KYLC4wEmIpNW2DSwEIardkmiPUlc4gIhWu5MM65XrUZsTUxjliMFX00PSL0ttgC';

  void init() {}

  Future pagarConTarjetaExistente({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {}

  Future pagarConNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {}

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
