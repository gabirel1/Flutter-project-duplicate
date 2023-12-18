import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/article_view_model.dart';
import 'package:my_app/Tools/color.dart';

/// The article page
class ArticlePage extends StatefulWidget {
  /// ArticlePage
  const ArticlePage({required this.item, super.key});

  /// variable item
  final Item item;

  @override
  State<ArticlePage> createState() => ArticlePageState();
}

/// The article page state
class ArticlePageState extends State<ArticlePage> {
  /// The article page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  /// The boolean to know if the item is in the basket
  bool isInBasket = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ArticleViewModel>(
      converter: ArticleViewModel.factory,
      builder: (BuildContext context, ArticleViewModel viewModel) {
        return Scaffold(
          key: drawerScaffoldKey,
          appBar: buildCustomAppBar(),
          body: SingleChildScrollView(
            child: Column(
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
                const Divider(),
                if (widget.item.images.length > 1)
                  buildCarousel()
                else
                  buildImage(),
                const Divider(),
                buildDescription(),
                buildSeller(),
                buildIconCart(viewModel),
              ],
            ),
          ),
          backgroundColor: MyColor().myWhite,
        );
      },
    );
  }

  /// PreferredSizeWidget custom appBar AppBar
  PreferredSizeWidget buildCustomAppBar() => AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                MyColor().myGreen,
                MyColor().myBlue,
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
            color: MyColor().myBlack,
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
          height: 300,
          child: CarouselSlider(
            items: widget.item.images.map((String image) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image.isNotEmpty
                      ? image
                      : 'https://www.fluttercampus.com/img/4by3.webp',
                  width: 200,
                  height: 300,
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

  /// Widget image Padding
  Widget buildImage() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.item.images[0].isNotEmpty
                ? widget.item.images[0]
                : 'https://www.fluttercampus.com/img/4by3.webp',
            width: 200,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      );

  /// Widget descritpion Padding
  Widget buildDescription() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Text(
          widget.item.description,
        ),
      );

  /// Widget seller Padding
  Widget buildSeller() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Text(
          widget.item.seller,
        ),
      );

  /// Widget icon cart Padding
  Widget buildIconCart(ArticleViewModel viewModel) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: GestureDetector(
          onTap: () async {
            viewModel.addCart(widget.item);
            await buildShowDialogAddedCart();
          },
          child: const Icon(
            Icons.add_shopping_cart_outlined,
            size: 48,
          ),
        ),
      );

  /// Widget Future show dialog Error
  Future<dynamic> buildShowDialogAddedCart() => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Article added to cart',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: MyColor().myGrey,
          );
        },
      );
}
