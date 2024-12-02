// import 'package:flutter_slidable/flutter_slidable.dart'
//     show ActionPane, ScrollMotion, Slidable, SlidableAction;
// import 'package:get/get.dart';
// import 'package:task_allotment/config.dart';
// import '../res_list.dart';
//
// Widget taskCard(var orders) => SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) => InkWell(
//           onTap: () => showAllDetails(orders[index]),
//           child: Slidable(
//             key: const ValueKey(0),
//             startActionPane: ActionPane(
//               motion: const ScrollMotion(),
//               children: [
//                 SlidableAction(
//                   flex: 2,
//                   onPressed: viewDetails,
//                   backgroundColor:
//                       orders[index]['status'].toString() == 'progress'
//                           ? const Color(0xff0984e3)
//                           : orders[index]['status'].toString() == 'pending'
//                               ? const Color(0xffe17055)
//                               : const Color(0xff00b894),
//                   foregroundColor: Colors.white,
//                   label: orders[index]['status'].toString(),
//                 ),
//               ],
//             ),
//             endActionPane: const ActionPane(
//               motion: ScrollMotion(),
//               children: [
//                 SlidableAction(
//                   flex: 2,
//                   onPressed: viewDetails,
//                   backgroundColor: Color(0xff2d3436),
//                   foregroundColor: Colors.white,
//                   icon: Icons.remove_red_eye_outlined,
//                   label: 'View',
//                 ),
//                 SlidableAction(
//                   flex: 2,
//                   onPressed: edit,
//                   backgroundColor: Color(0xff00b894),
//                   foregroundColor: Colors.white,
//                   icon: Icons.edit,
//                   label: 'Edit',
//                 ),
//               ],
//             ),
//             child: Container(
//               color: AppColors.white,
//               child: Column(
//                 children: [
//                   heightSpaceBox(size: 10),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10,right: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         textLine(title: 'task_id', fontSize: 13,isBold: true,color: AppColors.black),
//                         textLine(title: 'Assigned By', fontSize: 13,isBold: true,color: AppColors.black),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 15),
//                           child: textLine(title: 'reference', fontSize: 13,isBold: true,color: AppColors.black),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   heightSpaceBox(size: 5),
//                   const Divider(indent: 10,endIndent: 10,height: 10,),
//                   ListTile(
//                     leading: textLine(
//                       title: orders[index]['code'].toString(),
//                       fontSize: 15,
//                     ),
//                     trailing: Column(
//                       children: [
//                         textLine(title: orders[index]['ref_name'], fontSize: 12),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(
//                                 color:
//                                     orders[index]['status'].toString() == 'progress'
//                                         ? AppColors.blue
//                                         : orders[index]['status'].toString() ==
//                                                 'pending'
//                                             ? Colors.amber
//                                             : Colors.green),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 5, right: 5),
//                             child: textLine(
//                                 title: "+91${orders[index]['ref_contact'].toString()}",
//                                 fontSize: 10,
//                                 color:
//                                     orders[index]['status'].toString() == 'progress'
//                                         ? AppColors.blue
//                                         : orders[index]['status'].toString() ==
//                                                 'pending'
//                                             ? Colors.amber
//                                             : Colors.green),
//                           ),
//                         ),
//                       ],
//                     ),
//                     title: textLine(
//                         title: orders[index]['assignee'].toString(),
//                         fontSize: 14,
//                         isBold: true),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: const Color(0xffACC8E5).withOpacity(0.5),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Icon(
//                               Icons.calendar_month,
//                               size: 20,
//                             ),
//                             textLine(
//                                 title:
//                                     "assignee_on_${orders[index]['created_date']}",
//                                 fontSize: 12,
//                                 isBold: true,
//                                 color: AppColors.black),
//                             textLine(
//                                 title: " Deadline ${orders[index]['deadline']}",
//                                 fontSize: 12,
//                                 isBold: true,
//                                 color: AppColors.black),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Divider(
//                     color: AppColors.grey,
//                     indent: 10,
//                     endIndent: 10,
//                     thickness: 2,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // 40 list items
//         childCount: orders.length,
//       ),
//     );
