import 'action.dart';
import '../model/api_status.dart';

class FetchApiStatusAction implements Action<ApiStatus> {
    String type = 'FETCH_API_STATUS_ACTION';
    ApiStatus payload;

    FetchApiStatusAction.fromObject(Map data) {
        payload = new ApiStatus.fromMap(data);
        print(payload);
    }

}
