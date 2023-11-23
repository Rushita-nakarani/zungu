import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/booked_jobs.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/create_request.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/sent_rejected_request.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/sent_request.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/tenant_maintenance_appbar.dart';
import '../../../constant/string_constants.dart';

class TenantMaintenance extends StatefulWidget {
  const TenantMaintenance({super.key});

  @override
  State<TenantMaintenance> createState() => _TenantMaintenanceState();
}

class _TenantMaintenanceState extends State<TenantMaintenance> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: tenantMiantenanceBuildAppbar(title: StaticString.maintenance),
        body:  const SafeArea(
          child: TabBarView(
            children: [
             TenantMaintenanceCreateRequest(),
              TenantMaintenanceSentRequest(),
              TenantMaintenanceBookedJobs()
            ],
          ),
        ),
      ),
    );
  }
}
