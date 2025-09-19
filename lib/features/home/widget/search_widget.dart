import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onSearchChanged;

  const SearchBarWithFilter({
    super.key,
    required this.controller,
    required this.onFilterTap,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
            ),
          ),
        ),
        const SizedBox(width: 10),

        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              "assets/images/filter.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
