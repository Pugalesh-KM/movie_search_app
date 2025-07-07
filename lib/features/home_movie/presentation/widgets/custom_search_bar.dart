import 'package:flutter/material.dart';
import 'package:movie_search_app/shared/config/dimens.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: theme.iconTheme.color),
          hintText: 'Search movies...',
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.hintColor,
          ),
          border: InputBorder.none,
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: theme.iconTheme.color),
            onPressed: onClear,
          )
              : null,
        ),
      ),
    );
  }
}
