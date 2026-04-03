import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FAQ"), centerTitle: true),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Text(
              "Q: How do I place an order?\n"
              "A: Browse plants, add to cart, and proceed to checkout.",
            ),
            SizedBox(height: 12),

            Text(
              "Q: How can I track my order?\n"
              "A: Go to 'My Orders' section to view order status.",
            ),
            SizedBox(height: 12),

            Text(
              "Q: Can I cancel my order?\n"
              "A: Yes, you can cancel before it is shipped.",
            ),
            SizedBox(height: 12),

            Text(
              "Q: Do you offer refunds?\n"
              "A: Yes, refunds are available based on our return policy.",
            ),
            SizedBox(height: 12),

            Text(
              "Q: How do I contact support?\n"
              "A: Use the FAQ or email our support team via the app.",
            ),
          ],
        ),
      ),
    );
  }
}
