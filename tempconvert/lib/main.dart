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
        primarySwatch: Colors.lightBlue,
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
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Conversion',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightBlue),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'Fahrenheit to Celsius',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                  const Text('Fahrenheit to Celsius', style: TextStyle(fontSize: 18, color: Colors.black87)),
                  Radio<String>(
                    value: 'Celsius to Fahrenheit',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                  const Text('Celsius to Fahrenheit', style: TextStyle(fontSize: 18, color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter Temperature',
                  labelStyle: const TextStyle(color: Colors.lightBlue),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.thermostat, color: Colors.lightBlue),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _convertTemperature,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
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
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Conversion History',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightBlue),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history, color: Colors.lightBlue),
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
    );
  }
}
