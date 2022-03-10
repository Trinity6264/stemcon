import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/models/country_codes_model.dart';
import 'package:stemcon/utils/code/country_code.dart';

import 'custom_dialog.form.dart';
import 'dialog_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'searchCountry'),
])
class CustomDialog extends StatelessWidget with $CustomDialog {
  ValueChanged<CountryCodesModel> onChanged;
  CustomDialog({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<DialogViewModel>.reactive(
      viewModelBuilder: () => DialogViewModel(),
      builder: (context, model, child) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          insetPadding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 40.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchCountryController,
                  onChanged: model.filterData,
                  decoration: const InputDecoration(
                    hintText: 'Search country',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: model.countries.length,
                    itemBuilder: ((context, index) {
                      final country = model.countries[index];
                      return ListTile(
                        onTap: () {
                          onChanged(country);
                          Navigator.of(context).pop();
                        },
                        leading: Image.asset(
                          country.flag!,
                          fit: BoxFit.cover,
                          width: 32,
                        ),
                        title: Text(
                          country.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Text(
                          country.callingCode!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
