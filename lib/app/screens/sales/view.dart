import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/common/widgets/grouped_date_list.dart';
import 'package:sacs_app/app/screens/sale_form/view.dart';
import 'package:sacs_app/app/screens/sales/controller.dart';
import 'package:sacs_app/app/screens/sales/widgets/invoice_card.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesScreenController controller = Get.put(SalesScreenController());

    return MainLayout(
      title: TextString.salesListIconText,
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      showFloatingActionButton: true,
      openBuilderCallBack: () => CreateSales(),
      onFabTap: () {},
      body: Obx(() {
        final groupedEnquiries = _groupEnquiriesByDate(controller.enquiries);
        final groupTitles = groupedEnquiries.keys.toList();

        return Column(
          children: [
            Expanded(
              child: GroupedDateList(
                itemCount: groupTitles.length,
                groupTitles: groupTitles,
                fetchData: controller.fetchEnquiries,
                pageLoading: false
                    .obs, // Consider managing this state better if applicable
                itemBuilder: (context, dateIndex) {
                  return _buildEnquiriesForDate(
                      dateIndex, groupedEnquiries, context);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Map<String, List<Enquiry>> _groupEnquiriesByDate(List<Enquiry> enquiries) {
    final Map<String, List<Enquiry>> groupedEnquiries = {};

    for (var enquiry in enquiries) {
      final date = enquiry.enquiryDate ?? 'Unknown Date';
      groupedEnquiries.putIfAbsent(date, () => []).add(enquiry);
    }

    return groupedEnquiries;
  }

  Widget _buildEnquiriesForDate(
      int dateIndex, Map<String, List<Enquiry>> groupedEnquiries, context) {
    final entry = groupedEnquiries.entries.elementAt(dateIndex);
    final enquiriesForDate = entry.value;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align left for better readability
      children: enquiriesForDate.map((enquiry) {
        return InvoiceCard(
          invoiceNumber:
              '#45454455-sasa-4455', // Replace this with actual property
          deliveryType: "Warehouse / On Shop", // Replace with actual property
          deliveryCharge: "₹ 0", // Replace with actual property
          totalProducts:
              "${54 ?? 'Unknown'} No's", // Replace with actual property
          onEdit: () {
            // Handle edit action
            NavigationHelper.navigateToScreen(CreateSales());
          },
          onDelete: () {
            // Handle delete action
            Get.find<SalesScreenController>().showDeleteConfirmation(
                context); // Use Get.find for better access
          },
          onDeliveryCharge: () {
            // Handle delivery charge action
            Get.find<SalesScreenController>()
                .showDeliveryChargeApproval(context, 50);
          },
        );
      }).toList(),
    );
  }
}
