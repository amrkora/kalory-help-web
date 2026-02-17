import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'export_service_stub.dart' as stub;

Future<bool> exportData() async {
  try {
    final jsonStr = stub.buildExportJson();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/kalory_help_data.json');
    await file.writeAsString(jsonStr);

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    return true;
  } catch (_) {
    return false;
  }
}
