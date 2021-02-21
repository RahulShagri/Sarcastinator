import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'text_converter.dart';


void main() => runApp(MaterialApp(
  home: Main(),

));

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String convertedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sarcastinator'),
        centerTitle: true,
      ),
      body:
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 270,
                          child: TextFormField(
                            controller: myController,
                            decoration: InputDecoration(
                              hintText: "Enter text here"
                            ),
                            validator: (value)  {
                              if (value.isEmpty)  {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                ),
                Tooltip(
                  message: 'Paste from clipboard',
                  verticalOffset: 20.0,
                  child: IconButton(
                    icon: Icon(Icons.paste),
                    onPressed: () {
                      setState(() async {
                        myController.text = await FlutterClipboard.paste();
                      });
                    },
                    iconSize: 25.0,
                    splashRadius: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox (height: 20.0),
            Builder(
              builder: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: 'Convert text into sarcastic text',
                    verticalOffset: 30.0,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            convertedText = convertText(myController.text);

                            FlutterClipboard.copy(convertedText);

                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('✓   Text converted and copied to clipboard!'),
                              duration: Duration(seconds: 3),
                            ));
                            FocusScope.of(context).unfocus();
                            setState(() {
                            });
                          }
                        },
                        label: Text('Convert'),
                        icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                  Tooltip(
                    message: 'Reset all data',
                    verticalOffset: 30.0,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          myController.text = '';
                          convertedText = '';
                          setState(() {
                          });
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Reset')
                    ),
                  ),
                ],
              ),
            ),
            Divider(
                height: 60.0,
                color: Colors.grey[800]
            ),
            Builder(
              builder: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Converted text:',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Tooltip(
                    message: 'Copy to clipboard',
                    verticalOffset: 20.0,
                    child: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        FlutterClipboard.copy(convertedText);

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('✓   Text copied to clipboard!'),
                          duration: Duration(seconds: 3),
                        ));
                      },
                      iconSize: 25.0,
                      splashRadius: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SelectableText(
                  convertedText,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
