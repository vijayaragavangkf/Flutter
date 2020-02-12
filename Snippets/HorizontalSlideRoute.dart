import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalSlideRoute<T> extends PageRoute<T> {
  VerticalSlideRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration {
    return const Duration(milliseconds: 300);
  }

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is VerticalSlideRoute ||
        previousRoute is CupertinoPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is VerticalSlideRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = builder(context);
    assert(() {
      if (result == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'The builder for route "${settings.name}" returned null.'),
          ErrorDescription('Route builders must never return null.')
        ]);
      }
      return true;
    }());
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    assert(debugCheckHasDirectionality(context));
    final TextDirection textDirection = Directionality.of(context);

    animation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    secondaryAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.linearToEaseOut,
    );

    if (canPop || animation.status == AnimationStatus.reverse)
      child = SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        textDirection: textDirection,
        child: child,
      );

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1, 0),
      ).animate(secondaryAnimation),
      textDirection: textDirection,
      transformHitTests: false,
      child: child,
    );
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
