import 'package:flutter/material.dart';
import 'package:tech_task/src/models/ingredent.dart';

class IngredientCard extends StatefulWidget {
  const IngredientCard(
      {super.key, required this.ingredent, required this.onTap});
  final Ingredent ingredent;
  final VoidCallback? onTap;

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final data = widget.ingredent;
    return InkWell(
      onTap: widget.onTap == null
          ? null
          : () {
              setState(() {
                widget.onTap!();
                isSelected = !isSelected;
              });
            },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.black, width: 2)
              : Border.all(
                  color: Colors.grey,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: widget.onTap == null ? Colors.grey : Colors.black,
              ),
            ),
            Text(
              "${data.date.day}-${data.date.month}-${data.date.year}",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
