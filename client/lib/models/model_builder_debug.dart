class ModelBodyModelBuilderDebug {
  String? buildVersion;
  String? debugWeb;
  String? debugApk;
  String? buildProduction;

  ModelBodyModelBuilderDebug({
    this.buildVersion,
    this.debugWeb,
    this.debugApk,
    this.buildProduction,
  });

  ModelBodyModelBuilderDebug.fromJson(Map<String, dynamic> json) {
    buildVersion = json['build_version'];
    debugWeb = json['debug_web'];
    debugApk = json['debug_apk'];
    buildProduction = json['build_production'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['build_version'] = buildVersion;
    data['debug_web'] = debugWeb;
    data['debug_apk'] = debugApk;
    data['build_production'] = buildProduction;
    return data;
  }
}
