import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../app/sizer.dart';
import 'errors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              heightFactor: 2,
              child: Icon(
                Icons.error_rounded,
                size: 70.sp,
                color: Colors.red,
              ),
            ),
            Text(
              'Error',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            AppSizes.normalY,
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  String get message {
    final error = this.error;
    if (error is AppErrors)
      return error.message;
    else if (error is FirebaseException)
      return error.message ?? 'No Message';
    else
      return error.toString();
  }
}
