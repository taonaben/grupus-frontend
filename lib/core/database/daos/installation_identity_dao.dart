part of '../app_database.dart';

@DriftAccessor(tables: [AppSettings])
class InstallationIdentityDao extends DatabaseAccessor<AppDatabase>
    with _$InstallationIdentityDaoMixin {
  InstallationIdentityDao(super.db);

  static const installationIdKey = 'installation_id';

  Future<String> getOrCreateInstallationId() async {
    final existing = await getSetting(installationIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final installationId = const Uuid().v4();
    await setSetting(installationIdKey, installationId);
    return installationId;
  }

  Future<String?> getSetting(String key) async {
    final row =
        await (select(appSettings)
              ..where((setting) => setting.key.equals(key))
              ..limit(1))
            .getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) async {
    await into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(
        key: key,
        value: value,
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
