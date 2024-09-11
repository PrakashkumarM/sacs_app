import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';

class CreateEnquiry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Create Enquiry',
      showBackButton: true,
      isFilterAvailable: false,
      isSearchAvailable: false,
      body: Text('Create enquiry form'),
      showFloatingActionButton: false, // Display the FAB
    );
  }
}
