import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/users/models/user_model.dart';
import 'package:grupus/features/users/services/user_services.dart';
import 'package:grupus/shared/utils/logs.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  try {
    return UserServices().getCurrentUser().then((response) {
      if (response == null ) {
        DevLogs.logError('Failed to retrieve current user');
        return null;
      }
      return response;
    });
    
  } catch (e) {
    DevLogs.logError('Error in currentUserProvider: $e');
    return null;
  }
});