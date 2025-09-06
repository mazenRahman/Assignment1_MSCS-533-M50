import 'package:flutter/material.dart';

void main() {
  runApp(ConversionApp());
}

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metric ↔ Imperial Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController _valueController = TextEditingController();

  String _selectedConversion = "Kilograms ↔ Pounds";
  String _result = "";

  final List<String> _conversionOptions = [
    "Kilograms ↔ Pounds",
    "Miles ↔ Kilometers",
    "Meters ↔ Feet",
  ];

  void _convert() {
    final input = double.tryParse(_valueController.text);
    if (input == null) {
      setState(() => _result = "Enter a valid number!");
      return;
    }

    double convertedValue = 0.0;
    String unit = "";

    switch (_selectedConversion) {
      case "Kilograms ↔ Pounds":
        convertedValue = input * 2.20462; // kg → lbs
        unit = "lbs";
        break;

      case "Miles ↔ Kilometers":
        convertedValue = input * 1.60934; // miles → km
        unit = "km";
        break;

      case "Meters ↔ Feet":
        convertedValue = input * 3.28084; // meters → feet
        unit = "ft";
        break;
    }

    setState(() {
      _result = "$input → ${convertedValue.toStringAsFixed(2)} $unit";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Metric ↔ Imperial Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedConversion,
              isExpanded: true,
              items: _conversionOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                  _result = "";
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter value to convert",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _convert, child: Text("Convert")),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
