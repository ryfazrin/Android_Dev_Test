import 'package:android_dev_test/ui/third_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String username;
  const SecondScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? user;

  @override
  Widget build(BuildContext context) {
    void _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ThirdScreen()),
      );

      setState(() {
        user = result;
      });
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Second Screen'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.username,
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ],
              ),
              Center(
                child: Text(
                  user != null ? user! : "Selected User Name",
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                  },
                  child: const Text("Choose a User"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
