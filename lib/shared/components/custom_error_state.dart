
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'dart:io';

import 'package:grupus/shared/utils/network_utis.dart';

class CustomErrorState extends StatefulWidget {
  final VoidCallback onTap;
  const CustomErrorState({super.key, required this.onTap});

  @override
  State<CustomErrorState> createState() => _CustomErrorStateState();
}

class _CustomErrorStateState extends State<CustomErrorState> {
  bool _isCheckingConnection = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  final _hasInternetConnection = NetworkUtils.hasInternetConnection;

  Future<void> _checkInternetConnection() async {
    if (!mounted) return;

    setState(() {
      _isCheckingConnection = true;
    });

    final hasInternet = await _hasInternetConnection();

    if (!mounted) return;

    setState(() {
      _isCheckingConnection = false;
    });

    if (!hasInternet) {
      _showNoInternetError();
    }
  }

  void _showNoInternetError() {
    showAppError(
      context: context,
      error:
          "No internet connection. Please check your network settings and try again.",
    );
  }

  Future<void> _handleRetry() async {
    // Check internet before calling the original onTap
    final hasInternet = await _hasInternetConnection();

    if (!hasInternet) {
      _showNoInternetError();
      return;
    }

    // If internet is available, proceed with the original action
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset(
              'lib/assets/images/distress.PNG',
              fit: BoxFit.cover,
              // color: Theme.of(context).colorScheme.onPrimary,
              height: MediaQuery.of(context).size.height * .2,
            ),
          ),
          const Gap(16),
          Text(
            "Uh Oh!!",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          Text(
            "It's not you, it's us",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          // if (_isCheckingConnection) ...[
          //   const Gap(16),
          //   CircularProgressIndicator(
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   const Gap(8),
          //   Text(
          //     "Checking connection...",
          //     style: TextStyle(
          //       color: Theme.of(context).colorScheme.onPrimary,
          //       fontSize: 12,
          //     ),
          //   ),
          // ],
          const Gap(16),
          CustomFilledButton(
            btnLabel: "Reload page",
            onTap: _isCheckingConnection ? () {} : _handleRetry,
            expand: true,
          ),
        ],
      ),
    );
  }
}
