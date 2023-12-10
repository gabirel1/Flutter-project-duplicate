import 'package:flutter/material.dart';
import 'package:my_app/Tools/color.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _MyAppBarState extends State<MyAppBar> {
  String searchItem = '';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColor.myBlue,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              MyColor.myGreen,
              MyColor.myBlue,
            ],
            stops: const <double>[0, 1],
            begin: AlignmentDirectional.centerEnd,
            end: AlignmentDirectional.bottomStart,
          ),
        ),
      ),
      title: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: MyColor.myWhite,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
              child: Icon(
                Icons.search_outlined,
                color: MyColor.myBlack,
                size: 32,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search Item...',
                    labelStyle: TextStyle(
                      color: MyColor.myBlack,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      searchItem = value;
                    });
                    debugPrint('searchItem : $searchItem');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 8, 4),
              child: Icon(
                Icons.qr_code_outlined,
                color: MyColor.myBlack,
                size: 32,
              ),
            ),
          ],
        ),
      ),
      centerTitle: false,
      elevation: 2,
    );
  }
}
