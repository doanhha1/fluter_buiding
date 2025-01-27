import 'package:fluter_building/screens/signin_screen.dart';
import 'package:fluter_building/screens/signup_screen.dart';
import 'package:flutter/material.dart'; // Thư viện Flutter Material Design, cung cấp các widget cơ bản để xây dựng giao diện.

import '../theme/theme.dart';
import '../widgets/custom_scaffold.dart'; // Import widget `CustomScaffold` từ thư mục widgets, dùng làm khung giao diện tùy chỉnh.
import '../widgets/welcome_button.dart'; // Import widget `WelcomeButton`, một nút bấm được thiết kế riêng.

class WelcomeScreen extends StatelessWidget { // Khai báo class `WelcomeScreen`, là một `StatelessWidget`.
  const WelcomeScreen({super.key}); // Constructor không trạng thái (const), có `key` để hỗ trợ widget tree.

  @override
  Widget build(BuildContext context) { // Hàm `build` dựng giao diện chính của widget.
    return CustomScaffold( // Sử dụng `CustomScaffold` làm khung chính của màn hình.
      child: Column( // Dùng `Column` để sắp xếp các widget con theo chiều dọc.
        children: [
          Flexible( // Widget con co giãn được, chiếm 8 phần tổng không gian của cột.
              flex: 8, // Đặt tỷ lệ co giãn là 8.
              child: Container( // Một widget chứa padding và nội dung.
                padding: const EdgeInsets.symmetric( // Padding cho nội dung bên trong, chỉ thiết lập ngang (horizontal).
                  vertical: 0, // Không có padding dọc.
                  horizontal: 40.0, // Padding ngang là 40px.
                ),
                child: Center( // Căn giữa nội dung bên trong `Container`.
                  child: RichText( // Hiển thị văn bản với nhiều kiểu dáng khác nhau.
                    textAlign: TextAlign.center, // Căn giữa toàn bộ đoạn văn bản.
                    text: const TextSpan( // Văn bản được định nghĩa bằng `TextSpan`, cho phép tùy chỉnh từng đoạn.
                      children: [
                        TextSpan(
                            text: 'Welcome Back!\n', // Phần văn bản đầu tiên.
                            style: TextStyle( // Định dạng kiểu dáng cho văn bản.
                              fontSize: 45.0, // Kích thước chữ 45px.
                              fontWeight: FontWeight.w600, // Độ đậm font trung bình.
                              color: Colors.black, // Màu chữ là xanh dương.
                            )),
                        TextSpan(
                            text: '\n Welcome to our management app!', // Phần văn bản tiếp theo.
                            style: TextStyle(
                              fontSize: 20, // Kích thước chữ 20px.
                              color: Colors.black, // Màu chữ là xám.
                              // height: 0, // Chiều cao dòng bị chú thích, có thể dùng để điều chỉnh khoảng cách dòng.
                            ))
                      ],
                    ),
                  ),
                ),
              )),
          Flexible( // Widget con thứ hai, chiếm 1 phần không gian còn lại của cột.
            flex: 1, // Đặt tỷ lệ co giãn là 1.
            child: Align( // Căn chỉnh nội dung bên trong (cột các nút).
              alignment: Alignment.bottomRight, // Đặt nội dung về góc dưới bên phải.
              child: Row( // Dùng `Row` để sắp xếp các nút theo chiều ngang.
                children: [
                  const Expanded( // `Expanded` giúp widget con chiếm toàn bộ không gian còn lại trong `Row`.
                    child: WelcomeButton( // Nút bấm `Sign in`.
                      buttonText: 'Sign in', // Văn bản hiển thị trên nút.
                      onTap: SignInScreen(), // Khi bấm vào nút, mở màn hình `SignInScreen` (có thể có lỗi vì truyền object thay vì hàm).
                      color: Colors.transparent, // Màu nền trong suốt.
                      textColor: Colors.white, // Màu chữ trắng.
                    ),
                  ),
                  // Expanded( // Nút thứ hai chiếm không gian còn lại của `Row`.
                  //   child: WelcomeButton(
                  //     buttonText: 'Sign up', // Văn bản hiển thị là 'Sign up'.
                  //     onTap: const SignUpScreen(), // Khi bấm vào nút, mở màn hình `SignUpScreen` (có thể có lỗi tương tự như trên).
                  //     color: Colors.white, // Màu nền trắng.
                  //     textColor: lightColorScheme.primary, // Màu chữ là màu chính của `lightColorScheme` trong thme.
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
