import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_stripe_app/data/tarjetas.dart';
import 'package:flutter_stripe_app/helpers/helpers.dart';
import 'package:flutter_stripe_app/helpers/navegar_fadein.dart';
import 'package:flutter_stripe_app/pages/tarjeta_page.dart';
import 'package:flutter_stripe_app/services/stripe_service.dart';
import 'package:flutter_stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  final stripeService = StripeService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pagarBloc = context.read<PagarBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final response = await stripeService.pagarConNuevaTarjeta(
                amount: pagarBloc.state.montoPagarString,
                currency: pagarBloc.state.moneda,
              );

              if (response.ok) {
                mostrarAlerta(context, 'Tarjeta OK', "Correcto");
              } else {
                mostrarAlerta(
                  context,
                  'Algo salió mal',
                  response.msg ?? 'Error desconocido',
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              physics: const BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];
                return GestureDetector(
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
                  onTap: () {
                    context.read<PagarBloc>().add(
                          OnSeleccionarTarjeta(tarjeta),
                        );
                    Navigator.push(context,
                        navegarFadeIn(context, TarjetaPage(tarjeta: tarjeta)));
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
