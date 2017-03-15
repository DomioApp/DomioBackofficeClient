import 'dart:html';
import 'dart:async';
import '../core/connection.dart';
import '../core/router.dart';

class SubBar {
    Router router;
    Stream onViewLoaded;

    AnchorElement usersLink = new AnchorElement();
    AnchorElement pendingDomainsLink = new AnchorElement();

    String querySelectorString;
    DivElement container;

    SubBar(this.querySelectorString);

    void init(Router routerInstance, Connection connection, Stream onViewLoadedInstance) {
        router = routerInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
        initLinks();
    }

    void initLinks() {
        usersLink.text = 'Users';
        usersLink.href = '/users';
        usersLink.setAttribute('data-route', 'users');

        pendingDomainsLink.text = 'Pending Domains';
        pendingDomainsLink.href = '/domains/pending';
        pendingDomainsLink.setAttribute('data-route', 'pending-domains');
    }

    void render() {
        if (container == null) {
            container = document.querySelector(querySelectorString);
        }

        container.append(usersLink);
        container.append(pendingDomainsLink);
        bindUserEvents();
    }

    void bindEvents() {
        onViewLoaded.listen((bool event) => render());
    }

    void bindUserEvents() {
        usersLink.onClick.listen(showUsers);
        pendingDomainsLink.onClick.listen(showPendingDomains);
    }

    void showUsers(MouseEvent event) {
        event.preventDefault();
        event.stopPropagation();
        router.pushRoute(usersLink.getAttribute('data-route'));
    }

    void showPendingDomains(MouseEvent event) {
        event.preventDefault();
        event.stopPropagation();

        router.pushRoute(pendingDomainsLink.getAttribute('data-route'));
    }
}