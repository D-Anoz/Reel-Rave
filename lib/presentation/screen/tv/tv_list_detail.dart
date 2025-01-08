import 'package:flutter/material.dart';

class TvListDetail extends StatefulWidget {
  const TvListDetail({super.key});

  @override
  State<TvListDetail> createState() => _TvListDetailState();
}

class _TvListDetailState extends State<TvListDetail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('TvListDetail'),
      ),
    );
  }
}
