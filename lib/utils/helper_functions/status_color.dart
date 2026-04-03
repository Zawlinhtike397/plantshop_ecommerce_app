import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.blueGrey;
    case 'processing':
      return Colors.cyan;
    case 'shipping':
      return Colors.orange;
    case 'delivered':
      return Colors.green;
    case 'canceled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
