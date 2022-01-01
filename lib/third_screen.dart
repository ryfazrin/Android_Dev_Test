import 'package:android_dev_test/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Third Screen',
          // style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView(
            children: [
              CupertinoListTile(
                leading: Image.asset(
                  "assets/background.png",
                  width: 100,
                  height: 100,
                ),
                title: "Test",
                subtitle: "sub",
                trailing: Text('trailing'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoListTile extends StatefulWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Function() onTap;

  const CupertinoListTile(
      {Key? key,
      required this.leading,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.onTap})
      : super(key: key);

  @override
  _StatefulStateCupertino createState() => _StatefulStateCupertino();
}

class _StatefulStateCupertino extends State<CupertinoListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                widget.leading,
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    Text(widget.subtitle,
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 16,
                        )),
                  ],
                ),
              ],
            ),
            widget.trailing,
          ],
        ),
      ),
    );
  }
}
