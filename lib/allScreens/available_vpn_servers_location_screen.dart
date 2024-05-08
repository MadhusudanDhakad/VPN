import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../allControllers/controller_vpn_location.dart';
import 'package:vpn_basic_project/allWidgets/vpn_location_card_widget.dart';

class AvailableVpnServersLocationScreen extends StatelessWidget
{
  AvailableVpnServersLocationScreen({super.key});

  final vpnLocationController = ControllerVPNLocation();

  loadingUIWidget()
  {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            "Gathering Free VPN Locations...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    );
  }

  noVpnServerFoundUIWidget()
  {
    return Center(
      child: Text(
        "No VPNs Found, Try Agail.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  vpnAvailableServersData()
  {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServersAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index)
      {
        return VpnLocationCardWidget(vpnInfo: vpnLocationController.vpnFreeServersAvailableList[index]);
      },
    );
  }


  @override
  Widget build(BuildContext context)
  {

    if(vpnLocationController.vpnFreeServersAvailableList.isEmpty)
    {
      vpnLocationController.retrieveVpnInformation();
    }


    return Obx(()=> Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "VPN Location (" + vpnLocationController.vpnFreeServersAvailableList.length.toString() + ")",
        ),
      ),
       floatingActionButton: Padding(
         padding: const EdgeInsets.only(bottom: 10, right: 10),
         child: FloatingActionButton(
           backgroundColor: Colors.redAccent,
           onPressed: ()
           {
             vpnLocationController.retrieveVpnInformation();
           },
           child: Icon(
             CupertinoIcons.refresh_circled,
             size: 40,
           ),
         ),
       ),

      body: vpnLocationController.isLoadingNewLocations.value
          ? loadingUIWidget()
          : vpnLocationController.vpnFreeServersAvailableList.isEmpty
          ? noVpnServerFoundUIWidget
          : vpnAvailableServersData,
    ));
  }
}

