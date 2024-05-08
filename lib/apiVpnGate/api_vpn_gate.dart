import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/vpn_info.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';
import '../allModels/ip_info.dart';

class ApiVpnGate
{
  static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnServers() async
  {
    final List<VpnInfo> vpnServersList = [];

    try
    {
      final responseFromApi = await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final commaSeparatedValueString = responseFromApi.body.split("#")[1].replaceAll("*", "");

      List<List<dynamic>> listData = const CsvToListConverter().convert(commaSeparatedValueString);

      final header = listData[0];

      for(int counter=1; counter<listData.length-1; counter++)
        {
          Map<String, dynamic> jsonData = {};

          for(int innerCounter=0; innerCounter<header.length; innerCounter++)
            {
              jsonData.addAll({header[innerCounter].toString(): listData[counter][innerCounter]});
            }

          vpnServersList.add(VpnInfo.fromJson(jsonData));
        }
    }
    catch(errorMsg)
    {
      Get.snackbar(
        "Error Occurred",
        errorMsg.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.8)
      );
    }

    vpnServersList.shuffle();

    if(vpnServersList.isNotEmpty) AppPreferences.vpnList = vpnServersList;

    return vpnServersList;
  }


  static Future<void> retrieveIPDetails({required Rx<IPInfo> ipInformation}) async
  {
    try
    {
      final responseFromApi = await http.get(Uri.parse('http://ip-api.com/json/'));
      final dataFromApi = jsonDecode(responseFromApi.body);

      ipInformation.value = IPInfo.fromJson(dataFromApi);
    }
    catch(errorMsg)
    {
      Get.snackbar(
          "Error Occurred",
          errorMsg.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(.8)
      );
    }
  }
}