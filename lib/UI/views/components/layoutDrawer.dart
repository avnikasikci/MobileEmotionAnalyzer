import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/Constants/ColorConstant.dart';
import 'package:flutter_emotion/UI/controllers/layoutController.dart';
import 'package:flutter_emotion/UI/models/navigationItem.dart';
import 'package:flutter_emotion/UI/views/components/drawerListTile.dart';
import 'package:provider/provider.dart';

Widget LayoutDrawer(BuildContext context) {
  // return Drawer(
  //   child: Consumer<LayoutController>(builder: (context, value, child) {
  //     return Container(
  //       color: ColorConstants.instance.ebonyClay,
  //       child: ListView(
  //         children: [
  //           DrawerHeader(
  //             child: Text(
  //               'MENÜ',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .headline5!
  //                   .copyWith(color: Colors.white),
  //             ),
  //           ),
  //           GestureDetector(
  //             child: DrawerListTile(
  //               title: 'Home',
  //               icon: Icons.home,
  //             ),
  //             onTap: () {
  //               value.changePage(NavigationItem.home.index);
  //               value.setNavigationItem(NavigationItem.home);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           GestureDetector(
  //             child: DrawerListTile(
  //               title: 'Camera Analyzer',
  //               icon: Icons.home,
  //             ),
  //             onTap: () {
  //               value.changePage(NavigationItem.cameraAnalyzer.index);
  //               value.setNavigationItem(NavigationItem.cameraAnalyzer);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           GestureDetector(
  //             child: DrawerListTile(
  //               title: 'Galery Analyzer',
  //               icon: Icons.person,
  //             ),
  //             onTap: () {
  //               value.changePage(NavigationItem.galleryAnalyzer.index);
  //               value.setNavigationItem(NavigationItem.galleryAnalyzer);

  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   }),
  // );

  final padding = EdgeInsets.symmetric(horizontal: 20);

  return Drawer(
    child: Container(
      color: Color.fromRGBO(50, 55, 205, 1),
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  item: NavigationItem.home,
                  text: 'home',
                  icon: Icons.people,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.galleryAnalyzer,
                  text: 'galleryAnalyzer',
                  icon: Icons.favorite_border,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.cameraAnalyzer,
                  text: 'cameraAnalyzer',
                  icon: Icons.camera,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMenuItem(
  BuildContext context, {
  required NavigationItem item,
  required String text,
  required IconData icon,
}) {
  final provider = Provider.of<LayoutController>(context);
  final currentItem = provider.navigationItem;
  final isSelected = item == currentItem;

  final color = isSelected ? Colors.orangeAccent : Colors.white;

  return Material(
    color: Colors.transparent,
    child: ListTile(
      selected: isSelected,
      selectedTileColor: Colors.white24,
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color, fontSize: 16)),
      onTap: () => selectItem(context, item),
    ),
  );
}

void selectItem(BuildContext context, NavigationItem item) {
  final provider = Provider.of<LayoutController>(context, listen: false);
  provider.setNavigationItem(item);
  Navigator.of(context).pop();
}
