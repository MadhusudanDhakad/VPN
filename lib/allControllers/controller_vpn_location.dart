import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';

import '../allModels/vpn_info.dart';

class ControllerVPNLocation extends GetxController{
  List<VpnInfo> vpnFreeServersAvailableList = AppPreferences.vpnList;

  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async
  {
    isLoadingNewLocations.value = true;

    vpnFreeServersAvailableList.clear();

    vpnFreeServersAvailableList = await ApiVpnGate.retrieveAllAvailableFreeVpnServers();

    isLoadingNewLocations.value = false;
    
  }
}