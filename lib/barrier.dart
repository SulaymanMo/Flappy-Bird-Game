import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  const Barrier({super.key, this.size});

  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 9, color: Colors.green.shade800,),
        borderRadius: const BorderRadius.all(Radius.circular(15),),
      ),
    );
  }
}