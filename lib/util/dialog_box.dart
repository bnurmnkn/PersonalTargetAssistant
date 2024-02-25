import 'package:flutter/material.dart';
import 'package:mobileprojectbeyzanur/util/my_button2.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Hedef Ekle",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton2(text: "Kayıt", onPressed: onSave),
                const SizedBox(width: 8),
                MyButton2(text: "İptal", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}