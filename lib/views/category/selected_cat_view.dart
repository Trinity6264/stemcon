// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stemcon/utils/color/color_pallets.dart';


// import '../../view_models/selected_view_model.dart';

// // ignore: camel_case_types
// class selectedCatViews extends StatelessWidget {
//   const selectedCatViews({Key? key}) : super(key: key);

//   static const _navBarItems = [
//     BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
//     BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined), label: 'DPR'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<SelectedViewModel>.reactive(
//       viewModelBuilder: () => SelectedViewModel(),
//       builder: (context, model, child) {
//         return Scaffold(
//           backgroundColor: whiteColor,
//           body: IndexedStack(
//             index: model.currentIndex,
//             children: const [
//               Ta,
//               DprWrapper(),
//             ],
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: _navBarItems,
//             currentIndex: model.currentIndex,
//             onTap: model.setIndex,
//           ),
//         );
//       },
//     );
//   }

//   Widget icnBtn({
//     required Widget icon,
//     required VoidCallback onPressed,
//   }) {
//     return IconButton(
//       onPressed: onPressed,
//       icon: icon,
//       color: blackColor,
//     );
//   }
// }
