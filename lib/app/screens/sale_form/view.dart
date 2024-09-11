import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';

class CreateSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Create New Sales',
      showBackButton: true,
      isFilterAvailable: false,
      isSearchAvailable: false,
      body: Text('Create Sales form'),
      showFloatingActionButton: false, // Display the FAB
    );
  }
}
