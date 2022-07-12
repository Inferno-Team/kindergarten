import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final String hint;
  final TextInputType type;
  final IconData icon;
  final IconData? suffixIcon;
  final Function()? onSuffixIconTap;
  final bool obscureText;
  final String defaultValue;
  final void Function(String?) onChange;

  CustomInput(
      {Key? key,
      this.text = "",
      this.hint = "",
      required this.onChange,
      this.type = TextInputType.text,
      this.icon = Icons.email,
      this.suffixIcon,
      this.obscureText = false,
      this.defaultValue = '',
      this.onSuffixIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          TextFormField(
            initialValue: defaultValue,
            obscureText: obscureText,
            keyboardType: type,
            onChanged: onChange,
            
            decoration: InputDecoration(
              labelText: text,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              floatingLabelStyle: const TextStyle(
                color: Color(0xFF4C85FF),
              ),
              fillColor: const Color.fromARGB(255, 168, 196, 255),
              prefixIcon: Icon(icon, color: Colors.white),
              filled: true,
              suffixIcon: GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(
                  suffixIcon,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
