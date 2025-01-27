import 'package:hive/hive.dart';
import 'package:tora_chat/model/coin_detail/coin_detail.dart';
import 'package:tora_chat/services/storage_service/storage_service_box.dart';
import 'package:tora_chat/services/storage_service/storage_service_helper.dart';
import 'package:tora_chat/services/storage_service/storage_service_key.dart';

class StorageService {



  //region Add or update one player detail
  void saveCoinInfoDetail({required List<CoinDetail> coinDetailList}) async{

    var box = Hive.box<Book>('library');
    //Get list of coin detail from box
    var coinDetailList = HiveList(box, 'books_list');



    //If box is not empty then take reference and add data
    //If hasKey is false then only add data
    if (!StorageServiceHelper.hasKey(
        boxName: StorageServiceBox.coinInfoBox,
        key: StorageServiceKey.coinDetailList)) {
      //Add data in box



    }


  }

  //endregion

}