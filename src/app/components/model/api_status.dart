class ApiStatus {
    String version;
    String buildago;
    num buildstamp;
    String hash;
    String builddatetime;

    ApiStatus.fromMap(Map apiStatusMap) {
        version = apiStatusMap['app_version'];
        buildago = apiStatusMap['app_buildago'];
        buildstamp = apiStatusMap['app_buildstamp'];
        builddatetime = apiStatusMap['app_builddatetime'];
        hash = apiStatusMap['app_hash'];
    }

}