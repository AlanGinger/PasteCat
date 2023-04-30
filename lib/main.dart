import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(PasteCat());
}

class PasteCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PasteCat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PasteCatHomePage(),
    );
  }
}

class PasteCatHomePage extends StatefulWidget {
  @override
  _PasteCatHomePageState createState() => _PasteCatHomePageState();
}

class _PasteCatHomePageState extends State<PasteCatHomePage> {
  String clipboardContent = '';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PasteCat'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn.midjourney.com/73ce2612-cbf8-4aad-ae77-66358eaac62b/0_1.webp',
                  width: 150,
                ),
                SizedBox(height: 16),
                Text(
                  'PasteCat',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    FlutterClipboard.copy(textController.text);
                  },
                  child: Text('Copy to Clipboard'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String clipboardText = await FlutterClipboard.paste();
                    setState(() {
                      textController.text = clipboardText;
                    });
                  },
                  child: Text('Paste from Clipboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
