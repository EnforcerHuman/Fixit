import 'package:flutter/material.dart';

class SelectItemField extends StatefulWidget {
  final double width;
  final double height;
  final Color onselection;
  final String text;
  final IconData icon;

  const SelectItemField(
      {super.key,
      required this.width,
      required this.onselection,
      required this.text,
      required this.height,
      required this.icon});

  @override
  State<SelectItemField> createState() => _SelectItemFieldState();
}

class _SelectItemFieldState extends State<SelectItemField> {
  bool selection = false;
  bool otherselected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selection && otherselected
              ? widget.onselection.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color:
                selection && otherselected ? widget.onselection : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  widget.icon,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            Visibility(
                visible: selection,
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.blue,
                ))
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selection = !selection;
          otherselected = !otherselected;
        });
      },
    );
  }
}
