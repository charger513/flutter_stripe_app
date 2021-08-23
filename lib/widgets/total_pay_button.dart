import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_stripe_app/helpers/helpers.dart';
import 'package:flutter_stripe_app/services/stripe_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BlocBuilder<PagarBloc, PagarState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${state.montoPagar.toStringAsFixed(2)} ${state.moneda}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              _BtnPay(
                tarjetaActiva: state.tarjetaActiva,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  const _BtnPay({
    Key? key,
    required this.tarjetaActiva,
  }) : super(key: key);

  final bool tarjetaActiva;

  @override
  Widget build(BuildContext context) {
    return tarjetaActiva
        ? buildBotonTarjeta(context)
        : buildAppleAndGooglePay(context);
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
      onPressed: () async {
        final stripeService = StripeService();
        final state = context.read<PagarBloc>().state;

        final resp = await stripeService.pagarApplePayGooglePay(
          amount: state.montoPagarString,
          currency: state.moneda,
        );
      },
    );
  }

  Widget buildBotonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: const [
          Icon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
      onPressed: () async {
        mostrarLoading(context);

        final stripeService = StripeService();
        final state = context.read<PagarBloc>().state;
        final tarjeta = state.tarjeta!;
        final mesAnio = tarjeta.expiracyDate.split('/');

        final resp = await stripeService.pagarConTarjetaExistente(
          amount: state.montoPagarString,
          currency: state.moneda,
          card: CreditCard(
            number: tarjeta.cardNumber,
            expMonth: int.parse(mesAnio[0]),
            expYear: int.parse(mesAnio[1]),
          ),
        );

        Navigator.pop(context);

        if (resp.ok) {
          mostrarAlerta(context, 'Tarjeta OK', "Correcto");
        } else {
          mostrarAlerta(
            context,
            'Algo salió mal',
            resp.msg ?? 'Error desconocido',
          );
        }
      },
    );
  }
}
