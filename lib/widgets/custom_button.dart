// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String label;
//   final bool loading;
//   final VoidCallback? onPressed;

//   const CustomButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.loading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: loading ? null : onPressed,
//         child: loading
//             ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//             : Text(label, style: Theme.of(context).textTheme.labelMedium),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          backgroundColor: Colors.transparent, // Needed for gradient
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        onPressed: loading ? null : onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6D5DF6), // Purple
                Color(0xFF4FC3F7), // Sky Blue
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
