import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class GroupedDateList extends StatelessWidget {
  final int itemCount; // Total number of items
  final Widget Function(BuildContext, int)
      itemBuilder; // Custom item builder from parent
  final ScrollController _scrollController = ScrollController();
  final Function fetchData;
  final RxBool pageLoading;
  final List<String>
      groupTitles; // List of group titles (like date or category)

  GroupedDateList({
    required this.itemCount,
    required this.itemBuilder,
    required this.fetchData,
    required this.pageLoading,
    required this.groupTitles, // List of titles for grouping items
  });

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData(); // Load more when scroll reaches the end
      }
    });

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount + 1, // +1 for pagination loader
      itemBuilder: (context, index) {
        if (index == itemCount) {
          // Pagination loader
          return pageLoading.value
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink();
        }

        final groupTitle =
            groupTitles[index]; // Fetch the group title from parent

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group header (e.g., Date or category)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                  decoration: BoxDecoration(
                    color: CustomColors.lightRed,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    groupTitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.darkGrey,
                    ),
                  ),
                ),
              ),
            ),
            // Use the custom item builder from the parent
            itemBuilder(context, index),
          ],
        );
      },
    );
  }
}
