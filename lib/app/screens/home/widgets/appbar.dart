import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RxString selectedValue;
  final List<String> locations;
  final Function(String) updateLocation;

  const CommonAppBar({
    Key? key,
    required this.selectedValue,
    required this.locations,
    required this.updateLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            top: 5.0), // Horizontal padding for consistent spacing
        child: Row(
          children: [
            Icon(Icons.location_pin, color: CustomColors.selectionColor),
            SizedBox(width: 5), // Increased space between icon and dropdown
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Open popup menu manually
                },
                child: PopupMenuButton<String>(
                  onSelected: (String value) {
                    updateLocation(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return locations.map((String location) {
                      return PopupMenuItem<String>(
                        value: location,
                        child: Text(location,
                            style: TextStyle(
                              color: CustomColors.black,
                              fontSize: 14.0, // Reduced text size
                            )),
                      );
                    }).toList();
                  },
                  child: Obx(() => Row(
                        children: <Widget>[
                          Text(selectedValue.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0, // Adjusted text size
                              )),
                          SizedBox(
                              width: 8), // Space between text and dropdown icon
                          Icon(Icons.arrow_drop_down_outlined,
                              color: Colors.black),
                        ],
                      )),
                  splashRadius: 0, // Ensure splash effect is turned off
                ),
                // splashColor: Colors.transparent, // Turn off splash effect
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              right: 16.0), // Adjusts the spacing at the end
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'),
            radius: 35.0, // Adjust radius if needed
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.0); // Adjust height if needed
}
