import 'package:flutter/material.dart';

void main() {
  runApp(TempConvertApp());
}

class TempConvertApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TempConvert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConvertHome(),
    );
  }
}

class TempConvertHome extends StatefulWidget {
  @override
  _TempConvertHomeState createState() => _TempConvertHomeState();
}

class _TempConvertHomeState extends State<TempConvertHome> {
  String _selectedConversion = 'F to C';
  double? _inputTemperature;
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
        title: Text('TempConvert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select Conversion',
              style: TextStyle(fontSize: 20),
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
                Text('F to C'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('C to F'),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            if (_convertedTemperature != null) ...[
              SizedBox(height: 16),
              Text(
                'Converted Temperature: $_convertedTemperature',
                style: TextStyle(fontSize: 20),
              ),
            ],
            SizedBox(height: 16),
            Text(
              'History',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
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
