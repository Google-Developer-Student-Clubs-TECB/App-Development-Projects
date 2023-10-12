import 'package:flutter/material.dart';

void main() {
  runApp(TextEditorApp());
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> savedTexts = [];

  void navigateToEditor() async {
    final newText = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextEditorScreen(),
      ),
    );
    if (newText != null && newText.isNotEmpty) {
      setState(() {
        savedTexts.add(newText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Idea!'),
      ),
      body: ListView.builder(
        itemCount: savedTexts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(savedTexts[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToEditor,
        child: Icon(Icons.edit),
      ),
    );
  }
}

class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;

  void saveAndReturn() {
    final newText = textEditingController.text;
    Navigator.pop(context, newText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save your Idea!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isBold = !isBold;
                        });
                      },
                      child: Text('Bold'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isItalic = !isItalic;
                        });
                      },
                      child: Text('Italic'),
                    ),
                  ],
                ),
              ),
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: saveAndReturn,
              child: Text('Save and Return'),
            ),
          ],
        ),
      ),
    );
  }
}
