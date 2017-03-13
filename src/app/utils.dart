//import 'dart:developer';

import 'dart:html';

String getPageName() {
    var tagElement = querySelector('meta[name="page"]') as MetaElement;
    return tagElement.content;
}
