import 'package:flutter/cupertino.dart';

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
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                widget.leading,
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    Text(widget.subtitle,
                        style: const TextStyle(
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
