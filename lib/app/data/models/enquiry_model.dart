// Enquiry model
class Enquiry {
  final String customerName;
  final String mobile;
  final String enquiryDate;
  final String productName;
  final String enquiryStatus;

  Enquiry({
    required this.customerName,
    required this.mobile,
    required this.enquiryDate,
    required this.productName,
    required this.enquiryStatus,
  });

  // Create a factory method to parse from JSON
  factory Enquiry.fromJson(Map<String, dynamic> json) {
    return Enquiry(
      customerName: json['customer_name'],
      mobile: json['mobile'],
      enquiryDate: json['enquiry_date'],
      productName: json['product_name'],
      enquiryStatus: json['enquiry_status'],
    );
  }

  get enquiryId => null;
}
