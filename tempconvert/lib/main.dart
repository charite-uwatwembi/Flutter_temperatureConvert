import 'package:flutter/material.dart';

void main() {
  runApp(const TempConvertApp());
}

class TempConvertApp extends StatelessWidget {
  const TempConvertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: const TempConvertHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TempConvertHome extends StatefulWidget {
  const TempConvertHome({Key? key}) : super(key: key);

  @override
  _TempConvertHomeState createState() => _TempConvertHomeState();
}

class _TempConvertHomeState extends State<TempConvertHome> {
  String _selectedConversion = 'Fahrenheit to Celsius';
  String? _convertedTemperature;
  final List<String> _history = [];
  final TextEditingController _controller = TextEditingController();

  void _convertTemperature() {
    double? inputTemp = double.tryParse(_controller.text);
    if (inputTemp == null) return;

    double convertedTemp;
    String result;
    if (_selectedConversion == 'Fahrenheit to Celsius') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      result = '${inputTemp.toStringAsFixed(1)}°F = ${convertedTemp.toStringAsFixed(2)}°C';
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      result = '${inputTemp.toStringAsFixed(1)}°C = ${convertedTemp.toStringAsFixed(2)}°F';
    }

    setState(() {
      _convertedTemperature = convertedTemp.toStringAsFixed(2);
      _history.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.thermostat, size: 100, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  'Select Conversion',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('F to C'),
                          value: 'Fahrenheit to Celsius',
                          groupValue: _selectedConversion,
                          onChanged: (value) {
                            setState(() {
                              _selectedConversion = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('C to F'),
                          value: 'Celsius to Fahrenheit',
                          groupValue: _selectedConversion,
                          onChanged: (value) {
                            setState(() {
                              _selectedConversion = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'C stands for Celsius and F stands for Fahrenheit',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter Temperature',
                    labelStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.thermostat, color: Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _convertTemperature,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  icon: const Icon(Icons.sync_alt),
                  label: const Text('Convert'),
                ),
                if (_convertedTemperature != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Converted Temperature: $_convertedTemperature',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
                const SizedBox(height: 20),
                const Text(
                  'Conversion History',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 150, // Fixed height for the history list
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                  ),
                  child: ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.history, color: Colors.green),
                        title: Text(
                          _history[index],
                          style: const TextStyle(color: Colors.black87),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
