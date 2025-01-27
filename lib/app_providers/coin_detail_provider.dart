import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:tora_chat/features/screens/add_edit_player_info/add_edit_player_screen.dart';
import 'package:tora_chat/features/screens/player_detail/player_detail_screen.dart';
import 'dart:async';
import 'package:tora_chat/model/coin_detail/coin_detail.dart';
import 'package:tora_chat/services/storage_service/storage_service_helper.dart';
import 'package:tora_chat/services/storage_service/storage_service_box.dart';
import 'package:tora_chat/services/storage_service/storage_service_key.dart';
import 'package:tora_chat/util/app_enums.dart';

class CoinDetailProvider with ChangeNotifier {
  //region Common Variables
  List<CoinDetail> coinDetailList = [];
  List<CoinDetail> filterData = [];
  ApiCallStateEnum status = ApiCallStateEnum.loading;
  bool isSearch = false;

  //endregion

  //region Get coin detail
  Future<void> getCoinDetail() async {
    //Loading
    status = ApiCallStateEnum.loading;
    try {
      status = ApiCallStateEnum.success;
    } catch (e) {
      status = ApiCallStateEnum.error;
      notifyListeners();
    }
  }

  //endregion

  //region Add or update one coin detail
  void addOrUpdateOneCoinDetail({required CoinDetail CoinDetail}) {
    //If already exist then replace else add
    if (coinDetailList.any((element) => element.symbol == CoinDetail.symbol)) {
      //Replace
      coinDetailList.removeWhere((element) => element.symbol == CoinDetail.symbol);
      coinDetailList.add(CoinDetail);
    } else {
      coinDetailList.add(CoinDetail);
    }
    //Notify listeners
    notifyListeners();
  }

  //endregion
  

  //region On search
  Future<void> onSearch({required String searchText}) async {
    //If empty
    if (searchText.isEmpty) {
      isSearch = false;
    } else {
      filterData = coinDetailList.where((player) {
        return player.name!.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
      //Notify listeners
      isSearch = true;
    }
    notifyListeners();
  }

  //endregion

  
  //region On tap player detail card
  void onTapPriceDetailCard({required BuildContext context, required String playerId,required bool isAdminView}) {
    // var screen = CoinDetailScreen(
    //   playerId: playerId,
    //   isFromAdmin: isAdminView,
    // );
    // var route = CupertinoPageRoute(builder: (context) => screen);
    // Navigator.push(context, route);
  }

//endregion

  //region Fetch data from local json and save in hide if there is no data
  void savePlayerDataToHiveFromLocalJson() async {
    try {
      String data =
          await rootBundle.loadString('assets/json_files/player_info.json');
      Map<String, dynamic> jsonData = await json.decode(data);

      // Assuming the JSON has a "players" array field
      List<dynamic> playersJson = jsonData['players'] ?? [];

      // Convert JSON to List<CoinDetail>
      List<CoinDetail> players =
          playersJson.map((player) => CoinDetail.fromJson(player)).toList();

      //If box is not empty then take reference and add data
      //If hasKey is false then only add data
      if (!StorageServiceHelper.hasKey(
          boxName: StorageServiceBox.playerInfo,
          key: StorageServiceKey.CoinDetailList)) {
        //Take reference of box
        // Box CoinDetailBox = HiveManager.getBox(StorageServiceBox.playerInfo);
        // Box<List<CoinDetail>> CoinDetailBox =
        //     Hive.box(StorageServiceBox.playerInfo);

        //Add data in box
        await StorageServiceHelper.saveData<List<CoinDetail>>(
          boxName: StorageServiceBox.playerInfo,
          key: StorageServiceKey.CoinDetailList,
          value: players,
        );

        print("Data saved");

        //Add player detail in CoinDetailList
        coinDetailList = players;

        //Notify listeners
        notifyListeners();
      }
      //Else add the data from json to hive
      else {
        print("Data already exist");
        List<CoinDetail>? existingPlayers =
            (StorageServiceHelper.getData<List<dynamic>>(
          boxName: StorageServiceBox.playerInfo,
          key: StorageServiceKey.CoinDetailList,
        ))?.cast<CoinDetail>();

        //Add player detail in CoinDetailList
        coinDetailList = existingPlayers!;

        //Notify listeners
        notifyListeners();
        // Log or use the fetched data
        print("Fetched ${existingPlayers.length} players from Hive.");
        // Optionally, store it in a variable for later use if needed
        // Example: _playerList = existingPlayers;
      }
    } catch (e) {
      print("Something went wrong");
    }
  }

//endregion

  //region Update ui
  void updateUi() {
    //update ui
    notifyListeners();
  }
//endregion
}
