import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFChallan {
  Future<void> generateChallan(String vehicleNumber, String ownerName, double amount) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('E-Parking Challan', style: pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Text('Vehicle Number: $vehicleNumber'),
                pw.Text('Owner Name: $ownerName'),
                pw.Text('Amount: \$${amount.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file (this part will depend on your file handling implementation)
    // For example, you can use the path_provider package to get the directory to save the file.
  }
}
