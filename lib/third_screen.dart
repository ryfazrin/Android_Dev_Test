import 'package:android_dev_test/api/api_service.dart';
import 'package:android_dev_test/provider/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: ChangeNotifierProvider<UsersProvider>(
        create: (_) => UsersProvider(apiService: ApiService()),
        child: SafeArea(
          child: Consumer<UsersProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return CupertinoScrollbar(
                child: ListView.builder(
                  itemCount: state.result.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var user = state.result.data[index];
                    return CupertinoListTile(
                      leading: Image.network(
                        user.avatar,
                        width: 100,
                        height: 100,
                      ),
                      title: user.firstName + user.lastName,
                      subtitle: user.email,
                      trailing: Text('trailing'),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return SecondScreen();
                        // }));
                      },
                    );
                  },
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          }),
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
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
