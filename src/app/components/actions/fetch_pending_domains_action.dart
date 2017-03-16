import 'action.dart';
import '../model/domain.dart';

class FetchPendingDomainsAction implements Action<List<Domain>> {
    final String type = 'FETCH_PENDING_DOMAINS_ACTION';
    List<Domain> payload;
}