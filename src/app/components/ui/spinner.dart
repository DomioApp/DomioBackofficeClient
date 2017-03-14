import 'dart:html';

class Spinner {
    show(DivElement container) {
        container.setInnerHtml(getTemplate());
    }


    String getTemplate() {
        return """
                    <div class="spinner-container">

                        <div class="spinner loading">
                            <div class="rect1"></div>
                            <div class="rect2"></div>
                            <div class="rect3"></div>
                            <div class="rect4"></div>
                            <div class="rect5"></div>
                        </div>

                    </div>
                """;
    }
}