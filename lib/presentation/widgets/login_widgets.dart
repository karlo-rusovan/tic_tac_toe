import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final String? label;
  final bool obscure;
  final TextInputType? keyboardType; 

  const TextFieldWidget(
      {super.key,   
      this.keyboardType,
      this.controller,
      this.label,
      this.obscure = false,   
      this.inputAction = TextInputAction.next
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextField(      
      keyboardType: keyboardType,
      controller: controller,
      cursorHeight: 24,
      cursorColor: const Color(0x00000000),
      textInputAction: inputAction,
      decoration: InputDecoration(        
        labelText: label,       
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Color(0x9a9a9a9a)),
        ),
      ),
      obscureText: obscure,
    );
  }
}
