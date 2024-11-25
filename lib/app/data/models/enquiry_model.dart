// Enquiry model
class Enquiry {
  final String customerName;
  final String mobile;
  final String enquiryDate;
  final String productName;
  final String enquiryStatus;
  final String branch;
  final String enquiredBy;

  Enquiry(
      {required this.customerName,
      required this.mobile,
      required this.enquiryDate,
      required this.productName,
      required this.enquiryStatus,
      required this.branch,
      required this.enquiredBy});

  // Create a factory method to parse from JSON
  factory Enquiry.fromJson(Map<String, dynamic> json) {
    return Enquiry(
      customerName: json['customer_name'],
      mobile: json['mobile'],
      enquiryDate: json['enquiry_date'],
      productName: json['product_name'],
      enquiryStatus: json['enquiry_status'],
      branch: json['branch'],
      enquiredBy: json['enquired_by'],
    );
  }

  get enquiryId => null;
}
