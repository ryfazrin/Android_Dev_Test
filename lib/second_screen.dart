import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Second Screen',
          // style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text("John Doe",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navTitleTextStyle),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Selected User Name",
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  onPressed: () {},
                  child: Text("Choose a User"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
