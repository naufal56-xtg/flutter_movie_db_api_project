// import 'package:flutter/material.dart';

// import '../paginate_discover_movie.dart';
// // import '../paginate_popular_movie.dart';

// class BoxAdapterWidget extends StatelessWidget {
//   const BoxAdapterWidget({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => PaginateDiscoverMovie(),
//                   ),
//                 );
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (_) => PaginatePopularMovie(),
//                 //   ),
//                 // );
//               },
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: Colors.black,
//                 shape: StadiumBorder(),
//                 side: BorderSide(
//                   color: Colors.black,
//                 ),
//               ),
//               child: Text('See All'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
