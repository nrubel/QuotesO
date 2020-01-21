import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuoteO',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: QuoteOHomepage(title: 'Flutter Demo Home Page'),
    );
  }
}

class QuoteOHomepage extends StatefulWidget {
  QuoteOHomepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuoteOHomepageState createState() => _QuoteOHomepageState();
}

class _QuoteOHomepageState extends State<QuoteOHomepage> {
  Map _data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuote();
  }

  void getQuote() async {
    try {
      Response response =
          await Dio().get("https://api.kanye.rest/"); // ?format=text
      print(response);
      setState(() {
        _data = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .6,
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.all(30.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Center(
                    child: _data.isNotEmpty
                        ? Text(
                            _data['quote'],
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
//                color: Colors.indigoAccent,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getQuote,
        tooltip: 'New Quote',
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        shape: CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: Icon(Icons.menu),
                onPressed: () {
                  print('menu clicked');
                },
              ),
              Spacer(),
              IconButton(
                tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                icon: Icon(Icons.search),
                onPressed: () {
                  print('menu clicked');
                },
              ),
              IconButton(
                tooltip: MaterialLocalizations.of(context).alertDialogLabel,
                icon: Icon(Icons.favorite),
                onPressed: () {
                  print('menu clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
