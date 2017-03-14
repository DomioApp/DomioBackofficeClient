import 'dart:async';

import '../core/router.dart';
import '../core/connection.dart';

import 'dart:html';

class TopBar {
    Router router;
    Stream onViewLoaded;

    String querySelectorString;
    DivElement container;

    TopBar(this.querySelectorString);

    void init(Router routerInstance, Connection connection, Stream onViewLoadedInstance) {
        router = routerInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
    }

    void bindEvents() {
        onViewLoaded.listen((bool event) => render());
    }

    void render() {
        if (container == null) {
            container = document.querySelector(querySelectorString);
        }

        container.setInnerHtml(getTemplate());
    }

    String getTemplate() {
        return """
                    <div class="left-area">
                        <a href='#'>Dashboard</a>
                    </div>

                    <div class="right-area">
                        <a href='#'>Logout</a>
                    </div>
                """;
    }
}