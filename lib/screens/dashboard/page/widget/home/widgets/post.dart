import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Tạo bài viết'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('ĐĂNG', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain'),
              ),
              title: Text('Nguyễn Thanh Phương', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Wrap(
                spacing: 5,
                children: [
                  Chip(label: Text('Album'), avatar: const Icon(Icons.image, color: Colors.green),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Bạn đang nghĩ gì?',
                  border: InputBorder.none,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.image, color: Colors.green), onPressed: () {}),
                IconButton(icon: Icon(Icons.tag, color: Colors.blue), onPressed: () {}),
                IconButton(icon: Icon(Icons.emoji_emotions, color: Colors.orange), onPressed: () {}),
                IconButton(icon: Icon(Icons.location_on, color: Colors.red), onPressed: () {}),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}