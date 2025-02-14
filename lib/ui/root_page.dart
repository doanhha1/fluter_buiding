import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import 'chat_page.dart';
import 'home_page.dart';
import 'notification_page.dart'; // Thêm trang hiển thị thông báo
import 'profile_page.dart';
import 'scan_qr_page.dart';
import 'history_electric.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;
  int _notificationCount = 3; // Số lượng thông báo mới (có thể thay đổi theo trạng thái thực tế)

  List<Widget> pages = [
    HomePage(),
    const ElectricUsagePage(),
    const ScanQrPage(),
     ChatPage(),
    const ProfilePage(),
  ];

  List<String> titleList = ['Home', 'History', 'Scan', 'Chat', 'Profile'];

  void _navigateToNotifications() {
    Navigator.push(
      context,
      PageTransition(
        child: const NotificationPage(), // Trang thông báo
        type: PageTransitionType.rightToLeft,
      ),
    ).then((_) {
      setState(() {
        _notificationCount = 0; // Đặt lại số thông báo sau khi đã xem
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Constants.blackColor,
                    size: 30,
                  ),
                  onPressed: _navigateToNotifications, // Điều hướng đến trang thông báo
                ),
                if (_notificationCount > 0) // Hiển thị badge nếu có thông báo
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$_notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const ScanQrPage(),
              type: PageTransitionType.bottomToTop,
            ),
          );
        },
        child: Image.asset(
          'assets/images/code-scan-two.png',
          height: 40,
        ),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
