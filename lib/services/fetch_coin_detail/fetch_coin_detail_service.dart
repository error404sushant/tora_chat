import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tora_chat/model/coin_detail/coin_detail.dart';
import 'package:tora_chat/services/api_call_service.dart';


class FetchCoinInfo{
  // region Common Variables
  late ApiCallService apiCallService;
  // endregion

  //region Constructor
  FetchCoinInfo() {
    apiCallService = ApiCallService();
  }
  //endregion

  // region Get coin
  Future<List<CoinDetail>> getPlayerDetail({required int limit, required int offset}) async {
    String data = await rootBundle.loadString('assets/json_files/player_info.json');
    Map<String, dynamic> jsonData = await json.decode(data);
    
    // Assuming the JSON has a "players" array field
    List<dynamic> playersJson = jsonData['players'] ?? [];
    
    // Convert JSON to List<PlayerDetail>
    List<CoinDetail> players = playersJson
        .map((player) => CoinDetail.fromJson(player))
        .toList();
    
    // Apply pagination
    int start = offset;
    int end = (offset + limit).clamp(0, players.length);
    
    return players.sublist(start, end);
  }
// endregion

}