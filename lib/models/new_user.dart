import 'dart:convert';

class NewUser {
  String? countryCode;
  String? companyCode;
  int? number;
  String? appSignature;
  NewUser({
    required this.countryCode,
    required this.number,
    required this.companyCode,
    required this.appSignature,
  });

  Map<String, dynamic> toMap() {
    return {
      "country_code": countryCode,
      "mobile_number": number,
      "app_signature": appSignature,
      "company_code": companyCode,
    };
  }

  String toJson() => json.encode(toMap());
}

class ConfirmOtp {
  String? mobileNumber;
  int? otp;
  int? token;
  ConfirmOtp({
    this.mobileNumber,
    this.otp,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {"mobile_number": mobileNumber, "otp": otp, "token": token};
  }

  String toJson() => json.encode(toMap());
}
