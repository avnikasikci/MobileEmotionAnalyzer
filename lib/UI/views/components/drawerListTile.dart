import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/Base/IBaseState.dart';

// ignore: must_be_immutable
class DrawerListTile extends StatelessWidget with IBaseState {
  final String title;
  final IconData icon;

  DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: colorConstants.white),
      ),
      leading: Icon(
        icon,
        color: colorConstants.white.withOpacity(0.8),
      ),
    );
  }
}
