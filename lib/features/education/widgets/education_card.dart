import 'package:flutter/material.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EducationCard extends StatelessWidget {
  final Map<String, dynamic> education;
  EducationCard({super.key, required this.education});

  final String? baseUrl = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4, // Add shadow effect
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Makes sure Card wraps content
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Responsive height based on width
                child:
                    baseUrl != null
                        ? Image.network(
                          '$baseUrl/data/images/education/${education['image_path']}',
                          fit:
                              BoxFit.cover, // Makes image fit the card properly
                          width: double.infinity, // Ensure full width
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 100,
                            ); // Fallback if image fails
                          },
                        )
                        : const Icon(
                          Icons.error,
                          size: 100,
                        ), // Error icon if baseUrl is null
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    education['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    htmlParser
                            .parse(education['short_description'] ?? '')
                            .documentElement
                            ?.text ??
                        '',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Watch Video',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
