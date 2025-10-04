import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroduceProfileItem extends StatefulWidget {
  final String text;
  final String imageUrl;
  final String? link;

  const IntroduceProfileItem({
    super.key,
    required this.text,
    required this.imageUrl,
    this.link,
  });

  @override
  State<IntroduceProfileItem> createState() => _IntroduceProfileItemState();
}

class _IntroduceProfileItemState extends State<IntroduceProfileItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.link != null ? () => _launchUrl(widget.link!) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.blue.shade50 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered ? Colors.blue.shade200 : Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Platform icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.link,
                            color: Colors.grey.shade600,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Platform name and link
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.link != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.link!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow icon
                if (widget.link != null)
                  Icon(
                    Icons.launch,
                    size: 20,
                    color: _isHovered
                        ? Colors.blue.shade600
                        : Colors.grey.shade500,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
