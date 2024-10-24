import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextInputType? textInputType;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap; // Add onTap callback for interaction
  final bool readOnly; // Add readOnly to make the field non-editable

  const CustomTextField({
    this.controller,
    this.suffixIcon,
    this.textInputType,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false, // Default to false to allow typing
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            CustomTextWidget(
              text: widget.labelText ?? '',
              fontSize: 14,
            ),
          const SizedBox(height: 5),
          TextField(
            controller: widget.controller,
            obscureText: widget.suffixIcon != null ? _obscureText : false,
            readOnly: widget.readOnly, // Set to true for non-editable fields
            onTap: widget.onTap, // Call the onTap method when tapped
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        _toggleObscureText();
                        widget.suffixIcon?.onPressed?.call();
                      },
                    )
                  : null,
            ),
            keyboardType: widget.textInputType,
          ),
        ],
      ),
    );
  }
}
