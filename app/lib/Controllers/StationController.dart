import 'package:app/Models/StationModel.dart';
import 'package:app/Provider/StationProvider.dart';
import 'package:get/get.dart';

class StationController extends GetxController{
  var list = <StationModel>[].obs;
  final is_loaded = true.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
    var res = await StationProvider.getStationList();
    list.assignAll(res);
    is_loaded(false);
  }

  StationModel? findById(int id) {
    for (var item in list) {
      if (item.id == id) {
        return item;
      }
    }
    return null; // Return null if the item is not found
  }
}