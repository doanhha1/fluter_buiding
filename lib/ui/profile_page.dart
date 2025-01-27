// import 'package:flutter/material.dart';
//
// import '../constants.dart';
// import '../widgets/profile_widget.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(15),
//             height: size.height,
//             width: size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 150,
//                   child: const CircleAvatar(
//                     radius: 60,
//                     backgroundImage: ExactAssetImage('assets/images/cute.jpg'),
//                   ),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Constants.primaryColor.withOpacity(.5),
//                       width: 5.0,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//
//
//                 SizedBox(
//                   width: size.width * .3,
//                   child: Row(
//                     children: [
//                       Text(
//                         'John Doe',
//                         style: TextStyle(
//                           color: Constants.blackColor,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(
//                           height: 24,
//                           child: Image.asset("assets/images/tichXanh.png")),
//                     ],
//                   ),
//                 ),
//
//                 Text(
//                   'johndoe@gmail.com',
//                   style: TextStyle(
//                     color: Constants.blackColor.withOpacity(.3),
//                   ),
//                 ),
//
//  // -----phần tùy chọn ở dưới
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   height: size.height * .7,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: const [
//                       ProfileWidget(
//                         icon: Icons.person,
//                         title: 'My Profile',
//                       ),
//                       ProfileWidget(
//                         icon: Icons.settings,
//                         title: 'Language',
//                       ),
//                       ProfileWidget(
//                         icon: Icons.assignment,
//                         title: 'Contract',
//                       ),
//                       ProfileWidget(
//                         icon: Icons.chat,
//                         title: 'FAQs',
//                       ),
//
//                       ProfileWidget(
//                         icon: Icons.logout,
//                         title: 'Log Out',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//
//   }
// }


//
// import 'package:flutter/material.dart';
// import '../constants.dart';
//
// import '../screens/signin_screen.dart';
// import '../widgets/profile_widget.dart';
// import 'Profile_Page/contract_page.dart';
// import 'Profile_Page/faqs_page.dart';
// import 'Profile_Page/language_page.dart';
// import 'Profile_Page/myProfile_page.dart';
// import 'Profile_Page/profile_widget.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           height: size.height,
//           width: size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Avatar + Name + Email
//               Container(
//                 width: 150,
//                 child: const CircleAvatar(
//                   radius: 60,
//                   backgroundImage: ExactAssetImage('assets/images/cute.jpg'),
//                 ),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Constants.primaryColor.withOpacity(.5),
//                     width: 5.0,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'John Doe',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 5),
//                   SizedBox(
//                     height: 24,
//                     child: Image.asset("assets/images/tichXanh.png"),
//                   ),
//                 ],
//               ),
//               const Text(
//                 'johndoe@gmail.com',
//                 style: TextStyle(color: Colors.grey),
//               ),
//
//               // Options
//               const SizedBox(height: 30),
//               SizedBox(
//                 height: size.height * .7,
//                 width: size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ProfileWidget(
//                       icon: Icons.person,
//                       title: 'My Profile',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const MyProfilePage()));
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.settings,
//                       title: 'Language',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguagePage()));
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.assignment,
//                       title: 'Contract',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ContractPage()));
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.chat,
//                       title: 'FAQs',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQsPage()));
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.logout,
//                       title: 'Log Out',
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text('Log Out'),
//                             content: const Text('Are you sure you want to log out?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(builder: (_) => const SignInScreen()),
//                                   );
//                                 },
//                                 child: const Text('Log Out'),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../constants.dart';

import '../screens/signin_screen.dart';
import 'Profile_Page/contract_page.dart';
import 'Profile_Page/faqs_page.dart';
import 'Profile_Page/language_page.dart';
import 'Profile_Page/myProfile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Profile Page"),
      //   backgroundColor: Constants.primaryColor,
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar + Name + Email
              Container(
                width: 150,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/cute.jpg'),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    height: 24,
                    child: Image.asset("assets/images/tichXanh.png"),
                  ),
                ],
              ),
              const Text(
                'johndoe@gmail.com',
                style: TextStyle(color: Colors.grey),
              ),

              // Options
              const SizedBox(height: 30),
              Column(
                children: [
                  // My Profile
                  buildOptionCard(
                    context,
                    icon: Icons.person,
                    title: "My Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyProfilePage()),
                      );
                    },
                  ),

                  // Language
                  buildOptionCard(
                    context,
                    icon: Icons.settings,
                    title: "Language",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguagePage()),
                      );
                    },
                  ),

                  // Contract
                  buildOptionCard(
                    context,
                    icon: Icons.assignment,
                    title: "Contract",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ContractPage()),
                      );
                    },
                  ),

                  // FAQs
                  buildOptionCard(
                    context,
                    icon: Icons.chat,
                    title: "FAQs",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FAQsPage()),
                      );
                    },
                  ),

                  // Log Out
                  buildOptionCard(
                    context,
                    icon: Icons.logout,
                    title: "Log Out",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Log Out'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                                );
                              },
                              child: const Text('Log Out'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to build an individual option card
  Widget buildOptionCard(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Constants.primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
        onTap: onTap, // Callback function
      ),
    );
  }
}
