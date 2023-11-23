import 'package:flutter/material.dart';

class DashboardDetailModel {
  final String iconImage;
  final String title;
  final String? subtitle;
  // final bool? removeAppbar;
  int? subtitleValue;
  final Widget? customSubtitle;
  final VoidCallback onTap;

  DashboardDetailModel({
    required this.iconImage,
    required this.title,
    this.subtitle,
    // this.removeAppbar,
    this.subtitleValue,
    this.customSubtitle,
    required this.onTap,
  });
}

// class DashboardModel {
//   DashboardModel({this.dashboardModel, this.taskModel});
//   LandlordDashboardModel? dashboardModel;
//   LandlordTaskModel? taskModel;

//   factory DashboardModel.fromJson(Map<String, dynamic> json) =>
//       DashboardModel(
//      dashboardModel: 
//       );

//   Map<String, dynamic> toJson() => {
//         "task": taskModel?.toJson(),
//         "dashboard": dashboardModel?.toJson(),
        
//       };
// }
