import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? Function(String?) validator;
  final bool isDark; // إضافة خاصية isDark

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    required this.validator,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white : Colors.black87, // دعم الثيم
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400, // دعم الثيم
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400, // دعم الثيم
              ),
            ),
          ),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black, // دعم الثيم للنص داخل الحقل
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}