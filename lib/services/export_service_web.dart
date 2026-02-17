import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'export_service_stub.dart' as stub;

Future<bool> exportData() async {
  try {
    final jsonStr = stub.buildExportJson();
    final bytes = utf8.encode(jsonStr);
    final blob = web.Blob(
      [bytes.toJS].toJS,
      web.BlobPropertyBag(type: 'application/json'),
    );
    final url = web.URL.createObjectURL(blob);

    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = 'kalory_help_data.json';
    anchor.click();

    web.URL.revokeObjectURL(url);
    return true;
  } catch (_) {
    return false;
  }
}
