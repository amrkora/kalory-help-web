import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacyPolicyTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.privacyPolicyTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.lastUpdated,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: l10n.privacyDataStaysTitle,
              body: l10n.privacyDataStaysBody,
            ),
            _buildSection(
              context,
              title: l10n.privacyNoCollectionTitle,
              body: l10n.privacyNoCollectionBody,
            ),
            _buildSection(
              context,
              title: l10n.privacyNoAnalyticsTitle,
              body: l10n.privacyNoAnalyticsBody,
            ),
            _buildSection(
              context,
              title: l10n.privacyNoSharingTitle,
              body: l10n.privacyNoSharingBody,
            ),
            _buildSection(
              context,
              title: l10n.privacyDeletionTitle,
              body: l10n.privacyDeletionBody,
            ),
            _buildSection(
              context,
              title: l10n.privacyContactTitle,
              body: l10n.privacyContactBody,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
