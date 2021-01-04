import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';

class MyDrawer extends StatelessWidget {
  /// Creates a material design drawer.
  ///
  /// Typically used in the [Scaffold.drawer] property.
  ///
  /// The [elevation] must be non-negative.
  const MyDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.widthPercent = 0.85,
    this.borderRadius = 0,
    this.isEnd = true,
    this.semanticLabel,
  })  : assert(elevation != null && elevation >= 0.0),
        assert(
            widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  final double widthPercent;
  final bool isEnd;
  final double borderRadius;

  /// The z-coordinate at which to place this drawer relative to its parent.
  ///
  /// This controls the size of the shadow below the drawer.
  ///
  /// Defaults to 16, the appropriate elevation for drawers. The value is
  /// always non-negative.
  final double elevation;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [SliverList].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
        break;
      default: 
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }
    final double _width = MediaQuery.of(context).size.width * widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width,height: maxHeight),
        child: Material(
          borderRadius: isEnd
            ? BorderRadius.only(
                topLeft: Radius.circular(setWidth(borderRadius)),
                bottomLeft: Radius.circular(setWidth(borderRadius))
              )
            : BorderRadius.only(
                topRight: Radius.circular(setWidth(borderRadius)),
                bottomRight: Radius.circular(setWidth(borderRadius))
              ),
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}
