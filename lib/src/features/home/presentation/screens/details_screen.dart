import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../home.dart';

class DetailsScreen extends StatelessWidget {
  final InformationModel information;

  const DetailsScreen(this.information, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(information.name),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 4,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: CachedNetworkImageProvider(information.image),
            ),
          ),
          const SizedBox(height: 32),
          _InfoCard(title: "Status", value: information.status),
          const SizedBox(height: 16),
          _InfoCard(title: "Species", value: information.species),
          const SizedBox(height: 16),
          _InfoCard(title: "Gender", value: information.gender),
          const SizedBox(height: 16),
          _InfoCard(title: "Location", value: information.locationName),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.indigo.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Colors.indigo.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
