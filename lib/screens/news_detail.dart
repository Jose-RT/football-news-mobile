import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsEntry news;

  const NewsDetailPage({super.key, required this.news});

  String _formatDate(DateTime date) {
    // Simple date formatter without intl package
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasThumbnail = news.thumbnail?.isNotEmpty == true;
    final String thumbnailUrl = news.thumbnail ?? '';
    final String content = news.content ?? '';
    final thumbnailWidget = hasThumbnail
        ? Image.network(
            'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(thumbnailUrl)}',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, size: 50),
              ),
            ),
          )
        : Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
            ),
          );

        // Create children for the main content column
        final contentChildren = <Widget>[
          // Title
          Text(
            news.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Category and Date
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  news.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _formatDate(news.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Views count
          Row(
            children: [
              Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${news.newsViews} views',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          // Full content
          Text(
            content,
            style: const TextStyle(
              fontSize: 16.0,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),
        ];

        // Add featured badge to the beginning if needed
        if (news.isFeatured) {
          contentChildren.insert(0,
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 6.0),
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'Featured',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('News Detail'),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                thumbnailWidget,

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: contentChildren,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }