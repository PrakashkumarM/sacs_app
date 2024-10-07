import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/image_picker_service.dart';

class SerialImageWidget extends StatelessWidget {
  final String title;
  final String serialNumber;
  final String imageUrl;

  const SerialImageWidget({
    super.key,
    required this.title,
    required this.serialNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ImagePickerService _imagePickerService = ImagePickerService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(context, _imagePickerService),
        SizedBox(height: 8),
        _buildImageContainer(),
      ],
    );
  }

  Row _buildTitleRow(
      BuildContext context, ImagePickerService imagePickerService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        _buildEditButton(context, imagePickerService),
      ],
    );
  }

  GestureDetector _buildEditButton(
      BuildContext context, ImagePickerService imagePickerService) {
    return GestureDetector(
      onTap: () => showEditOptions(context, imagePickerService),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: CustomColors.mildSkyblueBg,
          shape: BoxShape.circle,
        ),
        child: Icon(
          CustomIcons.editPencil,
          size: 14,
          color: CustomColors.invoiceNoBlueColor,
        ),
      ),
    );
  }

  Container _buildImageContainer() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void showEditOptions(
      BuildContext context, ImagePickerService imagePickerService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          title: _buildDialogTitle(context),
          content: _buildDialogContent(context, imagePickerService),
        );
      },
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 5, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24),
          Center(
            child: Text(
              TextString.serialNoEdit,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogContent(
      BuildContext context, ImagePickerService imagePickerService) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOptionColumn(
            context,
            imagePickerService.pickImageFromCamera,
            Icons.camera_alt,
            TextString.camera,
          ),
          _buildOptionColumn(
            context,
            imagePickerService.pickImageFromGallery,
            CustomIcons.gallery,
            TextString.gallery,
          ),
        ],
      ),
    );
  }

  Column _buildOptionColumn(
      BuildContext context, Function onTap, IconData icon, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: CustomColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: CustomColors.darkGrey,
              size: 18,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          SizedBox(height: 16.0),
          content,
        ],
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 8,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

void showSerialNumberBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return CustomBottomSheet(
        title: 'Serial Number Upload',
        content: SerialImageWidget(
          title: 'Television | Samsung | TV | 42"',
          serialNumber: 'A0C1715821',
          imageUrl: 'https://picsum.photos/seed/picsum/200/300',
        ),
      );
    },
  );
}
