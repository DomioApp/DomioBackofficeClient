import 'utils.dart';
import 'dart:html';

import 'add_domain_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'profile_page.dart';
import 'user_domains_page.dart';
import 'domain_edit_page.dart';
import 'add_payment_source_page.dart';
import 'payment_source_page.dart';
import 'create_subscription_page.dart';
import 'subscription_page.dart';

ButtonElement toggleMenuButton;
DivElement menu;

main() {
    var pageName = getPageName();

    var page;
    bindElements();
    bindEvents();

    switch (pageName) {
        case 'LoginPage':
            page = new LoginPage();
            break;

        case 'SignupPage':
            page = new SignupPage();
            break;

        case 'ProfilePage':
            page = new ProfilePage();
            break;

        case 'AddDomainPage':
            page = new AddDomainPage();
            break;

        case 'UserDomainsPage':
            page = new UserDomainsPage();
            break;

        case 'DomainEditPage':
            page = new DomainEditPage();
            break;

        case 'AddPaymentSourcePage':
            page = new AddPaymentSourcePage();
            break;

        case 'UserPaymentSourcePage':
            page = new PaymentSourcePage();
            break;

        case 'RentDomainPage':
            page = new CreateSubscriptionPage();
            break;

        case 'SubscriptionPage':
            page = new SubscriptionPage();
            break;

        default:
            window.console.warn('Page is not initialized');
            break;
    }
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
