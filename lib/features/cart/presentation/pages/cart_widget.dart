// cart_widget.dart
import 'package:flutter/material.dart';
import 'package:julybyoma_app/common/widget/header_widget.dart';
import 'package:julybyoma_app/features/cart/presentation/widgets/cart_list_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const HeaderWidget(title: "Cart"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CartListWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
