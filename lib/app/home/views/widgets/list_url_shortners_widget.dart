import 'package:flutter/material.dart';
import 'package:url_shortener_app/app/home/models/home_model.dart';

class ListUrlShortnersWidget extends StatelessWidget {
  const ListUrlShortnersWidget({
    super.key,
    required this.data,
    required this.onPressed,
  });

  final List<HomeModel> data;
  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          const Text(
            'URLs encurtadas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final url = data[index];

                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      url.urlShort,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      url.urlLong,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => onPressed(url.urlShort),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
