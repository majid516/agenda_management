// import 'package:flutter/material.dart';

// class ProfileStack extends StatelessWidget {
//   final List<String> profileImages;
//   final int? count; 
//   final double profileSize;
//   final double overlap;

//   const ProfileStack({
//     super.key,
//     required this.profileImages,
//     this.count,
//     this.profileSize = 50.0,
//     this.overlap = 15.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double availableWidth = constraints.maxWidth;
//         int maxProfiles = ((availableWidth + overlap) / (profileSize - overlap)).floor();
//         int displayCount = count ?? maxProfiles;
        
//         if (displayCount > profileImages.length) {
//           displayCount = profileImages.length;
//         }

//         bool showRemainingCount = profileImages.length > displayCount;
//         return SizedBox(
//           height: profileSize,
//           child: Stack(
//             children: List.generate(displayCount, (index) {
//               return Positioned(
//                 left: index * (profileSize - overlap),
//                 child: CircleAvatar(
//                   radius: profileSize / 2,
//                   backgroundImage: NetworkImage(profileImages[index]),
//                 ),
//               );
//             })
//               ..addAll(showRemainingCount
//                   ? [
//                       Positioned(
//                         left: displayCount * (profileSize - overlap),
//                         child: CircleAvatar(
//                           radius: profileSize / 2,
//                           backgroundColor: Colors.grey[300],
//                           child: Text(
//                             "+${profileImages.length - displayCount}",
//                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     ]
//                   : []),
//           ),
//         );
//       },
//     );
//   }
// }


