// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Payroll Calculator',
      home: PayrollCalculator(),
    );
  }
}

class PayrollCalculator extends StatefulWidget {
  const PayrollCalculator({super.key});

  @override
  _PayrollCalculatorState createState() => _PayrollCalculatorState();
}

class _PayrollCalculatorState extends State<PayrollCalculator> {
  final _grossIncomeController = TextEditingController();
  final _taxRateController = TextEditingController();

  String _result = '';

  void _calculate() {
    final grossIncome = double.tryParse(_grossIncomeController.text);
    final taxRate = double.tryParse(_taxRateController.text);

    if (grossIncome == null ||
        taxRate == null ||
        taxRate < 0 ||
        taxRate > 100) {
      setState(() {
        _result = 'Please enter valid numbers.';
      });
      return;
    }

    final taxAmount = grossIncome * (taxRate / 100);
    final netIncome = grossIncome - taxAmount;

    setState(() {
      _result =
          'Tax Amount: \$${taxAmount.toStringAsFixed(2)}\nNet Income: \$${netIncome.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _grossIncomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gross Income',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _taxRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tax Rate (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
