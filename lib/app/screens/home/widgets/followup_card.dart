import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class FollowUpCard extends StatelessWidget {
  final String name;
  final String date;
  final Color avatarColor;
  final IconData callIcon;
  final IconData viewIcon;

  const FollowUpCard({
    required this.name,
    required this.date,
    required this.avatarColor,
    required this.callIcon,
    required this.viewIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          child: const Icon(CustomIcons.user, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: CustomColors.grey,
          ),
        ),
        trailing: _buildTrailingIcons(),
      ),
    );
  }

  Widget _buildTrailingIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircularIcon(
            CustomColors.greenBadge, callIcon, CustomColors.successDarktext),
        SizedBox(width: 4),
        _buildCircularIcon(CustomColors.mildSkyblueBg, viewIcon,
            CustomColors.invoiceNoBlueColor),
      ],
    );
  }

  Widget _buildCircularIcon(Color bgColor, IconData icon, Color iconColor) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20,
        color: iconColor,
      ),
    );
  }
}

class FollowUpReminderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.white,
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFollowUpCard("John Mathew", "10-09-2024", Colors.blue),
          _buildFollowUpCard("John", "09-09-2024", Colors.amber),
          _buildFollowUpCard("John Richard", "08-09-2024", Colors.red),
          _buildFollowUpCard(
              "John Mathew Richard", "07-09-2024", Colors.lightBlue),
        ],
      ),
    );
  }

  Widget _buildFollowUpCard(String name, String date, Color avatarColor) {
    return Column(
      children: [
        FollowUpCard(
          name: name,
          date: date,
          avatarColor: avatarColor,
          callIcon: CustomIcons.call,
          viewIcon: Icons.visibility,
        ),
        Divider(color: CustomColors.borderGrey),
      ],
    );
  }
}
