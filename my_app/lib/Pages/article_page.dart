import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Tools/color.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({required this.item, required this.index, super.key});
  final Item item;
  final int index;

  @override
  State<ArticlePage> createState() => ArticlePageState();
}

class ArticlePageState extends State<ArticlePage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerScaffoldKey,
      appBar: buildCustomAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              children: <Widget>[
                buildTitle(),
                buildPrice(),
              ],
            ),
          ),
          buildCarousel(),
          buildDescription(),
          buildSeller(),
          buildIconCart(),
        ],
      ),
      backgroundColor: MyColor.myWhite,
    );
  }

  /// PreferredSizeWidget custom appBar AppBar
  PreferredSizeWidget buildCustomAppBar() => AppBar(
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: MyColor.myBlack,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

  /// Widget title Expanded
  Widget buildTitle() => Expanded(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Text(
            widget.item.title.toString(),
            textAlign: TextAlign.start,
          ),
        ),
      );

  /// Widget price Expanded
  Widget buildPrice() => Expanded(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Text(
            '${widget.item.price.toString()} €',
            textAlign: TextAlign.end,
          ),
        ),
      );

  /// Widget carousel Padding
  Widget buildCarousel() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: SizedBox(
          width: double.infinity,
          height: 180,
          child: CarouselSlider(
            items: widget.item.images.map((String image) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image.isNotEmpty
                      ? image
                      : 'https://www.fluttercampus.com/img/4by3.webp',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: 1,
              viewportFraction: 0.5,
              disableCenter: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.25,
            ),
          ),
        ),
      );

  /// Widget descritpion Padding
  Widget buildDescription() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: Text(
          widget.item.description,
        ),
      );

  /// Widget seller Padding
  Widget buildSeller() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: Text(
          widget.item.seller,
        ),
      );

  /// Widget icon cart Padding
  Widget buildIconCart() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: GestureDetector(
          onTap: () {

          },
          child: const Icon(
            Icons.add_shopping_cart_outlined,
            size: 48,
          ),
        ),
      );
}
