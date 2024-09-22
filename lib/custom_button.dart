import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.redAccent),
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
            onPressed: onTap,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18,),
            )),
      ),
    );
  }
}
