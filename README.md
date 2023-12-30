# M-MOB-900-PAR-9-1-flutterproject-guillaume.robin

## Description

Our application "C'est toi le flutter" is an amazon like application. 
"C'est Toi Le Flutter" is a straightforward app for viewing, adding items to your basket, and making purchases.
Browse through articles and easily select what you want. Simplify your shopping with "C'est Toi Le Flutter."

## Getting Started

### Setup Flutter :
A detailed guide for multiple platforms setup could be find :
https://flutter.dev/docs/get-started/install/

### Setup Android Studio :
A detailed guide for multiple platforms setup could be find :
https://developer.android.com/studio/install

### Launching App :

1) connect your phone with adb (https://developer.android.com/studio/command-line/adb) or generate an emulator with android studio
2) run 'dart run build_runner build' to generate the files for redux
3) go to the file "pubspec.yaml" and clic on "pub get" to get all the dependances or run 'flutter pub get'
4) go to the file "main.dart" and run the app with "Shift+F10" or run 'flutter run'

## Project Structure

```
├── Elements
│   ├── app_bar.dart
│   └── bottom_navigation_bar.dart
├── firebase_options.dart
├── main.dart
├── Models
│   ├── dialog_notif.dart
│   ├── item.dart
│   ├── my_error.dart
│   ├── my_orders.dart
│   ├── order_item.dart
│   └── user_infos.dart
├── Pages
│   ├── article_page.dart
│   ├── authentication_page.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── MainPages
│   │   ├── basket_page.dart
│   │   ├── market_page.dart
│   │   └── profile_page.dart
│   ├── qr_code_page.dart
│   ├── register_page.dart
│   └── seller_page.dart
├── Repository
│   └── firestore_service.dart
├── Store
│   ├── Actions
│   │   ├── article_actions.dart
│   │   ├── authentication_actions.dart
│   │   ├── basket_actions.dart
│   │   ├── home_actions.dart
│   │   ├── market_actions.dart
│   │   ├── profile_actions.dart
│   │   ├── qr_code_actions.dart
│   │   └── search_actions.dart
│   ├── Reducers
│   │   ├── app_reducer.dart
│   │   ├── article_reducer.dart
│   │   ├── authentication_reducer.dart
│   │   ├── basket_reducer.dart
│   │   ├── home_reducer.dart
│   │   ├── market_reducer.dart
│   │   ├── profile_reducer.dart
│   │   ├── qr_code_reducer.dart
│   │   └── search_reducer.dart
│   ├── State
│   │   ├── app_state.dart
│   │   ├── article_state.dart
│   │   ├── authentication_state.dart
│   │   ├── basket_state.dart
│   │   ├── home_state.dart
│   │   ├── market_state.dart
│   │   ├── profile_state.dart
│   │   ├── qr_code_state.dart
│   │   └── search_state.dart
│   └── ViewModels
│       ├── article_view_model.dart
│       ├── authentication_view_model.dart
│       ├── basket_view_model.dart
│       ├── home_view_model.dart
│       ├── market_view_model.dart
│       ├── profile_view_model.dart
│       ├── qr_code_view_model.dart
│       ├── search_view_model.dart
│       └── seller_view_model.dart
└── Tools
    ├── color.dart
    └── utils.dart
```

## Libraires

```
- carousel_slider: ^4.2.1            # for the image carousel in the article page
- cloud_firestore: ^4.13.2           # for interacting with Google Cloud Firestore, offering real-time data synchronization in Flutter applications
- cupertino_icons: ^1.0.2            # for providing the Cupertino icon set, enabling the use of iOS-style icons in Flutter applications

- email_validator: ^2.1.17           # for facilitating email validation, allowing developers to validate email addresses in Flutter applications
- firebase_auth: ^4.14.1             # for providing authentication services using Firebase Authentication, allowing developers to integrate user authentication, including email/password, Google Sign-In, and more, into their Flutter applications
- firebase_core: ^2.22.0             # for serving as the core package for Firebase services, providing initialization and configuration functionalities required for using various Firebase plugins in Flutter applications
- firebase_crashlytics: ^3.4.8       # for integrating Firebase Crashlytics, a powerful crash reporting tool, into Flutter applications, enabling developers to track and analyze app crashes for improved stability and debugging
- firebase_storage: ^11.5.6          # for providing easy access to Firebase Cloud Storage, allowing users to store and retrieve files in the cloud

- flutter_form_builder: ^9.1.1       # for simplifying the process of creating and managing forms by offering a set of pre-built form fields and functionalities
- flutter_redux: ^0.10.0             # for integrating Redux into Flutter, enhancing state management for more predictable and maintainable app logic
- form_builder_image_picker: ^4.0.0  # for facilitating image selection within forms, making it easier to integrate image pickers into Flutter applications
- form_builder_validators: ^9.1.0    # for providing a collection of pre-built validators for form fields, streamlining the process of validating user input in Flutter forms
- google_sign_in: ^6.1.6             # for integrating Google Sign-In functionality into Flutter applications
- image_picker: ^0.8.7+4             # for enabling developers to easily access and pick images or videos from the device's gallery or camera, facilitating media selection within Flutter applications
- json_annotation: ^4.8.1            # for streamlines JSON serialization in Flutter by generating code for Dart classes, simplifying data integration
- qr_code_scanner: ^1.0.1            # for the qr code scanner in the qr_code page
- redux: ^5.0.0                      # for predictable state management in Flutter
- redux_logging: ^0.5.1              # for providing logging middleware for easy debugging in Flutter applications using Redux
- rive: ^0.12.4                      # for allowing developers to integrate interactive and dynamic vector animations into their applications, enhancing the visual appeal and user experience
- uuid: ^4.2.2                       # for generating universally unique identifiers (UUIDs), which are often used for uniquely identifying objects or entities in software applications
```
