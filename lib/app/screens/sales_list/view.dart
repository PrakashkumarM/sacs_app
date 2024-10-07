import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/sale_form/view.dart';

class SalesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.salesListIconText,
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      body: Text('Sales List'),
      showFloatingActionButton: true, // Display the FAB
      openBuilderCallBack: () {
        return CreateSales();
      },
    );
  }
}
