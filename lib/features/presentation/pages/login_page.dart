
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../widgets/custom_elements.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check screen width, adjust layout accordingly
          double screenWidth = MediaQuery.of(context).size.width;
          double fontSize = screenWidth < 600 ? 8.0 : 18;
          // Smaller font for mobile
          if (constraints.maxWidth > 600) {
            // Web or large screen: horizontal split
            return Row(
              children: [
                // Left side: Login form
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: LoginForm(),
                  ),
                ),
                // Right side: Logo
                Expanded(


                  child: Center(

                    child: Logo(),
                  ),
                ),
              ],
            );
          } else {
            // Mobile: vertical split
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top half: Login form
                Expanded(
                  child: Center(
                    child: Logo(),
                  ),
                ),
                // Bottom half: Logo
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: LoginForm(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back!',style: TextStyle(fontSize: 25.0),),
        Text('Enter your Credentials to access your account',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
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
        ),
        SizedBox(height: 10),
        Text('Password',style: TextStyle(fontWeight: FontWeight.bold),),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0)
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
        ),
        SizedBox(height: 30),
        CustomButton(label: "login",onPressed: () {},)
      ],
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,  // Replace with your image path
      width: 200,
      height: 200,
    );
  }
}