import 'dart:html';

import '../core/user.dart';

class UserItem {
    User user;

    UserItem(this.user);

    DivElement getTemplate() {
        DivElement container = new Element.tag('div');
        container.appendHtml("""
                                    <div class='b-user-item-container'>
                                        <b>${user.Email}</b>
                                        ${user.Id}
                                    </div>
                             """);
        container.onClick.listen((MouseEvent event) => print(user.Email));
        return container;
    }
}