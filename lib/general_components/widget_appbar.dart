import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loakulukota_app/constant.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textIconColor;
  final String? icon;
  final String? title;
  final double? height;
  final List<Widget>? menuItem;
  final bool hideBack;

  WidgetAppBar({
    this.backgroundColor = kMainColor,
    this.textIconColor = Colors.white,
    this.icon,
    this.title = '',
    this.menuItem,
    this.height: kToolbarHeight,
    this.hideBack = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: menuItem,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: textIconColor,
      ),
      leading: hideBack
          ? Container()
          : icon == null
              ? const Padding(padding: EdgeInsets.all(25.0), child: BackButton(),)
              : IconButton(
                  icon: Image.asset(
                    icon!,
                    height: 18,
                    width: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
      title: Padding(padding: EdgeInsets.all(25.0), child: Text(
        title!,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textIconColor,
        ),
      ),),
      backgroundColor: backgroundColor,
      centerTitle: false,
    );
  }
}
