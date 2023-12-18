import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Pages/home_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/qr_code_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';

class QRCodeData {
  QRCodeData({
    required this.key,
    required this.iv,
    required this.encrypted,
  });

  factory QRCodeData.fromJson(Map<String, dynamic> json) {
    return QRCodeData(
      key: json['key'],
      iv: json['iv'],
      encrypted: json['encrypted'],
    );
  }
  String key;
  String iv;
  String encrypted;
}

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => QrCodeState();
}

class QrCodeState extends State<QrCode> {
  final GlobalKey<State<StatefulWidget>> qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;
  late QrCodeViewModel qrViewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QrCodeViewModel>(
      converter: (Store<AppState> store) => QrCodeViewModel.factory(
        store,
        FirestoreService(),
      ),
      builder: (BuildContext context, QrCodeViewModel viewModel) {
        setState(() => qrViewModel = viewModel);
        return SafeArea(
          child: Scaffold(
            appBar: buildCustomAppBar(),
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                buildQrView(context, viewModel),
                Positioned(bottom: 10, child: buildResult()),
              ],
            ),
          ),
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

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColor().myWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MyColor().myBlue),
        ),
        child: Text(
          barcode != null
              ? 'Result : ${barcode!.code.toString()}'
              : 'Scan a code!',
          maxLines: 3,
          style: TextStyle(color: MyColor().myBlack),
        ),
      );

  Widget buildQrView(BuildContext context, QrCodeViewModel viewModel) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: MyColor().myBlue,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(
      (Barcode barcode) => setState(
        () async {
          this.barcode = barcode;

          debugPrint(this.barcode.toString());
          qrViewModel.setItemId(this.barcode);
          // await Navigator.of(context).pushReplacement(
          //   // MaterialPageRoute<void>(
          //   //   builder: (BuildContext context) => const ArticlePage(
          //   //     item: item,
          //   //   ),
          //   // ),
          // );
          controller.dispose();
        },
      ),
    );
  }
}
