class Dashboard {
  final DashboardWidgets widgets;
  final List<TeamAchievement> teamAchievements;
  final List<FollowUpReminder> followUpReminders;
  final List<TopPerformer> topPerformers;
  final List<CustomerFeedbackModel> customerFeedbacks;
  final List<ReadyForDelivery> readyForDelivery;

  Dashboard({
    required this.widgets,
    required this.teamAchievements,
    required this.followUpReminders,
    required this.topPerformers,
    required this.customerFeedbacks,
    required this.readyForDelivery,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      widgets: DashboardWidgets.fromJson(json['widgets']),
      teamAchievements: List<TeamAchievement>.from(
          json['team_achievements'].map((x) => TeamAchievement.fromJson(x))),
      followUpReminders: List<FollowUpReminder>.from(
          json['follow_up_reminder'].map((x) => FollowUpReminder.fromJson(x))),
      topPerformers: List<TopPerformer>.from(
          json['top_performers'].map((x) => TopPerformer.fromJson(x))),
      customerFeedbacks: List<CustomerFeedbackModel>.from(
          json['customer_feedback']
              .map((x) => CustomerFeedbackModel.fromJson(x))),
      readyForDelivery: List<ReadyForDelivery>.from(
          (json['ready_for_delivery'] as List).map((x) =>
              ReadyForDelivery.fromJson(
                  x))), // Ensure this is a list of ReadyForDelivery
    );
  }
}

class DashboardWidgets {
  final int target;
  final int achievement;
  final int followUpReminder;
  final int enquiries;
  final int delivered;
  final int readyForDelivery;

  DashboardWidgets({
    required this.target,
    required this.achievement,
    required this.followUpReminder,
    required this.enquiries,
    required this.delivered,
    required this.readyForDelivery,
  });

  factory DashboardWidgets.fromJson(Map<String, dynamic> json) {
    return DashboardWidgets(
      target: json['target'],
      achievement: json['achievement'],
      followUpReminder: json['follow_up_reminder'],
      enquiries: json['enquiries'],
      delivered: json['delivered'],
      readyForDelivery: json['ready_for_delivery'],
    );
  }
}

class TeamAchievement {
  final int id;
  final String productName;
  final String productLogo;
  final int totalTarget;
  final int pendingTarget;
  final int yourTarget;
  final int completedTarget;

  TeamAchievement({
    required this.id,
    required this.productName,
    required this.productLogo,
    required this.totalTarget,
    required this.pendingTarget,
    required this.yourTarget,
    required this.completedTarget,
  });

  factory TeamAchievement.fromJson(Map<String, dynamic> json) {
    return TeamAchievement(
      id: json['id'],
      productName: json['product_name'],
      productLogo: json['product_logo'],
      totalTarget: json['total_target'],
      pendingTarget: json['pending_target'],
      yourTarget: json['your_target'],
      completedTarget: json['completed_target'],
    );
  }
}

class FollowUpReminder {
  final int id;
  final String customerName;
  final String nextVisitDate;
  final int mobile;

  FollowUpReminder({
    required this.id,
    required this.customerName,
    required this.nextVisitDate,
    required this.mobile,
  });

  factory FollowUpReminder.fromJson(Map<String, dynamic> json) {
    return FollowUpReminder(
      id: json['id'],
      customerName: json['customer_name'],
      nextVisitDate: json['next_visit_date'],
      mobile: json['mobile'],
    );
  }
}

class TopPerformer {
  final int id;
  final String employeeName;
  final String role;
  final int enquiries;
  final int sales;
  final double payments;

  TopPerformer({
    required this.id,
    required this.employeeName,
    required this.role,
    required this.enquiries,
    required this.sales,
    required this.payments,
  });

  factory TopPerformer.fromJson(Map<String, dynamic> json) {
    return TopPerformer(
      id: json['id'],
      employeeName: json['employee_name'],
      role: json['role'],
      enquiries: json['enquiries'],
      sales: json['sales'],
      payments: json['payments'].toDouble(),
    );
  }
}

class CustomerFeedbackModel {
  final int id;
  final String customerName;
  final String mobile;
  final String invoiceNo;

  CustomerFeedbackModel({
    required this.id,
    required this.customerName,
    required this.mobile,
    required this.invoiceNo,
  });

  factory CustomerFeedbackModel.fromJson(Map<String, dynamic> json) {
    return CustomerFeedbackModel(
      id: json['id'],
      customerName: json['customer_name'],
      mobile: json['mobile'],
      invoiceNo: json['invoice_no'],
    );
  }
}

class ReadyForDeliveryList {
  final int id;
  final String invoiceNo;
  final String deliveryType;
  final int deliveryCharge;
  final int totalProduct;
  final String date;

  ReadyForDeliveryList({
    required this.id,
    required this.invoiceNo,
    required this.deliveryType,
    required this.deliveryCharge,
    required this.totalProduct,
    required this.date,
  });

  factory ReadyForDeliveryList.fromJson(Map<String, dynamic> json) {
    return ReadyForDeliveryList(
      id: int.parse(json['id']), // Convert to int if it's a String
      invoiceNo: json['invoice_no'],
      deliveryType: json['delivery_type'],
      deliveryCharge: json['delivery_charge'],
      totalProduct: json['total_product'],
      date: json['date'],
    );
  }
}

class ReadyForDelivery {
  final int id;
  final String invoiceNo;
  final String deliveryType;
  final int deliveryCharge;
  final int totalProduct;
  final String date;

  ReadyForDelivery({
    required this.id,
    required this.invoiceNo,
    required this.deliveryType,
    required this.deliveryCharge,
    required this.totalProduct,
    required this.date,
  });

  factory ReadyForDelivery.fromJson(Map<String, dynamic> json) {
    return ReadyForDelivery(
      id: json['id'],
      invoiceNo: json['invoice_no'],
      deliveryType: json['delivery_type'],
      deliveryCharge: json['delivery_charge'],
      totalProduct: json['total_product'],
      date: json['date'],
    );
  }
}
