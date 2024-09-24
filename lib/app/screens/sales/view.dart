import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';

class SalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Sales List',
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      body: Text('Sales List'),
      showFloatingActionButton: false, // Display the FAB
    );
  }
}
