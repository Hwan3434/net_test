enum InjeJsRequestType { fromAppToWeb, fromAppToWeb2 }

enum InjeJsResponseType { toAppAAA, toAppBBB }

extension FuncResponseInfo on InjeJsResponseType {
  String get funcName {
    switch (this) {
      case InjeJsResponseType.toAppAAA:
        return 'toAppAAA';
      case InjeJsResponseType.toAppBBB:
        return 'toAppBBB';
    }
  }
}

extension FuncRequestInfo on InjeJsRequestType {
  String get funcName {
    switch (this) {
      case InjeJsRequestType.fromAppToWeb:
        return 'fromAppToWeb';
      case InjeJsRequestType.fromAppToWeb2:
        return 'fromAppToWeb2';
    }
  }
}
