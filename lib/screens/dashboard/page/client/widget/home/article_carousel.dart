import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleCarousel extends StatefulWidget {
  const ArticleCarousel({super.key});

  @override
  State<ArticleCarousel> createState() => _ArticleCarouselState();
}

class _ArticleCarouselState extends State<ArticleCarousel> {
  // Sample articles (replace with real links)
  final List<Map<String, String>> _articles = [
    {
      'title': 'SGK dùng 1 lần liệu có lãng phí?',
      'images': 'assets/images/anhsach1.jpeg',
      'desc': 'Giảm lãng phí và chia sẻ tri thức trong cộng đồng.',
      'url':
          'https://vnexpress.net/sach-giao-khoa-bi-lang-phi-nhu-the-nao-4465784.html'
    },
    {
      'title': 'Hưởng ứng trao đổi sách',
      'images': 'assets/images/anhsach2.jpeg',
      'desc': 'Hướng dẫn nhỏ để bắt đầu một điểm trao đổi sách.',
      'url':
          'https://www.neu.edu.vn/vi/ban-tin-neu/ngay-hoi-trao-doi-sach-mo-hinh-hoat-dong-doan-tiep-tuc-duoc-vinh-danh-trong-hoat-dong-doan-tp-ha-noi-nam-2012'
    },
    {
      'title': 'Câu chuyện cộng đồng',
      'images': 'assets/images/anhsach3.jpeg',
      'desc': 'Những câu chuyện truyền cảm hứng từ việc trao đổi sách.',
      'url':
          'https://cuoituan.tuoitre.vn/noi-niem-sach-cu-20250117103534957.htm'
    },
    {
      'title': 'Các điểm tập kết sách cũ',
      'images': 'assets/images/anhsach4.jpeg',
      'desc': 'Mẹo để tiếp cận nhiều sách với chi phí thấp.',
      'url': 'https://khamphadanang.vn/tiem-sach-cu-da-nang/'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.only(right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _articles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final a = _articles[index];
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ArticleWebView(
                      url: a['url'] ?? '',
                      title: a['title'] ?? 'Bài viết',
                    ))),
            child: Container(
              width: 260,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  // thumbnail
                  Container(
                    width: 90,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                            a['images'] ?? 'assets/images/anhsach1.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  // text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            a['title'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(a['desc'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Top-level WebView page to display an article
class ArticleWebView extends StatefulWidget {
  final String url;
  final String title;
  const ArticleWebView({required this.url, required this.title, Key? key})
      : super(key: key);

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse(widget.url.isNotEmpty ? widget.url : 'about:blank'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.url));
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã sao chép link')));
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
