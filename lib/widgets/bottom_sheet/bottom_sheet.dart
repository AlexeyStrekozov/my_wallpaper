import 'package:flutter/material.dart';

Future<dynamic> showAdaptiveBottomSheet(
  BuildContext context, {
  required Widget child,
  Color? bg,
  double size = 0.85,
  bool isDismisible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    useRootNavigator: true,
    isDismissible: isDismisible,
    enableDrag: enableDrag,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (ctx) => ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * size),
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          decoration: BoxDecoration(
            color: bg ?? Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: child,
        ),
      ),
    ),
  );
}
