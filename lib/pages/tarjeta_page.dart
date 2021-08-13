import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_stripe_app/models/tarjeta_credito.dart';
import 'package:flutter_stripe_app/widgets/total_pay_button.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({
    Key? key,
    required this.tarjeta,
  }) : super(key: key);

  final TarjetaCredito tarjeta;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PagarBloc>().add(OnDesactivarTarjeta());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagar'),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Hero(
                tag: tarjeta.cardNumber,
                child: CreditCardWidget(
                  cardNumber: tarjeta.cardNumber,
                  expiryDate: tarjeta.expiracyDate,
                  cardHolderName: tarjeta.cardHolderName,
                  cvvCode: tarjeta.cvv,
                  showBackView: false,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: TotalPayButton(),
            ),
          ],
        ),
      ),
    );
  }
}
