

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'Home_Page/list_room.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late InAppWebViewController _webViewController;

  // Phần BỘ LỌC CAÁC PHÒNG CÒN TRỐNG
  // Bộ lọc phòng trống
  String selectedArea = "Tất cả";
  String selectedFloor = "Tất cả";
  String selectedPrice = "Tất cả";
  String selectedSize = "Tất cả";

  List<Map<String, String>> rooms = [
    {"image": "assets/images/room1.jpg", "price": "8,000,000 VND/tháng", "area": "40m²", "location": "A", "floor": "3", "floorplan": "assets/images/banve1.png"},
    {"image": "assets/images/room2.jpg", "price": "12,000,000 VND/tháng", "area": "60m²", "location": "B", "floor": "7", "floorplan": "assets/images/banve1.png"},
    {"image": "assets/images/room3.jpg", "price": "15,000,000 VND/tháng", "area": "80m²", "location": "C", "floor": "10", "floorplan": "assets/images/banve1.png"},
    {"image": "assets/images/room1.jpg", "price": "18,000,000 VND/tháng", "area": "40m²", "location": "A", "floor": "3", "floorplan": "assets/images/banve1.png"},
  ];

  List<Map<String, String>> getFilteredRooms() {
    return rooms.where((room) {
      bool matchArea = selectedArea == "Tất cả" || room["location"] == selectedArea;
      bool matchFloor = selectedFloor == "Tất cả" || room["floor"] == selectedFloor;
      bool matchPrice = selectedPrice == "Tất cả" || _isMatchingPrice(room["price"]!);
      bool matchSize = selectedSize == "Tất cả" || _isMatchingSize(room["area"]!);
      return matchArea && matchFloor && matchPrice && matchSize;
    }).toList();
  }

  bool _isMatchingPrice(String price) {
    if (selectedPrice == "Dưới 10 triệu") {
      return price.contains("8,000,000");
    } else if (selectedPrice == "10-20 triệu") {
      return price.contains("12,000,000") || price.contains("15,000,000");
    } else if (selectedPrice == "Trên 20 triệu") {
      return false;
    }
    return true;
  }

  bool _isMatchingSize(String size) {
    int area = int.parse(size.replaceAll("m²", ""));
    if (selectedSize == "Dưới 50m²") {
      return area < 50;
    } else if (selectedSize == "50-100m²") {
      return area >= 50 && area <= 100;
    } else if (selectedSize == "Trên 100m²") {
      return area > 100;
    }
    return true;
  }

  // void _showFilterModal() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,  // Cho phép modal mở rộng
  //     backgroundColor: Colors.transparent,  // Nền trong suốt
  //     builder: (context) {
  //       return Container(
  //         padding: EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //           boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text("Bộ lọc", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //             SizedBox(height: 10),
  //             _buildDropdown("Khu vực", ["Tất cả", "A", "B", "C"], (value) => setState(() => selectedArea = value)),
  //             _buildDropdown("Số tầng", ["Tất cả", "3", "7", "10"], (value) => setState(() => selectedFloor = value)),
  //             _buildDropdown("Giá tiền", ["Tất cả", "Dưới 10 triệu", "10-20 triệu", "Trên 20 triệu"], (value) => setState(() => selectedPrice = value)),
  //             _buildDropdown("Diện tích", ["Tất cả", "Dưới 50m²", "50-100m²", "Trên 100m²"], (value) => setState(() => selectedSize = value)),
  //             SizedBox(height: 15),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.blueAccent,
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
  //               ),
  //               onPressed: () {
  //                 setState(() {});
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Áp dụng", style: TextStyle(fontSize: 16)),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // show video
  void _showFullScreenVideo(BuildContext context, String videoUrl) async {
    // Cho phép cả xoay dọc và ngang
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: OrientationBuilder(
            builder: (context, orientation) {
              return Stack(
                children: [
                  Center(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(videoUrl)),
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        mediaPlaybackRequiresUserGesture: false,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () async {
                        // Trả màn hình về dọc khi đóng video
                        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'DỊCH VỤ QUẢN LÝ TÀI SẢN',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cải thiện cuộc sống của các nhà đầu tư và cư dân bất động sản từ năm 1978',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Phần Giới Thiệu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hình video bên trái
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _showFullScreenVideo(context, "https://www.youtube.com/embed/MQOUO6an-zA");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 200, // Điều chỉnh chiều cao video
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                              url: WebUri("https://www.youtube.com/embed/MQOUO6an-zA"),
                            ),
                            initialSettings: InAppWebViewSettings(
                              javaScriptEnabled: true,
                              mediaPlaybackRequiresUserGesture: false,
                            ),
                            onWebViewCreated: (controller) {
                              _webViewController = controller;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20), // Khoảng cách giữa ảnh và text

                  // Nội dung bên phải
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GIỚI THIỆU VỀ CHÚNG TÔI',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Giải pháp quản lý tòa nhà toàn diện',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'B-MS tiên phong trong PropTech Việt Nam,'
                              ' mang đến quản lý tối ưu và kết nối cư dân hiệu quả.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green, size: 10),
                            SizedBox(width: 5),
                            Text('Quản lý tối ưu qua Web & App', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green, size: 10),
                            SizedBox(width: 5),
                            Text('Kết nối cư dân & ban quản lý ', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),



            const SizedBox(height: 30),

            // Testimonials Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'LỜI CHỨNG THỰC',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ĐỐI TÁC VÀ KHÁCH HÀNG NÓI GÌ?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 200,
                    child: PageView(
                      children: [
                        _buildTestimonialCard(
                          'Elon Musk',
                          'CEO, Tesla & SpaceX',
                          'B-MS đã giúp chúng tôi tối ưu hóa quản lý bất động sản với công nghệ tiên tiến. Đội ngũ chuyên nghiệp, giải pháp sáng tạo – tôi thực sự ấn tượng!',
                          'assets/images/ElonMusk.jpg',
                        ),
                        _buildTestimonialCard(
                          'Phạm Nhật Vượng',
                          'Chủ tịch, Vingroup',
                          'Tôi đánh giá cao cách B-MS mang lại giải pháp toàn diện, giúp các dự án của chúng tôi vận hành trơn tru và gia tăng giá trị cho cư dân.',
                          'assets/images/PhamNhatVuong.jpg',
                        ),
                        _buildTestimonialCard(
                          'Jeff Bezos',
                          'Nhà sáng lập, Amazon',
                          'B-MS thực sự hiểu rõ nhu cầu của các doanh nghiệp lớn. Công nghệ hiện đại, dịch vụ tận tâm – đây là chìa khóa để tối ưu hóa quản lý tài sản.',
                          'assets/images/JeffBeros.jpg',
                        ),
                        _buildTestimonialCard(
                          'Jack Ma',
                          'Nhà sáng lập, Alibaba',
                          'Việc áp dụng công nghệ vào quản lý bất động sản là điều không thể tránh khỏi. B-MS đã làm điều đó xuất sắc, giúp doanh nghiệp hoạt động hiệu quả hơn.',
                          'assets/images/Jackma.jpg',
                        ),
                        _buildTestimonialCard(
                          'Shark Hưng',
                          'Phó Chủ tịch, CEN Group',
                          'B-MS không chỉ là một nền tảng, mà còn là đối tác chiến lược giúp doanh nghiệp phát triển bền vững. Đây là một sự đầu tư xứng đáng!',
                          'assets/images/SharkHung.jpg',
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Room Listings Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề + Icon bộ lọc
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PHÒNG TRỐNG HIỆN CÓ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.filter_list, color: Colors.blue),
                      //   onPressed: () {
                      //     _showFilterModal();
                      //   },
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Danh sách phòng trống
                  SizedBox(
                    height: 300, // Đặt chiều cao cố định
                    child: ListView.builder(
                      shrinkWrap: true, // Tránh lỗi unbounded height
                      physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn của ListView
                      itemCount: getFilteredRooms().length,
                      itemBuilder: (context, index) {
                        final room = getFilteredRooms()[index];
                        return ListTile(
                          leading: Image.asset(room["image"]!),
                          title: Text(room["price"]!),
                          subtitle: Text(
                            "Diện tích: ${room["area"]} - Vị trí: ${room["location"]} - Tầng: ${room["floor"]}",
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListRooms()),
                        );
                      },
                      child: Text('Xem tất cả phòng'),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}

// Testimonials Card Phần LỜI CHỨNG THỰC
Widget _buildTestimonialCard(String name, String position, String content, String imagePath) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                  Text(position, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

// Room Card PHÒNG TRỐNG HIỆN CÓ
Widget _buildRoomCard(String imagePath, String price, String area, String location, String floor, String floorplan) {
  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Diện tích: $area', style: const TextStyle(fontSize: 14)),
                Text('Vị trí: $location', style: const TextStyle(fontSize: 14)),
                Text('Tầng: $floor', style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Image.asset(floorplan, width: 80, height: 80, fit: BoxFit.cover),
        ],
      ),
    ),
  );
}

// //  Widget  cu bộ lọc
// Widget _buildDropdown(String label, List<String> items, ValueChanged<String> onChanged) {
//   return DropdownButtonFormField<String>(
//     value: items.first,
//     items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//     onChanged: (String? value) {
//       if (value != null) {
//         onChanged(value);
//       }
//     },
//     decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//   );
// }