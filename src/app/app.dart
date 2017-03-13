import 'dart:html';

import 'backoffice_app.dart';

ButtonElement toggleMenuButton;
DivElement menu;

main() {
    var app = new BackofficeApp();
    bindElements();
    bindEvents();
}

void bindElements() {
    menu = querySelector('.b-top-bar-container');
    toggleMenuButton = menu.querySelector('.toggle-menu-button');
}

void bindEvents() {
    toggleMenuButton.onClick.listen(toggleMenu);
}

void toggleMenu(MouseEvent event) {
    menu.classes.toggle('visible');
}
