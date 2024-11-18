import 'package:flutter/material.dart';

class SavedListPage extends StatefulWidget {
  final List<int> savedMovies;
  const SavedListPage({super.key, required this.savedMovies});

  @override
  State<SavedListPage> createState() => _SavedListPageState();
}

class _SavedListPageState extends State<SavedListPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This is a saved list page',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
