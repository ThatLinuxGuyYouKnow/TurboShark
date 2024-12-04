import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key, required this.constraints});
  final BoxConstraints constraints;
  Widget build(BuildContext context) {
    return Container(
        height: constraints.maxHeight > 700 ? 50 : 40,
        width: constraints.maxWidth > 470 ? 400 : 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  weight: 40,
                ),
                border: InputBorder.none),
          ),
        ));
  }
}
