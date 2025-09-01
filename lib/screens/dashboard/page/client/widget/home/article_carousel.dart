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
      'title': 'Lợi ích của trao đổi sách',
      'desc': 'Giảm lãng phí và chia sẻ tri thức trong cộng đồng.',
      'url': 'https://www.facebook.com/'
    },
    {
      'title': 'Cách tổ chức góc trao đổi sách',
      'desc': 'Hướng dẫn nhỏ để bắt đầu một điểm trao đổi sách.',
      'url': 'https://example.com/article2'
    },
    {
      'title': 'Câu chuyện cộng đồng',
      'desc': 'Những câu chuyện truyền cảm hứng từ việc trao đổi sách.',
      'url': 'https://example.com/article3'
    },
    {
      'title': 'Tiết kiệm khi đọc sách',
      'desc': 'Mẹo để tiếp cận nhiều sách với chi phí thấp.',
      'url': 'https://example.com/article4'
    },
    {
      'title': 'Ý tưởng hoạt động sách',
      'desc': 'Sự kiện và hoạt động kết nối bằng sách.',
      'url': 'https://example.com/article5'
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
                      color: theme.primaryColor.withOpacity(0.08),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.article,
                        color: theme.primaryColor, size: 36),
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
  const ArticleWebView({required this.url, required this.title, Key? key}): super(key: key);

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
