import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
enum ButtonState {
  on, off, loading
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  ButtonState buttonState;

  void addFavorite() async{
    ButtonState temp = buttonState;
    print("before: $buttonState");
    setState(() {
      buttonState = ButtonState.loading;
      _button = CircularProgressIndicator();
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      buttonState = temp == ButtonState.off ? ButtonState.on : ButtonState.off;
      _button = IconButton(
        iconSize: 32,
        icon: buttonState == ButtonState.off
            ? Icon(Icons.favorite_border, color: Colors.teal,)
            : Icon(Icons.favorite, color: Colors.red,),
        onPressed: addFavorite,
      );
    });
  print("$buttonState,$temp");
  }
  Widget _button;

  Animation<double> animate;

  @override
  void initState() {
    buttonState = ButtonState.off;

    _button = IconButton(
      iconSize: 32,
      icon: buttonState == ButtonState.off
          ? Icon(Icons.favorite_border, color: Colors.teal,)
          : Icon(Icons.favorite, color: Colors.red,),
      onPressed: () async=> addFavorite(),
    );
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
  _scaleAnimation = Tween<double>(
    begin: 0.2,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.35,
        0.7,
        curve: OvershootCurve(),
      ),
    ),
  );
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:   AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (button, scaleAnimation) =>
              ScaleTransition(child: button, scale: scaleAnimation,),
          child: _button,
        ),
      ),
    );
  }
}
