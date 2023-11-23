// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/cupertino.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/models/dashboard/tradesman_dashboard_model.dart';
import 'package:zungu_mobile/models/dashboard/tradesman_task_model.dart';

import '../../api/api_end_points.dart';
import '../../api/api_middleware.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../screens/landlord/landlord_dashboard_screen.dart';

class TradesmanDashboradProvider extends ChangeNotifier {
  //-------------------------------Variables-----------------------------------//
  TradesmanDashboardModel? tradesmanDashboardModel;
  TradesmanTaskModel? tradesmanTaskModel;
  List<NewTaskLeftModel> newTaskLeftList = [];

  //---------------------------getter/setter methods------------------------//

  //Tradesman dashboard getter/setter method
  TradesmanDashboardModel? get getTradesmanDashboardModel =>
      tradesmanDashboardModel;

  set setTradesmanDashboardModel(
    TradesmanDashboardModel? _tradesmanDashboardModel,
  ) {
    tradesmanDashboardModel = _tradesmanDashboardModel;
  }

  //Tradesman task getter/setter method
  TradesmanTaskModel? get getTradesmanTaskModel => tradesmanTaskModel;

  set setTradesmanTaskModel(TradesmanTaskModel? _tradesmanTaskModel) {
    tradesmanTaskModel = _tradesmanTaskModel;
  }

  //--------------------------------Function---------------------------//

  // Fetch Tradesman Dashboard data List
  Future<void> fetchTradesmanDashboardList() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: DashboardEndPoints.tradesmanDashboard,
          requestType: HTTPRequestType.GET,
        ),
      );

       setTradesmanTaskModel = tradesmanTaskModelFromJson(response);

      newTaskLeftList = [
        NewTaskLeftModel(
          icon: ImgName.tradesmanLatestJob,
          title: StaticString.latestJobs,
          count: getTradesmanTaskModel?.latestJobsCount ?? 0,
        ),
        NewTaskLeftModel(
          icon: ImgName.tradesmanSentQuotes,
          title: StaticString.sentQuotes,
          count: getTradesmanTaskModel?.sentQuotesCount ?? 0,
        ),
        NewTaskLeftModel(
          icon: ImgName.confirmedJobs,
          title: StaticString.confirmedJobs,
          count: getTradesmanTaskModel?.confirmedJobCount ?? 0,
        ),
      ];

      newTaskLeftList.sort((a, b) => b.count.compareTo(a.count));

      setTradesmanDashboardModel = tradesmanDashboardModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  
}
