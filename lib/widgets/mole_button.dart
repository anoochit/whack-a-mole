import 'package:flutter/material.dart';

class MoleButton extends StatelessWidget {
  const MoleButton({super.key, required this.onTap, required this.active});

  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius:
                  BorderRadiusDirectional.circular((constraints.maxWidth)),
            ),
            child: Visibility(
              visible: active,
              child: Container(
                margin: EdgeInsets.all(constraints.maxWidth * 0.2),
                width: constraints.maxWidth,
                height: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(
                    (constraints.maxWidth),
                  ),
                  color: Colors.brown.shade100,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
