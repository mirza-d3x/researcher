// //
// // Author: Geojit Technologies PVT LTD
// // zeg_video_call.dart (c) 2023
// // Desc: Copyright (C) Geojit technologies (P) Ltd, All Rights Reserved
// //  Unauthorized copying of this file, via any medium is strictly prohibited
// //  Proprietary and confidential
// // Created:  2023-05-08T11:50:10.017Z
// //

// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// const appId = 216498921;
// const appSign =
//     "318372ecc4aae24ed519b296ad8a931cb5fb93b0146ac472ed791bad6a2f6613";

// class CallPage extends StatelessWidget {
//   const CallPage({Key? key}) : super(key: key);
//   void onUserLogin() {
//     /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
//     /// when app's user is logged in or re-logged in
//     /// We recommend calling this method as soon as the user logs in to your app.
//     ZegoUIKitPrebuiltCallInvitationService().init(
//       appID: appId /*input your AppID*/,
//       appSign: appSign /*input your AppSign*/,
//       userID: "sda",
//       userName: 'djfkds',
//       plugins: [ZegoUIKitSignalingPlugin()],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ZegoUIKitPrebuiltCall(
//           appID: appId,
//           appSign: appSign,
//           userID: "mirza",
//           userName: "mirza",
//           callID: "dfsdf",
//           config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: true),
//         ),
//         ZegoSendCallInvitationButton(
//           isVideoCall: true,
//           resourceID: "zegouikit_call", // For offline call notification
//           invitees: [
//             ZegoUIKitUser(
//               id: targetUserID,
//               name: targetUserName,
//             ),
//             ...ZegoUIKitUser(
//               id: targetUserID,
//               name: targetUserName,
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
