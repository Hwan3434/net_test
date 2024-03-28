enum InjeJsRequestChannel { fromAppToWeb, fromAppToWeb2 }

enum InjeJsResponseChannel { toAppAAA, toAppBBB }

const String lazyChannel = 'lazy';

extension FuncResponseInfo on InjeJsResponseChannel {
  String get channelName {
    switch (this) {
      case InjeJsResponseChannel.toAppAAA:
        return 'toAppAAA';
      case InjeJsResponseChannel.toAppBBB:
        return 'toAppBBB';
    }
  }
}

extension FuncRequestInfo on InjeJsRequestChannel {
  String get channelName {
    switch (this) {
      case InjeJsRequestChannel.fromAppToWeb:
        return 'fromAppToWeb';
      case InjeJsRequestChannel.fromAppToWeb2:
        return 'fromAppToWeb2';
    }
  }
}
