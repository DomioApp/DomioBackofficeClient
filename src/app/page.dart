import 'dart:html';

abstract class Page {
    void init();

    void bindEvents();

    void updateModel(Event event);
}
