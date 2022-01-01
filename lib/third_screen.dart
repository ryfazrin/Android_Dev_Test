import 'package:android_dev_test/api/api_service.dart';
import 'package:android_dev_test/provider/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List dataUsers;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        Provider.of<UsersProvider>(context, listen: false).fetchAllUser(2);
        print(Provider.of<UsersProvider>(context, listen: false).result.data);
        dataUsers.addAll(
            Provider.of<UsersProvider>(context, listen: false).result.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Third Screen',
        ),
      ),
      child: ChangeNotifierProvider<UsersProvider>(
        create: (_) => UsersProvider(apiService: ApiService()),
        child: SafeArea(
          child: Consumer<UsersProvider>(builder: (context, state, _) {
            dataUsers = state.result.data;

            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return CustomScrollView(
                controller: controller,
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future<void>.delayed(Duration(milliseconds: 1000));
                      setState(() {
                        dataUsers;
                      });
                    },
                  ),
                  // padding: const EdgeInsets.symmetric(
                  //     vertical: 15.0, horizontal: 20.0),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var user = dataUsers[index];
                        return CupertinoListTile(
                          leading: ClipOval(
                            child: Image.network(
                              user.avatar,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          title: '${user.firstName} ${user.lastName}',
                          subtitle: user.email,
                          onTap: () {
                            Navigator.pop(
                                context, '${user.firstName} ${user.lastName}');
                          },
                        );
                      },
                      childCount: state.result.data.length,
                    ),
                  ),
                ],
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
  final Function() onTap;

  const CupertinoListTile(
      {Key? key,
      required this.leading,
      required this.title,
      required this.subtitle,
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
        padding: EdgeInsets.all(18.0),
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
          ],
        ),
      ),
    );
  }
}
