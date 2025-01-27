import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'chat/components/chat.dart';
import 'chat/models/chat_users.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "", time: "Now"),
    ChatUsers(text: "Glady's Murphy", secondaryText: "That's Great", image: "", time: "Yesterday"),
    ChatUsers(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "", time: "31 Mar"),
    ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "", time: "28 Mar"),
    ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "", time: "23 Mar"),
    ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "", time: "17 Mar"),
    ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "", time: "24 Feb"),
    ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "", time: "18 Feb"),
  ];


// phần ADD DROUP
  void _showCreateGroupDialog() {
    final groupNameController = TextEditingController();
    final selectedUsers = <ChatUsers>[]; // Danh sách người dùng được chọn
    List<ChatUsers> filteredUsers = List.from(chatUsers); // Danh sách người dùng để lọc khi tìm kiếm

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor, // Màu xanh lá từ Constants
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Create Group",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Body
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Input for group name
                          TextField(
                            controller: groupNameController,
                            decoration: InputDecoration(
                              hintText: "Enter group name",
                              prefixIcon: const Icon(Icons.group),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Search bar
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                filteredUsers = chatUsers
                                    .where((user) => user.text
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search by name or phone number",
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // List of users
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = filteredUsers[index];
                                final isSelected = selectedUsers.contains(user);

                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Constants.primaryColor.withOpacity(0.3),
                                      child: Text(
                                        user.text[0],
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(user.text),
                                    subtitle: Text(user.secondaryText),
                                    trailing: Checkbox(
                                      shape: const CircleBorder(),
                                      activeColor: Constants.primaryColor, // Sử dụng màu từ Constants
                                      value: isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedUsers.add(user);
                                          } else {
                                            selectedUsers.remove(user);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Selected users
                          if (selectedUsers.isNotEmpty)
                            Container(
                              height: 80,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedUsers.length,
                                itemBuilder: (context, index) {
                                  final user = selectedUsers[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Chip(
                                      label: Text(user.text),
                                      backgroundColor: Constants.primaryColor.withOpacity(0.7),
                                      deleteIcon: const Icon(Icons.close, color: Colors.white),
                                      onDeleted: () {
                                        setState(() {
                                          selectedUsers.remove(user);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor, // Sử dụng màu từ Constants
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (groupNameController.text.isNotEmpty &&
                            selectedUsers.isNotEmpty) {
                          setState(() {
                            chatUsers.insert(
                              0,
                              ChatUsers(
                                text: groupNameController.text,
                                secondaryText: "Group created",
                                image: "",
                                time: "Now",
                              ),
                            );
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Group '${groupNameController.text}' created"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please add a name and select users."),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Create Group",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// phần ADD FRIEND
  void _showAddFriendDialog() {
    final friendNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Friend"),
          content: TextField(
            controller: friendNameController,
            decoration: const InputDecoration(
              hintText: "Enter friend's name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (friendNameController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Friend '${friendNameController.text}' added")),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Message",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    PopupMenuButton(
                      icon: Row(
                        children: [
                          Icon(Icons.add, color: Colors.pink, size: 20),
                          SizedBox(width: 2),
                          Text(
                            "New",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'add_friend',
                          child: Row(
                            children: const [
                              Icon(Icons.person_add, color: Colors.pink),
                              SizedBox(width: 8),
                              Text("Add Friend"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'create_group',
                          child: Row(
                            children: const [
                              Icon(Icons.group_add, color: Colors.pink),
                              SizedBox(width: 8),
                              Text("Create Group"),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'add_friend') {
                          _showAddFriendDialog();
                        } else if (value == 'create_group') {
                          _showCreateGroupDialog();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  text: chatUsers[index].text,
                  secondaryText: chatUsers[index].secondaryText,
                  image: chatUsers[index].image,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


