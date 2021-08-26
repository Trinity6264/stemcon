import 'dart:convert';

class NewUser {
  String? countryCode;
  int? company;
  String? number;
  String? appSignature;
  NewUser({
    this.countryCode,
    this.company,
    this.number,
    required this.appSignature
  });

  Map<String, dynamic> toMap() {
    return {
      "country_code": countryCode,
      "company_code": company!.toInt(),
      "mobile_number": number,
      "app_signature": appSignature
    };
  }

  String toJson() => json.encode(toMap());
}
class ConfirmOtp {
  int? companyCode;
  int? otp;
  int? token;
  ConfirmOtp({
    this.companyCode,
    this.otp,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      "company_code": companyCode,
      "otp": otp,
      "token": token
    };
  }

  String toJson() => json.encode(toMap());
}
