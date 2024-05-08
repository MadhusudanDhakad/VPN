import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/vpn_configuration.dart';
import 'package:vpn_basic_project/allModels/vpn_info.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

class ControllerHome extends GetxController
{
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async
  {
    if(vpnInfo.value.base64OpenVPNConfigurationData.isEmpty)
      {
        Get.snackbar("Country / Location", "Please select country / Location first.");

        return;
      }

    //disconnected
    if(vpnConnectionState.value == VpnEngine.vpnDisconnectedNow)
      {
        final dataConfigVpn = Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationData);
        final configuration = Utf8Decoder().convert(dataConfigVpn);

        final vpnConfiguration = VpnConfiguration(
          username: "vpn",
          password: "vpn",
          countryName: vpnInfo.value.countryLongName,
          config: configuration
        );

        await VpnEngine.startVpnNow(vpnConfiguration);

      }
      else
      {
        await VpnEngine.stopVpnNow();
      }
  }

  Color get getRoundVpnButtonColor
  {
    switch (vpnConnectionState.value)
    {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText
  {
    switch (vpnConnectionState.value)
    {
      case VpnEngine.vpnDisconnectedNow:
        return "Let's Connect";

      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }

}