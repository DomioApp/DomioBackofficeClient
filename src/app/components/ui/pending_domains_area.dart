import 'dart:html';
import 'dart:convert';
import 'dart:async';

import '../core/connection.dart';
import '../core/requests.dart';
import '../core/router.dart';
import '../model/domain.dart';

import 'spinner.dart';


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
//        connection.onPendingDomainsData.listen(updateView);
    }

    void render() {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        showSpinner();

        connection.sendRequest(Requests.FetchPendingDomains);
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
        String domainsList = loadDomainsList(data);

        return """
                   <div class="b-pending-domains-area">
                       <p>$domainsList</p>
                   </div>
               """;
    }

    String loadDomainsList(String data) {
        List<Map> decodedJson = JSON.decode(data);
        List<Domain> domains = decodedJson.map((domainMap) => new Domain.fromMap(domainMap));
        return domains.map(
                (Domain domain) => """
                                <div class='b-domain-item-container'>
                                    ${domain.Name}
                                    ${domain.Owner}
                                    ${domain.PricePerMonth}
                                    ${domain.IsApproved}
                                </div>
                               """
        ).join('');
    }
}