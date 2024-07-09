import 'package:flutter/material.dart';

void main() {
  runApp(const TempConvertApp());
}

class TempConvertApp extends StatelessWidget {
  const TempConvertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TempConvert',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: const TempConvertHome(),
      debugShowCheckedModeBanner: false, // This line removes the debug banner
    );
  }
}

class TempConvertHome extends StatefulWidget {
  const TempConvertHome({Key? key}) : super(key: key);

  @override
  _TempConvertHomeState createState() => _TempConvertHomeState();
}

class _TempConvertHomeState extends State<TempConvertHome> {
  String _selectedConversion = 'F to C';
  String? _convertedTemperature;
  final List<String> _history = [];
  final TextEditingController _controller = TextEditingController();

  void _convertTemperature() {
    double? inputTemp = double.tryParse(_controller.text);
    if (inputTemp == null) return;

    double convertedTemp;
    String result;
    if (_selectedConversion == 'F to C') {
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
        title: const Text('TempConvert', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select Conversion',
              style: TextStyle(fontSize: 20, color: Colors.lightBlue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('F to C', style: TextStyle(fontSize: 16, color: Colors.black87)),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('C to F', style: TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(color: Colors.lightBlue),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Convert'),
            ),
            if (_convertedTemperature != null) ...[
              const SizedBox(height: 16),
              Text(
                'Converted Temperature: $_convertedTemperature',
                style: const TextStyle(fontSize: 20, color: Colors.lightBlue),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'History',
              style: TextStyle(fontSize: 20, color: Colors.lightBlue),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
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
    );
  }
}
