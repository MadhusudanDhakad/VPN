import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import '../allModels/ip_info.dart';
import '../allWidgets/network_ip_info_widget.dart';
import '../allModels/network_ip_info.dart';

class ConnectedNetworkIPInfoScreen extends StatelessWidget
{
  const ConnectedNetworkIPInfoScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final ipInfo = IPInfo.fromJson({}).obs;
    ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Connected Network IP Information",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: ()
          {
            ipInfo.value = IPInfo.fromJson({});
            ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
          },
          child: Icon(
            CupertinoIcons.refresh_circled,
          ),
        ),
      ),
      body: Obx(()=> ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(3),
        children: [

          //ip address
          NetworkIPInfoWidget(
            networkIPInfo: NetworkIPInfo(
              titleText: "IP Address",
              subtitleText: ipInfo.value.query,
              iconData: Icon(
                Icons.my_location_outlined,
                color: Colors.redAccent,
              ),
            )
          ),

          //isp
          NetworkIPInfoWidget(
              networkIPInfo: NetworkIPInfo(
                titleText: "Internet Service Provider",
                subtitleText: ipInfo.value.internetServiceProvider,
                iconData: Icon(
                  Icons.my_location_outlined,
                  color: Colors.deepOrange,
                ),
              )
          ),

          //location
          NetworkIPInfoWidget(
              networkIPInfo: NetworkIPInfo(
                titleText: "Location",
                subtitleText: ipInfo.value.countryName.isEmpty
                    ? "Retrieving... "
                    : "${ipInfo.value.cityName}, ${ipInfo.value.regionName}, ${ipInfo.value.countryName}",
                iconData: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.green,
                ),
              )
          ),

          //Zip code
          NetworkIPInfoWidget(
              networkIPInfo: NetworkIPInfo(
                titleText: "Pin Code",
                subtitleText: ipInfo.value.zipCode,
                iconData: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  color: Colors.purpleAccent,
                ),
              )
          ),

          //timezone
          NetworkIPInfoWidget(
              networkIPInfo: NetworkIPInfo(
                titleText: "Timezone",
                subtitleText: ipInfo.value.timezone,
                iconData: Icon(
                  Icons.share_arrival_time_outlined,
                  color: Colors.cyan,
                ),
              )
          ),

        ],
      )),
    );
  }
}
