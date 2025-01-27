// import 'package:flutter/material.dart';
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, String>> notifications = [
//       {"title": "Hoan Phat", "content": "vừa đăng 2 ảnh mới vào nhật ký", "time": "18:21 hôm qua"},
//       {"title": "Phan Hung", "content": "vừa đăng 4 ảnh mới vào nhật ký", "time": "4 ngày trước"},
//       {"title": "Gia Thịnh", "content": "vừa quay lại đăng ảnh mới", "time": "6 ngày trước"},
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Thông báo"),
//       ),
//       body: ListView.builder(
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           final notification = notifications[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.blueAccent,
//               child: Text(notification["title"]![0]),
//             ),
//             title: Text(notification["title"]!),
//             subtitle: Text(notification["content"]!),
//             trailing: Text(notification["time"]!),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Danh sách thông báo với trạng thái đã đọc hoặc chưa đọc
  List<Map<String, dynamic>> notifications = [
    {"title": "Hoan Phat", "content": "vừa đăng 2 ảnh mới vào nhật ký Dưới đây là một cách cập nhật mã để thêm tính năng mà bạn yêu cầu. Khi nhấp vào thông báo, nội dung sẽ mở rộng, và khi nhấp vào thông báo khác, cái đã mở sẽ tự thu nhỏ lại. Đồng thời, thông báo chưa đọc sẽ nổi bật hơn thông báo đã đọc.Dưới đây là một cách cập nhật mã để thêm tính năng mà bạn yêu cầu. ", "time": "18:21 hôm qua", "isRead": false},
    {"title": "Phan Hung", "content": "vừa đăng 4 ảnh mới vào nhật ký", "time": "4 ngày trước", "isRead": false},
    {"title": "Gia Thịnh", "content": "vừa quay lại đăng ảnh mới", "time": "6 ngày trước", "isRead": true},
  ];

  // Chỉ số thông báo đang mở rộng (nếu không có, giá trị sẽ là null)
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          // Kiểm tra xem thông báo có đang được mở rộng không
          final bool isExpanded = expandedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                // Nếu nhấp vào thông báo đang mở, thu nhỏ lại
                // Nếu nhấp vào thông báo khác, mở rộng thông báo đó
                expandedIndex = isExpanded ? null : index;
                // Đánh dấu thông báo là đã đọc
                notifications[index]['isRead'] = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: notification['isRead'] ? Colors.grey.shade200 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isExpanded
                    ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề thông báo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: notification['isRead'] ? Colors.black54 : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        notification['time'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Nội dung chính
                  Text(
                    notification['content'],
                    maxLines: isExpanded ? null : 1, // Nếu mở rộng, hiển thị toàn bộ nội dung
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: TextStyle(
                      color: notification['isRead'] ? Colors.black54 : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 12),
                    // Nội dung chi tiết hơn khi mở rộng (có thể thêm thông tin chi tiết hơn nếu cần)
                    Text(
                      "Chi tiết thông báo: ${notification['content']}",
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
