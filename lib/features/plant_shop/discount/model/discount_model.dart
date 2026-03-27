class DiscountModel {
  final int id;
  final String title;
  final String code;
  final int percentage;
  final int minAmount;
  // final String appliesTo;
  final DateTime validUntil;
  final bool isActive;
  final bool firstTimeOnly;
  final List<String> rules;

  DiscountModel({
    required this.id,
    required this.title,
    required this.code,
    required this.percentage,
    required this.minAmount,
    // required this.appliesTo,
    required this.validUntil,
    required this.rules,
    required this.isActive,
    required this.firstTimeOnly,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    List<String> rulesList = [];

    if (json['rules'] != null) {
      if (json['rules'] is List) {
        // If it's already a List
        rulesList = List<String>.from(json['rules']);
      } else if (json['rules'] is String) {
        // If it's a PostgreSQL array string like {"rule1","rule2"}
        final rulesStr = json['rules'] as String;
        if (rulesStr.startsWith('{') && rulesStr.endsWith('}')) {
          // Parse PostgreSQL array format
          final content = rulesStr.substring(1, rulesStr.length - 1);
          if (content.isNotEmpty) {
            rulesList = content
                .split(',')
                .map((e) => e.trim().replaceAll('"', ''))
                .toList();
          }
        } else {
          rulesList = [rulesStr];
        }
      }
    }

    return DiscountModel(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      percentage: json['percentage'],
      minAmount: (json['minAmount'] as num).toInt(),
      // appliesTo: json['applies_to'],
      validUntil: DateTime.parse(json['valid_until']),
      rules: rulesList,
      isActive: json['isActive'],
      firstTimeOnly: json['firstTimeOnly'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'percentage': percentage,
      'minAmount': minAmount,
      // 'applies_to': appliesTo,
      'valid_until': validUntil.toIso8601String(),
      'rules': rules,
      'isActive': isActive,
      'firstTimeOnly': firstTimeOnly,
    };
  }
}
