class Job {
  final int id;
  final String title;
  final String shortDescription;
  final String description;
  final String mainImage;

  Job({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.mainImage,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      shortDescription: json['short_description'],
      description: json['description'],
      mainImage: json['main_image'],
    );
  }
}
