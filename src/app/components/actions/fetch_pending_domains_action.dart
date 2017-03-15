import 'action.dart';
import '../model/domain.dart';
import '../model/payload.dart';

class FetchPendingDomainsAction extends Action {
    List<Domain> data;

    FetchPendingDomainsAction(Payload payload) {
        data = payload.data.map((item) => new Domain());
    }
}