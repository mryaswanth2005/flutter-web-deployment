import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _displayedColor = Colors.white; // Default container color
  final TextEditingController _controller = TextEditingController();
  String _enteredColorCode = ''; // To store and display the entered color code

  void _updateColorContainer(String colorCode) {
    try {
      // Remove '#' if present and add '0xFF' to the start
      String newColorCode = colorCode.replaceAll('#', '');
      Color newColor = Color(int.parse('0xFF$newColorCode'));
      setState(() {
        _displayedColor = newColor;
        _enteredColorCode = colorCode; // Store the entered color code
      });
    } catch (e) {
      print('Invalid color code');
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: 'Color(0xff$_enteredColorCode)'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Color code copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter The Figma color code Color Code (e.g., #FF5733)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateColorContainer(_controller.text); // Update the container's color
                },
                child: Text('Show Color in Container'),
              ),
              SizedBox(height: 20),
              // Display the entered HEX color code and show the color
              if (_enteredColorCode.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _displayedColor, // Show the user-selected color in the container
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Color: Color(0xff$_enteredColorCode),',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: _copyToClipboard, // Copy to clipboard on click
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        _enteredColorCode,
                        style: TextStyle(fontSize: 18, color: Colors.black), // Show the HEX code
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
