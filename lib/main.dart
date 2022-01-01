import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: Color(0xFF2B637B),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/btn_add_photo.png", width: 116),
                SizedBox(height: 58.0),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  placeholder: "Name",
                  padding: EdgeInsets.only(
                    top: 7.94,
                    bottom: 7.94,
                    left: 20,
                    right: 16,
                  ),
                ),
                SizedBox(height: 22.0),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  placeholder: "Polindrome",
                  padding: EdgeInsets.only(
                    top: 7.94,
                    bottom: 7.94,
                    left: 20,
                    right: 16,
                  ),
                ),
                SizedBox(height: 45.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    onPressed: () {},
                    child: Text("CHECK"),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    onPressed: () {},
                    child: Text("NEXT"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
