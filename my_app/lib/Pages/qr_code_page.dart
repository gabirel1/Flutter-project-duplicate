import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/qr_code_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';

/// class QRCodeData
class QRCodeData {
  /// QRCodeData
  QRCodeData({
    required this.key,
    required this.iv,
    required this.encrypted,
  });

  /// factory QRCodeData
  factory QRCodeData.fromJson(Map<String, dynamic> json) {
    return QRCodeData(
      key: json['key'],
      iv: json['iv'],
      encrypted: json['encrypted'],
    );
  }

  /// variable key
  String key;

  /// variable iv
  String iv;

  /// variable encrypted
  String encrypted;
}

/// class QrCode
class QrCode extends StatefulWidget {
  /// QrCode
  const QrCode({super.key});

  @override
  State<QrCode> createState() => QrCodeState();
}

/// class QrCodeState
class QrCodeState extends State<QrCode> {
  /// variable qrKey
  final GlobalKey<State<StatefulWidget>> qrKey = GlobalKey(debugLabel: 'QR');

  /// variable barcode
  Barcode? barcode;

  /// variable controller
  QRViewController? controller;

  /// variable qrViewModel
  late QrCodeViewModel qrViewModel;

  /// variable qrItem
  late Item qrItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QrCodeViewModel>(
      converter: (Store<AppState> store) => QrCodeViewModel.factory(
        store,
        FirestoreService(),
      ),
      builder: (BuildContext context, QrCodeViewModel viewModel) {
        qrViewModel = viewModel;
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

  /// Widget buildResult Container
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

  /// Widget buildQrView QRView
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

  /// Function onQRViewCreated which create the view for the QrCode
  ///
  /// @param [controller] the controller of the QRView
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen(
      (Barcode barcode) async {
        debugPrint('barcode : ${barcode.code}');
        if (barcode.code!.isEmpty) {
          controller.dispose();
          return;
        }
        await qrViewModel.setItemId(barcode.code);
        final Item tmp = await qrViewModel.loadItem();
        if (mounted) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return ArticlePage(
                  item: tmp,
                );
              },
            ),
          );
        }
        setState(
          () {
            this.barcode = barcode;
            controller.dispose();
          },
        );
      },
    );
  }
}
