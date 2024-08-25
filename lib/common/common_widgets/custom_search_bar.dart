import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String?) onSearchChanged;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onIconPressed;
  final Icon? icon;
  const CustomSearchBar(
      {super.key,
      required this.onSearchChanged,
      required this.hint,
      required this.controller,
      required this.onIconPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) => onSearchChanged(value),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: onIconPressed,
            icon: icon ??
                const Icon(
                  Icons.circle,
                  color: Color.fromARGB(255, 202, 200, 200),
                  size: 1.0,
                ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
