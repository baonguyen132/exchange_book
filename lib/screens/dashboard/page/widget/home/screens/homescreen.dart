import 'package:project_admin/data/ConstraintData.dart';

import '../widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/create_post_container.dart';
import '../models/models.dart';
import '../widgets/stories.dart';
import '../widgets/post_container.dart';
import 'package:project_admin/theme/theme.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // After
    final User currentUser = User(
      name: 'Bảo Nguyên',
      imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
    );
    final List<Story> stories = [
      Story(
        user: User(
          name: 'Bảo Nguyên',
          imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
        ),
        imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
      ),
      Story(
        user: User(
          name: 'Thanh Phương',
          imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
        ),
        imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
      ),
      Story(
        user: User(
          name: 'Him',
          imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
        ),
        imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
      ),
    ];
    final List<Post> posts = [
      Post(
        user: currentUser,
        caption: 'Tôi đang muốn bán loại sách này, giá ưu đãi \n, Liên hệ 098765421',
        timeAgo: '5m',
        imageUrl: location+"/public/image_book_client/20250416_102442.jpg",
        likes: 120,
        comments: 10,
        shares: 5,
      ),
      Post(
        user: User(
          name: 'Thanh Phương',
          imageUrl: 'https://th.bing.com/th/id/OIP.W6og9wi7EZmkxVmgQhltugHaHa?rs=1&pid=ImgDetMain',
        ),
        caption: '안녕하세요!',
        timeAgo: '2h',
        imageUrl: location+"/public/image_book_client/20250416_102252.jpg",
        likes: 250,
        comments: 20,
        shares: 8,
      ),
    ];


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: CreatePostContainer(currentUser: currentUser),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Stories(
                currentUser: currentUser,
                stories: stories,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final Post post = posts[index];
                return PostContainer(post: post);
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
