/// The Linux implementation of `share_plus`.
library share_plus_linux;

import 'dart:ui';

import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';

/// The Linux implementation of SharePlatform.
class ShareLinux extends SharePlatform {
  /// Register this dart class as the platform implementation for linux
  static void registerWith() {
    SharePlatform.instance = ShareLinux();
  }

  /// Share text.
  /// Throws a [PlatformException] if `mailto:` scheme cannot be handled.
  @override
  Future<void> share(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
    VoidCallback? onAfterShare,
  }) async {
    if (onAfterShare != null) {
      throw UnimplementedError(
        'share.onAfterShare callback has not been implemented on Windows.');
    }
    
    final queryParameters = {
      if (subject != null) 'subject': subject,
      'body': text,
    };

    // see https://github.com/dart-lang/sdk/issues/43838#issuecomment-823551891
    final uri = Uri(
      scheme: 'mailto',
      query: queryParameters.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&'),
    );

    await launch(uri.toString());
  }

  /// Share files.
  @override
  Future<void> shareFiles(
    List<String> paths, {
    List<String>? mimeTypes,
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
    VoidCallback? onAfterShare,
  }) {
    throw UnimplementedError('shareFiles() has not been implemented on Linux.');
  }
}
