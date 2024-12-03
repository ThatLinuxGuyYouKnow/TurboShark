import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key, required this.constraints});
  final BoxConstraints constraints;
  Widget build(BuildContext context) {
    return Container(
        width: constraints.maxWidth > 500 ? 800 : 100,
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(20)),
        child: TextField(
          decoration: InputDecoration(border: InputBorder.none),
        ));
  }
}
