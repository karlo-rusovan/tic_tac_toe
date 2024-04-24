import 'package:flutter/material.dart';

class FilterButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? function;
  final bool highlight;

  const FilterButtonWidget(
      {super.key,   
      required this.label,
      required this.function, 
      required this.highlight    
    }
  );

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: function,             
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: highlight ? Colors.grey[800] :  Colors.grey
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}