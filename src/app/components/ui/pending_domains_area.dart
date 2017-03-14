import 'dart:html';
import 'dart:convert';
import 'dart:async';

import '../core/connection.dart';
import '../core/router.dart';
import 'spinner.dart';

class Domain {
    String Name;
    String Owner;
    num PricePerMonth;
    bool IsApproved;
    bool IsRented;
    bool IsVisible;

    Domain(Map domainMap) {
        Name = domainMap['name'];
        Owner = domainMap['owner'];
        PricePerMonth = domainMap['price_per_month'];
        IsApproved = domainMap['is_approved'];
        IsRented = domainMap['is_rented'];
        IsVisible = domainMap['is_visible'];
    }
}


class PendingDomainsArea {
    Connection connection;
    DivElement container;
    String containerQuerySelector;
    Stream onViewLoaded;

    void init(Router router, Connection connectionInstance, Stream onViewLoadedInstance) {
        connection = connectionInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
    }

    void bindEvents() {
        connection.onPendingDomainsData.listen(updateView);
    }

    void render() {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        showSpinner();

        connection.getRequest('/domains/pending', null, connection.pendingDomainsDataStreamController);
    }

    void showSpinner() {
        Spinner spinner = new Spinner();
        spinner.show(container);
    }

    void updateView(String data) {
        document.body
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 300);

        new Timer(TIMEOUT, () => container.setInnerHtml(getTemplate(data)));
    }

    String getTemplate(String data) {
        String usersList = loadUsersList(data);

        return """
                   <div class="b-pending-domains-area">
                       <p>$usersList</p>
                   </div>
               """;
    }

    String loadUsersList(String data) {
        List<Map> decodedJson = JSON.decode(data);
        List<Domain> users = decodedJson.map((userMap) => new Domain(userMap));
        return users.map(
                (Domain user) => """
                                <div class='b-user-item-container'>
                                    ${user.Name}
                                    ${user.Owner}
                                    ${user.PricePerMonth}
                                    ${user.IsApproved}
                                </div>
                               """
        ).join('');
    }
}