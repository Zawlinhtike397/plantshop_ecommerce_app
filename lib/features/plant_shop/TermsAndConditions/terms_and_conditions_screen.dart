import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PlantShop Terms & Conditions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Text(
              "1. Introduction\n"
              "Welcome to PlantShop. By using our app, you agree to these terms and conditions.",
            ),
            SizedBox(height: 12),

            Text(
              "2. User Account\n"
              "You are responsible for maintaining the confidentiality of your account and password.",
            ),
            SizedBox(height: 12),

            Text(
              "3. Purchases\n"
              "All purchases made through PlantShop are subject to availability and confirmation of the order price.",
            ),
            SizedBox(height: 12),

            Text(
              "4. Returns & Refunds\n"
              "We offer refunds based on our return policy. Items must be returned in original condition.",
            ),
            SizedBox(height: 12),

            Text(
              "5. Changes to Terms\n"
              "We may update these terms from time to time. Continued use of the app means you accept changes.",
            ),
          ],
        ),
      ),
    );
  }
}
