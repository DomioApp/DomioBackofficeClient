import 'dart:html';

class TopBar {
    TopBar() {

    }

    init(DivElement container) {
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