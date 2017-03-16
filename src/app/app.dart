import 'components/core/backoffice.dart';
import 'components/core/requests.dart';
import 'components/actions/fetch_pending_domains_action.dart';
import 'components/actions/fetch_users_action.dart';

Backoffice app;

main() {
    app = new Backoffice();
    app.init();
}