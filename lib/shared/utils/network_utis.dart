import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<void> showNoInternetSnackbar(BuildContext context) async {
    if (!context.mounted) return;
    
    showAppError(
      context: context,
      error: "No internet connection. Please check your network settings and try again.",
    );
  }
}

void showAppError({required BuildContext context, required String error}) {
  if (!context.mounted) return;
  
  CustomSnackbar(
    message: error,
    color: Theme.of(context).colorScheme.error,
    duration: 5, // Reduced from 20 seconds for better UX
  ).showSnackBar(context);
}