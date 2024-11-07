import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sacs_app/app/common/widgets/date_header.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';
import 'package:sacs_app/app/screens/sales_list/controller.dart';
import 'package:sacs_app/app/screens/sales_list/widgets/invoice_detail.dart';

class SalesListScreen extends StatelessWidget {
  final SalesListController controller = Get.put(SalesListController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: TextString.salesListIconText,
        showBackButton: true,
        isFilterAvailable: true,
        isSearchAvailable: true,
        showBackButtonStr: 'dashboard',
        body: Obx(() {
          return SingleChildScrollView(
            child: GroupedListView<ReadyForDeliveryList, String>(
              shrinkWrap: true,
              elements: controller.readyForDeliveryItems.toList(),
              groupBy: (ReadyForDeliveryList element) => element.date,
              groupSeparatorBuilder: (String groupByValue) {
                print("groupByValue:$groupByValue");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: DateHeader(
                      groupByValue: groupByValue,
                    ),
                  ),
                );
              },
              itemBuilder: (context, ReadyForDeliveryList element) => Column(
                children: [
                  InvoiceDetailsWidget(
                    invoiceNumber: element.invoiceNo,
                    deliveryType: element.deliveryType,
                    deliveryCharge: element.deliveryCharge,
                    totalProduct: element.totalProduct,
                    onDownloadInvoice: () {
                      // Handle download invoice action
                      print("Download Invoice clicked");
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
              itemComparator:
                  (ReadyForDeliveryList item1, ReadyForDeliveryList item2) =>
                      item1.invoiceNo.compareTo(item2.invoiceNo),
              useStickyGroupSeparators: true,
              floatingHeader: true,
              order: GroupedListOrder.ASC,
            ),
          );
        }));
  }
}
