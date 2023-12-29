import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/seller_view_model.dart';
import 'package:my_app/Tools/color.dart';

/// The basket page
class SellerPage extends StatefulWidget {
  /// The basket page
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => SellerPageState();
}

class ApiImage {
  final String imageUrl;
  final String id;

  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

/// The basket page state
class SellerPageState extends State<SellerPage> {
  /// form key
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SellerViewModel>(
      converter: SellerViewModel.factory,
      builder: (BuildContext context, SellerViewModel viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Sell item',
            ),
            centerTitle: false,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate() && await viewModel.validateForm(_formKey.currentState?.instantValue)) {
                    _formKey.currentState?.reset();
                    await buildShowDialogSuccessful();
                  } else {
                    await buildShowDialogError();
                  }
                },
                child: const Row(
                  children: <Widget>[
                    Text('Submit'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.sell_sharp),
                  ],
                ),
              ),
            ],
            automaticallyImplyLeading: false,
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
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: 'Name',
                      decoration: const InputDecoration(
                        labelText: 'Article name',
                      ),
                      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
                      FormBuilderValidators.required(),
                    ]),
                    ),
                    FormBuilderTextField(
                      name: 'Price',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        (String? val) {
                          final double? number = double.tryParse(val!);
                          if (number == null) return null;
                          if (number < 0) return 'Price cannot be negative';
                          return null;
                        },
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'Description',
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderImagePicker(
                      name: 'photos',
                      decoration: const InputDecoration(labelText: 'Pick Photos'),
                      maxImages: 5,
                      previewMargin: const EdgeInsetsDirectional.only(end: 8),
                      validator: FormBuilderValidators.compose(<FormFieldValidator<List<dynamic>>>[
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Widget Future show dialog order placed
  Future<dynamic> buildShowDialogSuccessful() => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      Future<void>.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.of(context).pop(true);
        }
      });
      return AlertDialog(
        title: const Text(
          'Item successfully added to market',
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: MyColor().myGrey,
      );
    },
  );

  /// Widget Future show dialog order placed
  Future<dynamic> buildShowDialogError() => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      Future<void>.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.of(context).pop(true);
        }
      });
      return AlertDialog(
        title: const Text(
          'Invalid form',
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
