import 'package:flutter/material.dart';

class MoleButton extends StatelessWidget {
  const MoleButton({super.key, required this.onTap, required this.active});

  // Callback function to be executed on tap
  final VoidCallback onTap;
  // Boolean to determine if the mole is active (visible)
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          // Executes the onTap callback when the widget is tapped
          onTap: () => onTap(),
          child: Container(
            // Sets the width of the container to the maximum width allowed by the constraints
            width: constraints.maxWidth,
            // Sets the height of the container to the maximum width allowed by the constraints
            height: constraints.maxWidth,
            decoration: BoxDecoration(
              // Background color of the container
              color: Colors.brown,
              // Makes the container circular
              borderRadius:
                  BorderRadiusDirectional.circular(constraints.maxWidth),
            ),
            child: Visibility(
              // Determines if the child widget is visible based on the 'active' boolean
              visible: active,
              child: Container(
                // Sets a margin inside the container
                margin: EdgeInsets.all(constraints.maxWidth * 0.2),
                // Sets the width of the inner container to the maximum width allowed by the constraints
                width: constraints.maxWidth,
                // Sets the height of the inner container to the maximum width allowed by the constraints
                height: constraints.maxWidth,
                decoration: BoxDecoration(
                  // Makes the inner container circular
                  borderRadius:
                      BorderRadiusDirectional.circular(constraints.maxWidth),
                  // Background color of the inner container
                  color: Colors.brown.shade200,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
