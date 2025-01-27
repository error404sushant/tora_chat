
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tora_chat/features/app.dart';
import 'package:tora_chat/model/coin_detail/coin_detail.dart';
import 'package:tora_chat/services/storage_service/storage_service_box.dart';
// import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Platform check for non-web platforms
  if (!kIsWeb) {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path); // Initialize Hive with the documents directory
    //Register adapter
    //Coin detail adapter
     Hive.registerAdapter(CoinDetailAdapter());
     //Open box
    await Hive.openBox<CoinDetail>(StorageServiceBox.coinInfoBox);
  } else {
    Hive.init('web_hive'); // Use a fallback for web
  }



  runApp(
      kIsWeb
      ? const App():
      // : DevicePreview(
      //     enabled: !kReleaseMode,
      //     builder: (context) => const App(), // Wrap your app
      //   )
      const App()
  );






}
