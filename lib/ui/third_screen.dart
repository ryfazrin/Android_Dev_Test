import 'package:android_dev_test/api/api_service.dart';
import 'package:android_dev_test/provider/users_provider.dart';
import 'package:android_dev_test/widgets/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Third Screen'),
      ),
      child: ChangeNotifierProvider<UsersProvider>(
        create: (_) => UsersProvider(apiService: ApiService()),
        child: SafeArea(
          child: Consumer<UsersProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return CustomScrollView(
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future<void>.delayed(
                          const Duration(milliseconds: 1000));
                    },
                  ),
                  // padding: const EdgeInsets.symmetric(
                  //     vertical: 15.0, horizontal: 20.0),
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
