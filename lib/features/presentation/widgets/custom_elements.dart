import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: EdgeInsets.all(0), // Keep padding minimal
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Set borderRadius to 12
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;


   CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        // Reduces the overall height of the TextField
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue, width: 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

Widget custombuildTextField(String label,
    {TextInputType inputType = TextInputType.text, TextEditingController? controller}) {
  return TextField(
    decoration: InputDecoration(
      isDense: true,
      // Reduces the overall height of the TextField
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      hintText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue, width: 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    keyboardType: inputType,
  );
}

Widget customIPbuildTextField(String label,
    {TextInputType inputType = TextInputType.text}) {
  return TextField(
    readOnly: true,
    decoration: InputDecoration(
      isDense: true,
      // Reduces the overall height of the TextField
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      hintText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue, width: 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    keyboardType: inputType,
  );
}

class Custom_Logo extends StatelessWidget {
  final String path;

  const Custom_Logo({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path, // Replace with your image path
      width: 200,
      height: 200,
    );
  }
}

Widget customDropdown(
  String label,
  List<String> items,
  String? selectedItem,
  ValueChanged<String?> onChanged,
) {
  return Container(
    height: 40,
    // Adjust the height as needed
    width: 100,
    // Adjust the width as needed
    padding: const EdgeInsets.symmetric(horizontal: 6),
    // Add some padding inside
    decoration: BoxDecoration(

      border: Border.all(color: Colors.lightBlue, width: 2),
      // Blue border
      borderRadius: BorderRadius.circular(12), // Rounded corners

    ),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration.collapsed(
        focusColor: Colors.lightBlue,


        hintText: label,
      ),
      // Removes the default underline
      value: selectedItem,
      icon: Icon(Icons.arrow_drop_down),
      // Drop-down icon
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(

          value: item,
          child: Text(item,style: TextStyle(color: Colors.black),),
        );
      }).toList(),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(5),
      padding: EdgeInsets.only(top: 10),
      style: TextStyle(
          fontSize: 16), // Optional: to make the dropdown menu color white
    ),
  );
}

