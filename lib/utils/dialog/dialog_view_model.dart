
import 'package:stacked/stacked.dart';

import '../../models/country_codes_model.dart';
import '../code/country_code.dart';

class DialogViewModel extends BaseViewModel {
  List<CountryCodesModel> countries = countryCodeDatas;

    
  void filterData(String value) {
    countries = isNumeric(value)
        ? countryCodeDatas.where((country) {
            return country.callingCode!.contains(value);
          }).toList()
        : countryCodeDatas.where((country) {
            return country.name!.toLowerCase().contains(value.toLowerCase());
          }).toList();
    notifyListeners();
  }

  bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
}
