abstract class HttpErrorObserver {
  void onError();
}

class HttpErrorSubjectController {
  static final HttpErrorSubjectController _instance =
      HttpErrorSubjectController._privateConstructor();

  HttpErrorSubjectController._privateConstructor();

  static HttpErrorSubjectController instance() => _instance;

  final List<HttpErrorObserver> httpErrorList = [];

  HttpErrorSubjectController add(HttpErrorObserver item) {
    httpErrorList.add(item);
    return this;
  }

  HttpErrorSubjectController remove(HttpErrorObserver item) {
    httpErrorList.remove(item);
    return this;
  }

  void notifyError() {
    for (var element in httpErrorList) {
      element.onError();
    }
  }
}
