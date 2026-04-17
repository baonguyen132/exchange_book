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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.link != null ? () => _launchUrl(widget.link!) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? colorScheme.primary.withOpacity(0.05) : colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? colorScheme.primary.withOpacity(0.3) : colorScheme.onSurface.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Platform icon
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.link, color: colorScheme.primary, size: 20);
                  },
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
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    if (widget.link != null)
                      Text(
                        widget.link!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

              // Launch icon
              if (widget.link != null)
                Icon(
                  Icons.open_in_new_rounded,
                  size: 18,
                  color: _isHovered ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.2),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

