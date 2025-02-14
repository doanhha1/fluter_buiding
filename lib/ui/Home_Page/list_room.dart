import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListRooms extends StatefulWidget {
  @override
  _ListRoomsState createState() => _ListRoomsState();
}

class _ListRoomsState extends State<ListRooms> {
  static const _pageSize = 10;
  final PagingController<int, Room> _pagingController = PagingController(firstPageKey: 0);

  String? selectedLocation;
  String? selectedFloor;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchRooms(pageKey, _pageSize, selectedLocation, selectedFloor);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _applyFilter() {
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách phòng')),
      body: Column(
        children: [
          // Bộ lọc
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bộ lọc vị trí
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedLocation,
                    decoration: InputDecoration(
                      labelText: "Chọn vị trí",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value == "Tất cả" ? null : value;
                        _applyFilter();
                      });
                    },
                    items: ["Tất cả", "A", "B", "C", "D", "E"]
                        .map((location) => DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    ))
                        .toList(),
                  ),
                ),
                SizedBox(width: 10),
                // Bộ lọc tầng
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFloor,
                    decoration: InputDecoration(
                      labelText: "Chọn tầng",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedFloor = value == "Tất cả" ? null : value;
                        _applyFilter();
                      });
                    },
                    items: ["Tất cả", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
                        .map((floor) => DropdownMenuItem(
                      value: floor,
                      child: Text(floor),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // Danh sách phòng
          Expanded(
            child: PagedListView<int, Room>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Room>(
                itemBuilder: (context, room, index) => Card(
                  color: Colors.grey[200],
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Hình ảnh phòng
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(room.image, width: 90, height: 90, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 12),
                        // Thông tin phòng
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.price,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Diện tích: ${room.area}",
                                style: TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                              Text(
                                "Vị trí: ${room.location} - Tầng: ${room.floor}",
                                style: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dữ liệu mẫu có lọc
Future<List<Room>> fetchRooms(int page, int pageSize, String? location, String? floor) async {
  await Future.delayed(Duration(seconds: 2)); // Giả lập độ trễ API

  List<Room> rooms = [
    Room("assets/images/room1.jpg", "8,000,000 VND/tháng", "40m²", "A", "3"),
    Room("assets/images/room2.jpg", "12,000,000 VND/tháng", "60m²", "B", "7"),
    Room("assets/images/room3.jpg", "15,000,000 VND/tháng", "80m²", "C", "10"),
    Room("assets/images/room1.jpg", "18,000,000 VND/tháng", "40m²", "A", "3"),
    Room("assets/images/room2.jpg", "20,000,000 VND/tháng", "70m²", "D", "5"),
    Room("assets/images/room3.jpg", "25,000,000 VND/tháng", "90m²", "E", "1"),
    Room("assets/images/room1.jpg", "30,000,000 VND/tháng", "100m²", "A", "5"),
    Room("assets/images/room2.jpg", "35,000,000 VND/tháng", "120m²", "A", "2"),
    Room("assets/images/room3.jpg", "40,000,000 VND/tháng", "150m²", "D", "2"),
    Room("assets/images/room1.jpg", "50,000,000 VND/tháng", "200m²", "C", "6"),
  ];

  List<Room> filteredRooms = rooms.where((room) {
    if (location != null && room.location != location) return false;
    if (floor != null && room.floor != floor) return false;
    return true;
  }).toList();

  int startIndex = page * pageSize;
  int endIndex = startIndex + pageSize;
  return filteredRooms.sublist(startIndex, endIndex > filteredRooms.length ? filteredRooms.length : endIndex);
}

class Room {
  final String image;
  final String price;
  final String area;
  final String location;
  final String floor;

  Room(this.image, this.price, this.area, this.location, this.floor);
}
