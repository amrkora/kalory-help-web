import 'export_service_stub.dart'
    if (dart.library.js_interop) 'export_service_web.dart'
    if (dart.library.io) 'export_service_mobile.dart' as platform;

class ExportService {
  static Future<bool> exportData() => platform.exportData();
}
