import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const FormCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          height: 160,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                child: Image.asset(
                  imageUrl,
                  width: 120,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}