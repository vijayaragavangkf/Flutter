import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _textList = List.generate(100, (index) => "Item_$index");

  TextEditingController _textController;
  ScrollController _scrollController;

  @override
  void initState() {
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _scrollToBottom();
    super.initState();
  }

  bool _addText(context, String text) {
    if (text?.isNotEmpty == true) {
      setState(() {
        _textList.add(text);
        _scrollToBottom();
      });
      return true;
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Text Entered"),
          behavior: SnackBarBehavior.fixed,
        ),
      );
      return false;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance
      ..addPostFrameCallback((x) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: _textList.length,
                separatorBuilder: (_, __) => Divider(height: 1.0),
                itemBuilder: (context, index) => ListTile(
                  title: Text("${_textList[index]}"),
                ),
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Material(
      elevation: 5.0,
      color: Colors.blue[100],
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Enter Text",
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                border: InputBorder.none,
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final success = _addText(context, _textController.text);
                if (success) _textController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
