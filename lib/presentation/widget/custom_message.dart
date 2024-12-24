import 'package:flutter/material.dart';

class SuccessMessage extends StatelessWidget {
  final String message;
  const SuccessMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.all(15),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
