import 'package:android_dev_test/api/api_service.dart';
import 'package:android_dev_test/provider/users_provider.dart';
import 'package:android_dev_test/widgets/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final UsersProvider userProvider = UsersProvider(apiService: ApiService());
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    var maxScroll = controller.position.maxScrollExtent;
    var currentPosition = controller.position.pixels;
    if (currentPosition == maxScroll) {
      userProvider.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Third Screen'),
      ),
      child: ChangeNotifierProvider<UsersProvider>.value(
        value: userProvider,
        child: SafeArea(
          child: Consumer<UsersProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return CustomScrollView(
                controller: controller,
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future<void>.delayed(
                          const Duration(milliseconds: 1000));
                      setState(() {});
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var user = state.result.data[index];
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
              return const Center(child: Text(''));
            }
          }),
        ),
      ),
    );
  }
}
