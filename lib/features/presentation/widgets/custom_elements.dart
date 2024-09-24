import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class Custom_Logo extends StatelessWidget {
  final String path;
  const Custom_Logo ({
    Key? key,
    required this.path,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
     path,  // Replace with your image path
      width: 200,
      height: 200,
    );
  }
}