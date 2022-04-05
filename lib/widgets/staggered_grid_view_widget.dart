// import 'package:flutter/material.dart';

// typedef IndexedStaggeredTileBuilder = StaggeredTile? Function(int index);

// class StaggeredGridView extends BoxScrollView {
//   StaggeredGridView({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required this.gridDelegate,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     List<Widget> children = const <Widget>[],
//     String? restorationId,
//   })  : childrenDelegate = SliverChildListDelegate(
//           children,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   StaggeredGridView.builder({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required this.gridDelegate,
//     required IndexedWidgetBuilder itemBuilder,
//     int? itemCount,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     String? restorationId,
//   })  : childrenDelegate = SliverChildBuilderDelegate(
//           itemBuilder,
//           childCount: itemCount,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   const StaggeredGridView.custom({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     String? restorationId,
//     required this.gridDelegate,
//     required this.childrenDelegate,
//     this.addAutomaticKeepAlives = true,
//   }) : super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   StaggeredGridView.count({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required int crossAxisCount,
//     double mainAxisSpacing = 0.0,
//     double crossAxisSpacing = 0.0,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     List<Widget> children = const <Widget>[],
//     List<StaggeredTile> staggeredTiles = const <StaggeredTile>[],
//     String? restorationId,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: (i) => staggeredTiles[i],
//           staggeredTileCount: staggeredTiles.length,
//         ),
//         childrenDelegate = SliverChildListDelegate(
//           children,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   StaggeredGridView.countBuilder({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required int crossAxisCount,
//     required IndexedWidgetBuilder itemBuilder,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     int? itemCount,
//     double mainAxisSpacing = 0.0,
//     double crossAxisSpacing = 0.0,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     String? restorationId,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: staggeredTileBuilder,
//           staggeredTileCount: itemCount,
//         ),
//         childrenDelegate = SliverChildBuilderDelegate(
//           itemBuilder,
//           childCount: itemCount,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   StaggeredGridView.extent({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required double maxCrossAxisExtent,
//     double mainAxisSpacing = 0.0,
//     double crossAxisSpacing = 0.0,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     List<Widget> children = const <Widget>[],
//     List<StaggeredTile> staggeredTiles = const <StaggeredTile>[],
//     String? restorationId,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: maxCrossAxisExtent,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: (i) => staggeredTiles[i],
//           staggeredTileCount: staggeredTiles.length,
//         ),
//         childrenDelegate = SliverChildListDelegate(
//           children,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   StaggeredGridView.extentBuilder({
//     Key? key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required double maxCrossAxisExtent,
//     required IndexedWidgetBuilder itemBuilder,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     int? itemCount,
//     double mainAxisSpacing = 0.0,
//     double crossAxisSpacing = 0.0,
//     this.addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     String? restorationId,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: maxCrossAxisExtent,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: staggeredTileBuilder,
//           staggeredTileCount: itemCount,
//         ),
//         childrenDelegate = SliverChildBuilderDelegate(
//           itemBuilder,
//           childCount: itemCount,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//         ),
//         super(
//           key: key,
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           restorationId: restorationId,
//         );

//   final SliverStaggeredGridDelegate gridDelegate;

//   final SliverChildDelegate childrenDelegate;

//   final bool addAutomaticKeepAlives;

//   @override
//   Widget buildChildLayout(BuildContext context) {
//     return SliverStaggeredGrid(
//       delegate: childrenDelegate,
//       gridDelegate: gridDelegate,
//       addAutomaticKeepAlives: addAutomaticKeepAlives,
//     );
//   }
// }

// class SliverStaggeredGrid extends SliverVariableSizeBoxAdaptorWidget {
//   /// Creates a sliver that places multiple box children in a two dimensional
//   /// arrangement.
//   const SliverStaggeredGrid({
//     Key? key,
//     required SliverChildDelegate delegate,
//     required this.gridDelegate,
//     bool addAutomaticKeepAlives = true,
//   }) : super(
//           key: key,
//           delegate: delegate,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//         );

//   /// Creates a sliver that places multiple box children in a two dimensional
//   /// arrangement with a fixed number of tiles in the cross axis.
//   ///
//   /// Uses a [SliverStaggeredGridDelegateWithFixedCrossAxisCount] as the [gridDelegate],
//   /// and a [SliverVariableSizeChildListDelegate] as the [delegate].
//   ///
//   /// The `addAutomaticKeepAlives` argument corresponds to the
//   //  [SliverVariableSizeChildListDelegate.addAutomaticKeepAlives] property. The
//   ///
//   /// See also:
//   ///
//   ///  * [StaggeredGridView.count], the equivalent constructor for [StaggeredGridView] widgets.
//   SliverStaggeredGrid.count({
//     Key? key,
//     required int crossAxisCount,
//     double mainAxisSpacing = 0.0,
//     double crossAxisSpacing = 0.0,
//     List<Widget> children = const <Widget>[],
//     List<StaggeredTile> staggeredTiles = const <StaggeredTile>[],
//     bool addAutomaticKeepAlives = true,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: (i) => staggeredTiles[i],
//           staggeredTileCount: staggeredTiles.length,
//         ),
//         super(
//           key: key,
//           delegate: SliverChildListDelegate(
//             children,
//             addAutomaticKeepAlives: addAutomaticKeepAlives,
//           ),
//         );

//   /// Creates a sliver that builds multiple box children in a two dimensional
//   /// arrangement with a fixed number of tiles in the cross axis.
//   ///
//   /// This constructor is appropriate for grid views with a large (or infinite)
//   /// number of children because the builder is called only for those children
//   /// that are actually visible.
//   ///
//   /// Uses a [SliverStaggeredGridDelegateWithFixedCrossAxisCount] as the
//   /// [gridDelegate], and a [SliverVariableSizeChildBuilderDelegate] as the [delegate].
//   ///
//   /// See also:
//   ///
//   ///  * [StaggeredGridView.countBuilder], the equivalent constructor for
//   ///  [StaggeredGridView] widgets.
//   SliverStaggeredGrid.countBuilder({
//     Key? key,
//     required int crossAxisCount,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     required IndexedWidgetBuilder itemBuilder,
//     required int itemCount,
//     double mainAxisSpacing = 0,
//     double crossAxisSpacing = 0,
//     bool addAutomaticKeepAlives = true,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: staggeredTileBuilder,
//           staggeredTileCount: itemCount,
//         ),
//         super(
//           key: key,
//           delegate: SliverChildBuilderDelegate(
//             itemBuilder,
//             childCount: itemCount,
//             addAutomaticKeepAlives: addAutomaticKeepAlives,
//           ),
//         );

//   /// Creates a sliver that places multiple box children in a two dimensional
//   /// arrangement with tiles that each have a maximum cross-axis extent.
//   ///
//   /// Uses a [SliverStaggeredGridDelegateWithMaxCrossAxisExtent] as the [gridDelegate],
//   /// and a [SliverVariableSizeChildListDelegate] as the [delegate].
//   ///
//   /// See also:
//   ///
//   ///  * [StaggeredGridView.extent], the equivalent constructor for [StaggeredGridView] widgets.
//   SliverStaggeredGrid.extent({
//     Key? key,
//     required double maxCrossAxisExtent,
//     double mainAxisSpacing = 0,
//     double crossAxisSpacing = 0,
//     List<Widget> children = const <Widget>[],
//     List<StaggeredTile> staggeredTiles = const <StaggeredTile>[],
//     bool addAutomaticKeepAlives = true,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: maxCrossAxisExtent,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: (i) => staggeredTiles[i],
//           staggeredTileCount: staggeredTiles.length,
//         ),
//         super(
//           key: key,
//           delegate: SliverChildListDelegate(
//             children,
//             addAutomaticKeepAlives: addAutomaticKeepAlives,
//           ),
//         );

//   /// Creates a sliver that builds multiple box children in a two dimensional
//   /// arrangement with tiles that each have a maximum cross-axis extent.
//   ///
//   /// This constructor is appropriate for grid views with a large (or infinite)
//   /// number of children because the builder is called only for those children
//   /// that are actually visible.
//   ///
//   /// Uses a [SliverStaggeredGridDelegateWithMaxCrossAxisExtent] as the
//   /// [gridDelegate], and a [SliverVariableSizeChildBuilderDelegate] as the [delegate].
//   ///
//   /// See also:
//   ///
//   ///  * [StaggeredGridView.extentBuilder], the equivalent constructor for
//   ///  [StaggeredGridView] widgets.
//   SliverStaggeredGrid.extentBuilder({
//     Key? key,
//     required double maxCrossAxisExtent,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     required IndexedWidgetBuilder itemBuilder,
//     required int itemCount,
//     double mainAxisSpacing = 0,
//     double crossAxisSpacing = 0,
//     bool addAutomaticKeepAlives = true,
//   })  : gridDelegate = SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: maxCrossAxisExtent,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileBuilder: staggeredTileBuilder,
//           staggeredTileCount: itemCount,
//         ),
//         super(
//           key: key,
//           delegate: SliverChildBuilderDelegate(
//             itemBuilder,
//             childCount: itemCount,
//             addAutomaticKeepAlives: addAutomaticKeepAlives,
//           ),
//         );

//   /// The delegate that controls the size and position of the children.
//   final SliverStaggeredGridDelegate gridDelegate;

//   @override
//   RenderSliverStaggeredGrid createRenderObject(BuildContext context) {
//     final element = context as SliverVariableSizeBoxAdaptorElement;
//     return RenderSliverStaggeredGrid(
//         childManager: element, gridDelegate: gridDelegate);
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, RenderSliverStaggeredGrid renderObject) {
//     renderObject.gridDelegate = gridDelegate;
//   }
// }

// class SliverVariableSizeBoxAdaptorElement extends RenderObjectElement
//     implements RenderSliverVariableSizeBoxChildManager {
//   /// Creates an element that lazily builds children for the given widget.
//   SliverVariableSizeBoxAdaptorElement(SliverVariableSizeBoxAdaptorWidget widget,
//       {this.addAutomaticKeepAlives = true})
//       : super(widget);

//   /// Whether to add keepAlives to children
//   final bool addAutomaticKeepAlives;

//   @override
//   SliverVariableSizeBoxAdaptorWidget get widget =>
//       super.widget as SliverVariableSizeBoxAdaptorWidget;

//   @override
//   RenderSliverVariableSizeBoxAdaptor get renderObject =>
//       super.renderObject as RenderSliverVariableSizeBoxAdaptor;

//   @override
//   void update(covariant SliverVariableSizeBoxAdaptorWidget newWidget) {
//     final SliverVariableSizeBoxAdaptorWidget oldWidget = widget;
//     super.update(newWidget);
//     final SliverChildDelegate newDelegate = newWidget.delegate;
//     final SliverChildDelegate oldDelegate = oldWidget.delegate;
//     if (newDelegate != oldDelegate &&
//         (newDelegate.runtimeType != oldDelegate.runtimeType ||
//             newDelegate.shouldRebuild(oldDelegate))) {
//       performRebuild();
//     }
//   }

//   // We inflate widgets at two different times:
//   //  1. When we ourselves are told to rebuild (see performRebuild).
//   //  2. When our render object needs a child (see createChild).
//   // In both cases, we cache the results of calling into our delegate to get the widget,
//   // so that if we do case 2 later, we don't call the builder again.
//   // Any time we do case 1, though, we reset the cache.

//   final Map<int, Widget?> _childWidgets = HashMap<int, Widget?>();
//   final SplayTreeMap<int, Element> _childElements =
//       SplayTreeMap<int, Element>();

//   @override
//   void performRebuild() {
//     _childWidgets.clear(); // Reset the cache, as described above.
//     super.performRebuild();
//     assert(_currentlyUpdatingChildIndex == null);
//     try {
//       late final int firstIndex;
//       late final int lastIndex;
//       if (_childElements.isEmpty) {
//         firstIndex = 0;
//         lastIndex = 0;
//       } else if (_didUnderflow) {
//         firstIndex = _childElements.firstKey()!;
//         lastIndex = _childElements.lastKey()! + 1;
//       } else {
//         firstIndex = _childElements.firstKey()!;
//         lastIndex = _childElements.lastKey()!;
//       }

//       for (int index = firstIndex; index <= lastIndex; ++index) {
//         _currentlyUpdatingChildIndex = index;
//         final Element? newChild =
//             updateChild(_childElements[index], _build(index), index);
//         if (newChild != null) {
//           _childElements[index] = newChild;
//         } else {
//           _childElements.remove(index);
//         }
//       }
//     } finally {
//       _currentlyUpdatingChildIndex = null;
//     }
//   }

//   Widget? _build(int index) {
//     return _childWidgets.putIfAbsent(
//         index, () => widget.delegate.build(this, index));
//   }

//   @override
//   void createChild(int index) {
//     assert(_currentlyUpdatingChildIndex == null);
//     owner!.buildScope(this, () {
//       Element? newChild;
//       try {
//         _currentlyUpdatingChildIndex = index;
//         newChild = updateChild(_childElements[index], _build(index), index);
//       } finally {
//         _currentlyUpdatingChildIndex = null;
//       }
//       if (newChild != null) {
//         _childElements[index] = newChild;
//       } else {
//         _childElements.remove(index);
//       }
//     });
//   }

//   @override
//   Element? updateChild(Element? child, Widget? newWidget, dynamic newSlot) {
//     final oldParentData = child?.renderObject?.parentData
//         as SliverVariableSizeBoxAdaptorParentData?;
//     final Element? newChild = super.updateChild(child, newWidget, newSlot);
//     final newParentData = newChild?.renderObject?.parentData
//         as SliverVariableSizeBoxAdaptorParentData?;

//     // set keepAlive to true in order to populate the cache
//     if (addAutomaticKeepAlives && newParentData != null) {
//       newParentData.keepAlive = true;
//     }

//     // Preserve the old layoutOffset if the renderObject was swapped out.
//     if (oldParentData != newParentData &&
//         oldParentData != null &&
//         newParentData != null) {
//       newParentData.layoutOffset = oldParentData.layoutOffset;
//     }

//     return newChild;
//   }

//   @override
//   void forgetChild(Element child) {
//     assert(child.slot != null);
//     assert(_childElements.containsKey(child.slot));
//     _childElements.remove(child.slot);
//     super.forgetChild(child);
//   }

//   @override
//   void removeChild(RenderBox child) {
//     final int index = renderObject.indexOf(child);
//     assert(_currentlyUpdatingChildIndex == null);
//     assert(index >= 0);
//     owner!.buildScope(this, () {
//       assert(_childElements.containsKey(index));
//       try {
//         _currentlyUpdatingChildIndex = index;
//         final Element? result = updateChild(_childElements[index], null, index);
//         assert(result == null);
//       } finally {
//         _currentlyUpdatingChildIndex = null;
//       }
//       _childElements.remove(index);
//       assert(!_childElements.containsKey(index));
//     });
//   }

//   double? _extrapolateMaxScrollOffset(
//     int? firstIndex,
//     int? lastIndex,
//     double? leadingScrollOffset,
//     double? trailingScrollOffset,
//   ) {
//     final int? childCount = widget.delegate.estimatedChildCount;
//     if (childCount == null) {
//       return double.infinity;
//     }
//     if (lastIndex == childCount - 1) {
//       return trailingScrollOffset;
//     }
//     final int reifiedCount = lastIndex! - firstIndex! + 1;
//     final double averageExtent =
//         (trailingScrollOffset! - leadingScrollOffset!) / reifiedCount;
//     final int remainingCount = childCount - lastIndex - 1;
//     return trailingScrollOffset + averageExtent * remainingCount;
//   }

//   @override
//   double estimateMaxScrollOffset(
//     SliverConstraints constraints, {
//     int? firstIndex,
//     int? lastIndex,
//     double? leadingScrollOffset,
//     double? trailingScrollOffset,
//   }) {
//     return widget.estimateMaxScrollOffset(
//           constraints,
//           firstIndex!,
//           lastIndex!,
//           leadingScrollOffset!,
//           trailingScrollOffset!,
//         ) ??
//         _extrapolateMaxScrollOffset(
//           firstIndex,
//           lastIndex,
//           leadingScrollOffset,
//           trailingScrollOffset,
//         )!;
//   }

//   @override
//   int get childCount => widget.delegate.estimatedChildCount ?? 0;

//   @override
//   void didStartLayout() {
//     assert(debugAssertChildListLocked());
//   }

//   @override
//   void didFinishLayout() {
//     assert(debugAssertChildListLocked());
//     final int firstIndex = _childElements.firstKey() ?? 0;
//     final int lastIndex = _childElements.lastKey() ?? 0;
//     widget.delegate.didFinishLayout(firstIndex, lastIndex);
//   }

//   int? _currentlyUpdatingChildIndex;

//   @override
//   bool debugAssertChildListLocked() {
//     assert(_currentlyUpdatingChildIndex == null);
//     return true;
//   }

//   @override
//   void didAdoptChild(RenderBox child) {
//     assert(_currentlyUpdatingChildIndex != null);
//     final childParentData =
//         child.parentData! as SliverVariableSizeBoxAdaptorParentData;
//     childParentData.index = _currentlyUpdatingChildIndex;
//   }

//   bool _didUnderflow = false;

//   @override
//   void setDidUnderflow(bool value) {
//     _didUnderflow = value;
//   }

//   @override
//   void insertRenderObjectChild(covariant RenderBox child, int slot) {
//     assert(_currentlyUpdatingChildIndex == slot);
//     assert(renderObject.debugValidateChild(child));
//     renderObject[_currentlyUpdatingChildIndex!] = child;
//     assert(() {
//       final childParentData =
//           child.parentData! as SliverVariableSizeBoxAdaptorParentData;
//       assert(slot == childParentData.index);
//       return true;
//     }());
//   }

//   @override
//   void moveRenderObjectChild(
//     covariant RenderObject child,
//     covariant Object? oldSlot,
//     covariant Object? newSlot,
//   ) {
//     assert(false);
//   }

//   @override
//   void removeRenderObjectChild(
//     covariant RenderObject child,
//     covariant Object? slot,
//   ) {
//     assert(_currentlyUpdatingChildIndex != null);
//     renderObject.remove(_currentlyUpdatingChildIndex!);
//   }

//   @override
//   void visitChildren(ElementVisitor visitor) {
//     // The toList() is to make a copy so that the underlying list can be modified by
//     // the visitor:
//     _childElements.values.toList().forEach(visitor);
//   }

//   @override
//   void debugVisitOnstageChildren(ElementVisitor visitor) {
//     _childElements.values.where((Element child) {
//       final parentData =
//           child.renderObject!.parentData as SliverMultiBoxAdaptorParentData?;
//       late double itemExtent;
//       switch (renderObject.constraints.axis) {
//         case Axis.horizontal:
//           itemExtent = child.renderObject!.paintBounds.width;
//           break;
//         case Axis.vertical:
//           itemExtent = child.renderObject!.paintBounds.height;
//           break;
//       }

//       return parentData!.layoutOffset! <
//               renderObject.constraints.scrollOffset +
//                   renderObject.constraints.remainingPaintExtent &&
//           parentData.layoutOffset! + itemExtent >
//               renderObject.constraints.scrollOffset;
//     }).forEach(visitor);
//   }
// }

// class RenderSliverStaggeredGrid extends RenderSliverVariableSizeBoxAdaptor {
//   /// Creates a sliver that contains multiple box children that whose size and
//   /// position are determined by a delegate.
//   ///
//   /// The [configuration] and [childManager] arguments must not be null.
//   RenderSliverStaggeredGrid({
//     required RenderSliverVariableSizeBoxChildManager childManager,
//     required SliverStaggeredGridDelegate gridDelegate,
//   })  : _gridDelegate = gridDelegate,
//         _pageSizeToViewportOffsets =
//             HashMap<double, SplayTreeMap<int, _ViewportOffsets?>>(),
//         super(childManager: childManager);

//   @override
//   void setupParentData(RenderObject child) {
//     if (child.parentData is! SliverVariableSizeBoxAdaptorParentData) {
//       final data = SliverVariableSizeBoxAdaptorParentData();

//       // By default we will keep it true.
//       //data.keepAlive = true;
//       child.parentData = data;
//     }
//   }

//   /// The delegate that controls the configuration of the staggered grid.
//   SliverStaggeredGridDelegate get gridDelegate => _gridDelegate;
//   SliverStaggeredGridDelegate _gridDelegate;
//   set gridDelegate(SliverStaggeredGridDelegate value) {
//     if (_gridDelegate == value) {
//       return;
//     }
//     if (value.runtimeType != _gridDelegate.runtimeType ||
//         value.shouldRelayout(_gridDelegate)) {
//       markNeedsLayout();
//     }
//     _gridDelegate = value;
//   }

//   final HashMap<double, SplayTreeMap<int, _ViewportOffsets?>>
//       _pageSizeToViewportOffsets;

//   @override
//   void performLayout() {
//     childManager.didStartLayout();
//     childManager.setDidUnderflow(false);

//     final double scrollOffset =
//         constraints.scrollOffset + constraints.cacheOrigin;
//     assert(scrollOffset >= 0.0);
//     final double remainingExtent = constraints.remainingCacheExtent;
//     assert(remainingExtent >= 0.0);
//     final double targetEndScrollOffset = scrollOffset + remainingExtent;

//     bool reachedEnd = false;
//     double trailingScrollOffset = 0;
//     double leadingScrollOffset = double.infinity;
//     bool visible = false;
//     int firstIndex = 0;
//     int lastIndex = 0;

//     final configuration = _gridDelegate.getConfiguration(constraints);

//     final pageSize = configuration.mainAxisOffsetsCacheSize *
//         constraints.viewportMainAxisExtent;
//     if (pageSize == 0.0) {
//       geometry = SliverGeometry.zero;
//       childManager.didFinishLayout();
//       return;
//     }
//     final pageIndex = scrollOffset ~/ pageSize;
//     assert(pageIndex >= 0);

//     // If the viewport is resized, we keep the in memory the old offsets caches. (Useful if only the orientation changes multiple times).
//     final viewportOffsets = _pageSizeToViewportOffsets.putIfAbsent(
//         pageSize, () => SplayTreeMap<int, _ViewportOffsets?>());

//     _ViewportOffsets? viewportOffset;
//     if (viewportOffsets.isEmpty) {
//       viewportOffset =
//           _ViewportOffsets(configuration.generateMainAxisOffsets(), pageSize);
//       viewportOffsets[0] = viewportOffset;
//     } else {
//       final smallestKey = viewportOffsets.lastKeyBefore(pageIndex + 1);
//       viewportOffset = viewportOffsets[smallestKey!];
//     }

//     // A staggered grid always have to layout the child from the zero-index based one to the last visible.
//     final mainAxisOffsets = viewportOffset!.mainAxisOffsets.toList();
//     final visibleIndices = HashSet<int>();

//     // Iterate through all children while they can be visible.
//     for (var index = viewportOffset.firstChildIndex;
//         mainAxisOffsets.any((o) => o <= targetEndScrollOffset);
//         index++) {
//       SliverStaggeredGridGeometry? geometry =
//           getSliverStaggeredGeometry(index, configuration, mainAxisOffsets);
//       if (geometry == null) {
//         // There are either no children, or we are past the end of all our children.
//         reachedEnd = true;
//         break;
//       }

//       final bool hasTrailingScrollOffset = geometry.hasTrailingScrollOffset;
//       RenderBox? child;
//       if (!hasTrailingScrollOffset) {
//         // Layout the child to compute its tailingScrollOffset.
//         final constraints =
//             BoxConstraints.tightFor(width: geometry.crossAxisExtent);
//         child = addAndLayoutChild(index, constraints, parentUsesSize: true);
//         geometry = geometry.copyWith(mainAxisExtent: paintExtentOf(child!));
//       }

//       if (!visible &&
//           targetEndScrollOffset >= geometry.scrollOffset &&
//           scrollOffset <= geometry.trailingScrollOffset) {
//         visible = true;
//         leadingScrollOffset = geometry.scrollOffset;
//         firstIndex = index;
//       }

//       if (visible && hasTrailingScrollOffset) {
//         child =
//             addAndLayoutChild(index, geometry.getBoxConstraints(constraints));
//       }

//       if (child != null) {
//         final childParentData =
//             child.parentData! as SliverVariableSizeBoxAdaptorParentData;
//         childParentData.layoutOffset = geometry.scrollOffset;
//         childParentData.crossAxisOffset = geometry.crossAxisOffset;
//         assert(childParentData.index == index);
//       }

//       if (visible && indices.contains(index)) {
//         visibleIndices.add(index);
//       }

//       if (geometry.trailingScrollOffset >=
//           viewportOffset!.trailingScrollOffset) {
//         final nextPageIndex = viewportOffset.pageIndex + 1;
//         final nextViewportOffset = _ViewportOffsets(mainAxisOffsets,
//             (nextPageIndex + 1) * pageSize, nextPageIndex, index);
//         viewportOffsets[nextPageIndex] = nextViewportOffset;
//         viewportOffset = nextViewportOffset;
//       }

//       final double endOffset =
//           geometry.trailingScrollOffset + configuration.mainAxisSpacing;
//       for (var i = 0; i < geometry.crossAxisCellCount; i++) {
//         mainAxisOffsets[i + geometry.blockIndex] = endOffset;
//       }

//       trailingScrollOffset = mainAxisOffsets.reduce(math.max);
//       lastIndex = index;
//     }

//     collectGarbage(visibleIndices);

//     if (!visible) {
//       if (scrollOffset > viewportOffset!.trailingScrollOffset) {
//         // We are outside the bounds, we have to correct the scroll.
//         final viewportOffsetScrollOffset = pageSize * viewportOffset.pageIndex;
//         final correction = viewportOffsetScrollOffset - scrollOffset;
//         geometry = SliverGeometry(
//           scrollOffsetCorrection: correction,
//         );
//       } else {
//         geometry = SliverGeometry.zero;
//         childManager.didFinishLayout();
//       }
//       return;
//     }

//     double estimatedMaxScrollOffset;
//     if (reachedEnd) {
//       estimatedMaxScrollOffset = trailingScrollOffset;
//     } else {
//       estimatedMaxScrollOffset = childManager.estimateMaxScrollOffset(
//         constraints,
//         firstIndex: firstIndex,
//         lastIndex: lastIndex,
//         leadingScrollOffset: leadingScrollOffset,
//         trailingScrollOffset: trailingScrollOffset,
//       );
//       assert(estimatedMaxScrollOffset >=
//           trailingScrollOffset - leadingScrollOffset);
//     }

//     final double paintExtent = calculatePaintOffset(
//       constraints,
//       from: leadingScrollOffset,
//       to: trailingScrollOffset,
//     );
//     final double cacheExtent = calculateCacheOffset(
//       constraints,
//       from: leadingScrollOffset,
//       to: trailingScrollOffset,
//     );

//     geometry = SliverGeometry(
//       scrollExtent: estimatedMaxScrollOffset,
//       paintExtent: paintExtent,
//       cacheExtent: cacheExtent,
//       maxPaintExtent: estimatedMaxScrollOffset,
//       // Conservative to avoid flickering away the clip during scroll.
//       hasVisualOverflow: trailingScrollOffset > targetEndScrollOffset ||
//           constraints.scrollOffset > 0.0,
//     );

//     // We may have started the layout while scrolled to the end, which would not
//     // expose a child.
//     if (estimatedMaxScrollOffset == trailingScrollOffset) {
//       childManager.setDidUnderflow(true);
//     }
//     childManager.didFinishLayout();
//   }

//   static SliverStaggeredGridGeometry? getSliverStaggeredGeometry(int index,
//       StaggeredGridConfiguration configuration, List<double> offsets) {
//     final tile = configuration.getStaggeredTile(index);
//     if (tile == null) {
//       return null;
//     }

//     final block = _findFirstAvailableBlockWithCrossAxisCount(
//         tile.crossAxisCellCount, offsets);

//     final scrollOffset = block.minOffset;
//     var blockIndex = block.index;
//     if (configuration.reverseCrossAxis) {
//       blockIndex =
//           configuration.crossAxisCount - tile.crossAxisCellCount - blockIndex;
//     }
//     final crossAxisOffset = blockIndex * configuration.cellStride;
//     final geometry = SliverStaggeredGridGeometry(
//       scrollOffset: scrollOffset,
//       crossAxisOffset: crossAxisOffset,
//       mainAxisExtent: tile.mainAxisExtent,
//       crossAxisExtent: configuration.cellStride * tile.crossAxisCellCount -
//           configuration.crossAxisSpacing,
//       crossAxisCellCount: tile.crossAxisCellCount,
//       blockIndex: block.index,
//     );
//     return geometry;
//   }

//   /// Finds the first available block with at least the specified [crossAxisCount] in the [offsets] list.
//   static _Block _findFirstAvailableBlockWithCrossAxisCount(
//       int crossAxisCount, List<double> offsets) {
//     return _findFirstAvailableBlockWithCrossAxisCountAndOffsets(
//         crossAxisCount, List.from(offsets));
//   }

//   /// Finds the first available block with at least the specified [crossAxisCount].
//   static _Block _findFirstAvailableBlockWithCrossAxisCountAndOffsets(
//       int crossAxisCount, List<double> offsets) {
//     final block = _findFirstAvailableBlock(offsets);
//     if (block.crossAxisCount < crossAxisCount) {
//       // Not enough space for the specified cross axis count.
//       // We have to fill this block and try again.
//       for (var i = 0; i < block.crossAxisCount; ++i) {
//         offsets[i + block.index] = block.maxOffset;
//       }
//       return _findFirstAvailableBlockWithCrossAxisCountAndOffsets(
//           crossAxisCount, offsets);
//     } else {
//       return block;
//     }
//   }

//   /// Finds the first available block for the specified [offsets] list.
//   static _Block _findFirstAvailableBlock(List<double> offsets) {
//     int index = 0;
//     double minBlockOffset = double.infinity;
//     double maxBlockOffset = double.infinity;
//     int crossAxisCount = 1;
//     bool contiguous = false;

//     // We have to use the _nearEqual function because of floating-point arithmetic.
//     // Ex: 0.1 + 0.2 = 0.30000000000000004 and not 0.3.

//     for (var i = index; i < offsets.length; ++i) {
//       final offset = offsets[i];
//       if (offset < minBlockOffset && !_nearEqual(offset, minBlockOffset)) {
//         index = i;
//         maxBlockOffset = minBlockOffset;
//         minBlockOffset = offset;
//         crossAxisCount = 1;
//         contiguous = true;
//       } else if (_nearEqual(offset, minBlockOffset) && contiguous) {
//         crossAxisCount++;
//       } else if (offset < maxBlockOffset &&
//           offset > minBlockOffset &&
//           !_nearEqual(offset, minBlockOffset)) {
//         contiguous = false;
//         maxBlockOffset = offset;
//       } else {
//         contiguous = false;
//       }
//     }

//     return _Block(index, crossAxisCount, minBlockOffset, maxBlockOffset);
//   }
// }

// abstract class SliverVariableSizeBoxAdaptorWidget
//     extends SliverWithKeepAliveWidget {
//   /// Initializes fields for subclasses.
//   const SliverVariableSizeBoxAdaptorWidget({
//     Key? key,
//     required this.delegate,
//     this.addAutomaticKeepAlives = true,
//   }) : super(key: key);

//   /// Whether to add keepAlives to children
//   final bool addAutomaticKeepAlives;

//   /// The delegate that provides the children for this widget.
//   ///
//   /// The children are constructed lazily using this widget to avoid creating
//   /// more children than are visible through the [Viewport].
//   ///
//   /// See also:
//   ///
//   ///  * [SliverChildBuilderDelegate] and [SliverChildListDelegate], which are
//   ///    commonly used subclasses of [SliverChildDelegate] that use a builder
//   ///    callback and an explicit child list, respectively.
//   final SliverChildDelegate delegate;

//   @override
//   SliverVariableSizeBoxAdaptorElement createElement() =>
//       SliverVariableSizeBoxAdaptorElement(
//         this,
//         addAutomaticKeepAlives: addAutomaticKeepAlives,
//       );

//   @override
//   RenderSliverVariableSizeBoxAdaptor createRenderObject(BuildContext context);

//   /// Returns an estimate of the max scroll extent for all the children.
//   ///
//   /// Subclasses should override this function if they have additional
//   /// information about their max scroll extent.
//   ///
//   /// This is used by [SliverMultiBoxAdaptorElement] to implement part of the
//   /// [RenderSliverBoxChildManager] API.
//   ///
//   /// The default implementation defers to [delegate] via its
//   /// [SliverChildDelegate.estimateMaxScrollOffset] method.
//   double? estimateMaxScrollOffset(
//     SliverConstraints constraints,
//     int firstIndex,
//     int lastIndex,
//     double leadingScrollOffset,
//     double trailingScrollOffset,
//   ) {
//     assert(lastIndex >= firstIndex);
//     return delegate.estimateMaxScrollOffset(
//       firstIndex,
//       lastIndex,
//       leadingScrollOffset,
//       trailingScrollOffset,
//     );
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//       DiagnosticsProperty<SliverChildDelegate>('delegate', delegate),
//     );
//   }
// }

// class StaggeredTile {
//   const StaggeredTile.count(this.crossAxisCellCount, this.mainAxisCellCount)
//       : assert(crossAxisCellCount >= 0),
//         assert(mainAxisCellCount != null && mainAxisCellCount >= 0),
//         mainAxisExtent = null;

//   const StaggeredTile.extent(this.crossAxisCellCount, this.mainAxisExtent)
//       : assert(crossAxisCellCount >= 0),
//         assert(mainAxisExtent != null && mainAxisExtent >= 0),
//         mainAxisCellCount = null;

//   const StaggeredTile.fit(this.crossAxisCellCount)
//       : assert(crossAxisCellCount >= 0),
//         mainAxisExtent = null,
//         mainAxisCellCount = null;

//   final int crossAxisCellCount;

//   final double? mainAxisCellCount;

//   final double? mainAxisExtent;

//   bool get fitContent => mainAxisCellCount == null && mainAxisExtent == null;
// }

// class SliverStaggeredGridDelegateWithFixedCrossAxisCount
//     extends SliverStaggeredGridDelegate {
//   const SliverStaggeredGridDelegateWithFixedCrossAxisCount({
//     required this.crossAxisCount,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     double mainAxisSpacing = 0,
//     double crossAxisSpacing = 0,
//     int? staggeredTileCount,
//   })  : assert(crossAxisCount > 0),
//         super(
//           staggeredTileBuilder: staggeredTileBuilder,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileCount: staggeredTileCount,
//         );

//   final int crossAxisCount;

//   @override
//   bool _debugAssertIsValid() {
//     assert(crossAxisCount > 0);
//     return super._debugAssertIsValid();
//   }

//   @override
//   StaggeredGridConfiguration getConfiguration(SliverConstraints constraints) {
//     assert(_debugAssertIsValid());
//     final double usableCrossAxisExtent =
//         constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
//     final double cellExtent = usableCrossAxisExtent / crossAxisCount;
//     return StaggeredGridConfiguration(
//       crossAxisCount: crossAxisCount,
//       staggeredTileBuilder: staggeredTileBuilder,
//       staggeredTileCount: staggeredTileCount,
//       cellExtent: cellExtent,
//       mainAxisSpacing: mainAxisSpacing,
//       crossAxisSpacing: crossAxisSpacing,
//       reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
//     );
//   }

//   @override
//   bool shouldRelayout(
//       covariant SliverStaggeredGridDelegateWithFixedCrossAxisCount
//           oldDelegate) {
//     return oldDelegate.crossAxisCount != crossAxisCount ||
//         super.shouldRelayout(oldDelegate);
//   }
// }

// abstract class SliverStaggeredGridDelegate {
//   const SliverStaggeredGridDelegate({
//     required this.staggeredTileBuilder,
//     this.mainAxisSpacing = 0,
//     this.crossAxisSpacing = 0,
//     this.staggeredTileCount,
//   })  : assert(mainAxisSpacing >= 0),
//         assert(crossAxisSpacing >= 0);

//   final double mainAxisSpacing;

//   final double crossAxisSpacing;

//   final IndexedStaggeredTileBuilder staggeredTileBuilder;

//   final int? staggeredTileCount;

//   bool _debugAssertIsValid() {
//     assert(mainAxisSpacing >= 0);
//     assert(crossAxisSpacing >= 0);
//     return true;
//   }

//   StaggeredGridConfiguration getConfiguration(SliverConstraints constraints);

//   bool shouldRelayout(SliverStaggeredGridDelegate oldDelegate) {
//     return oldDelegate.mainAxisSpacing != mainAxisSpacing ||
//         oldDelegate.crossAxisSpacing != crossAxisSpacing ||
//         oldDelegate.staggeredTileCount != staggeredTileCount ||
//         oldDelegate.staggeredTileBuilder != staggeredTileBuilder;
//   }
// }

// @immutable
// class StaggeredGridConfiguration {
//   const StaggeredGridConfiguration({
//     required this.crossAxisCount,
//     required this.staggeredTileBuilder,
//     required this.cellExtent,
//     required this.mainAxisSpacing,
//     required this.crossAxisSpacing,
//     required this.reverseCrossAxis,
//     required this.staggeredTileCount,
//     this.mainAxisOffsetsCacheSize = 3,
//   })  : assert(crossAxisCount > 0),
//         assert(cellExtent >= 0),
//         assert(mainAxisSpacing >= 0),
//         assert(crossAxisSpacing >= 0),
//         assert(mainAxisOffsetsCacheSize > 0),
//         cellStride = cellExtent + crossAxisSpacing;

//   final int crossAxisCount;

//   final double cellExtent;

//   final double mainAxisSpacing;

//   final double crossAxisSpacing;

//   final IndexedStaggeredTileBuilder staggeredTileBuilder;

//   final int? staggeredTileCount;

//   final bool reverseCrossAxis;

//   final double cellStride;

//   final int mainAxisOffsetsCacheSize;

//   List<double> generateMainAxisOffsets() =>
//       List.generate(crossAxisCount, (i) => 0.0);

//   StaggeredTile? getStaggeredTile(int index) {
//     StaggeredTile? tile;
//     if (staggeredTileCount == null || index < staggeredTileCount!) {
//       tile = _normalizeStaggeredTile(staggeredTileBuilder(index));
//     }
//     return tile;
//   }

//   double _getStaggeredTileMainAxisExtent(StaggeredTile tile) {
//     return tile.mainAxisExtent ??
//         (tile.mainAxisCellCount! * cellExtent) +
//             (tile.mainAxisCellCount! - 1) * mainAxisSpacing;
//   }

//   StaggeredTile? _normalizeStaggeredTile(StaggeredTile? staggeredTile) {
//     if (staggeredTile == null) {
//       return null;
//     } else {
//       final crossAxisCellCount =
//           staggeredTile.crossAxisCellCount.clamp(0, crossAxisCount).toInt();
//       if (staggeredTile.fitContent) {
//         return StaggeredTile.fit(crossAxisCellCount);
//       } else {
//         return StaggeredTile.extent(
//             crossAxisCellCount, _getStaggeredTileMainAxisExtent(staggeredTile));
//       }
//     }
//   }
// }

// class SliverConstraints extends Constraints {
//   const SliverConstraints({
//     required this.axisDirection,
//     required this.growthDirection,
//     required this.userScrollDirection,
//     required this.scrollOffset,
//     required this.precedingScrollExtent,
//     required this.overlap,
//     required this.remainingPaintExtent,
//     required this.crossAxisExtent,
//     required this.crossAxisDirection,
//     required this.viewportMainAxisExtent,
//     required this.remainingCacheExtent,
//     required this.cacheOrigin,
//   })  : assert(axisDirection != null),
//         assert(growthDirection != null),
//         assert(userScrollDirection != null),
//         assert(scrollOffset != null),
//         assert(precedingScrollExtent != null),
//         assert(overlap != null),
//         assert(remainingPaintExtent != null),
//         assert(crossAxisExtent != null),
//         assert(crossAxisDirection != null),
//         assert(viewportMainAxisExtent != null),
//         assert(remainingCacheExtent != null),
//         assert(cacheOrigin != null);

//   SliverConstraints copyWith({
//     AxisDirection? axisDirection,
//     GrowthDirection? growthDirection,
//     ScrollDirection? userScrollDirection,
//     double? scrollOffset,
//     double? precedingScrollExtent,
//     double? overlap,
//     double? remainingPaintExtent,
//     double? crossAxisExtent,
//     AxisDirection? crossAxisDirection,
//     double? viewportMainAxisExtent,
//     double? remainingCacheExtent,
//     double? cacheOrigin,
//   }) {
//     return SliverConstraints(
//       axisDirection: axisDirection ?? this.axisDirection,
//       growthDirection: growthDirection ?? this.growthDirection,
//       userScrollDirection: userScrollDirection ?? this.userScrollDirection,
//       scrollOffset: scrollOffset ?? this.scrollOffset,
//       precedingScrollExtent:
//           precedingScrollExtent ?? this.precedingScrollExtent,
//       overlap: overlap ?? this.overlap,
//       remainingPaintExtent: remainingPaintExtent ?? this.remainingPaintExtent,
//       crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
//       crossAxisDirection: crossAxisDirection ?? this.crossAxisDirection,
//       viewportMainAxisExtent:
//           viewportMainAxisExtent ?? this.viewportMainAxisExtent,
//       remainingCacheExtent: remainingCacheExtent ?? this.remainingCacheExtent,
//       cacheOrigin: cacheOrigin ?? this.cacheOrigin,
//     );
//   }

//   final AxisDirection axisDirection;

//   final GrowthDirection growthDirection;

//   final ScrollDirection userScrollDirection;

//   final double scrollOffset;

//   final double precedingScrollExtent;

//   final double overlap;

//   final double remainingPaintExtent;

//   final double crossAxisExtent;

//   final AxisDirection crossAxisDirection;

//   final double viewportMainAxisExtent;

//   final double cacheOrigin;

//   final double remainingCacheExtent;

//   Axis get axis => axisDirectionToAxis(axisDirection);

//   GrowthDirection get normalizedGrowthDirection {
//     assert(axisDirection != null);
//     switch (axisDirection) {
//       case AxisDirection.down:
//       case AxisDirection.right:
//         return growthDirection;
//       case AxisDirection.up:
//       case AxisDirection.left:
//         switch (growthDirection) {
//           case GrowthDirection.forward:
//             return GrowthDirection.reverse;
//           case GrowthDirection.reverse:
//             return GrowthDirection.forward;
//         }
//     }
//   }

//   @override
//   bool get isTight => false;

//   @override
//   bool get isNormalized {
//     return scrollOffset >= 0.0 &&
//         crossAxisExtent >= 0.0 &&
//         axisDirectionToAxis(axisDirection) !=
//             axisDirectionToAxis(crossAxisDirection) &&
//         viewportMainAxisExtent >= 0.0 &&
//         remainingPaintExtent >= 0.0;
//   }

//   BoxConstraints asBoxConstraints({
//     double minExtent = 0.0,
//     double maxExtent = double.infinity,
//     double? crossAxisExtent,
//   }) {
//     crossAxisExtent ??= this.crossAxisExtent;
//     switch (axis) {
//       case Axis.horizontal:
//         return BoxConstraints(
//           minHeight: crossAxisExtent,
//           maxHeight: crossAxisExtent,
//           minWidth: minExtent,
//           maxWidth: maxExtent,
//         );
//       case Axis.vertical:
//         return BoxConstraints(
//           minWidth: crossAxisExtent,
//           maxWidth: crossAxisExtent,
//           minHeight: minExtent,
//           maxHeight: maxExtent,
//         );
//     }
//   }

//   @override
//   bool debugAssertIsValid({
//     bool isAppliedConstraint = false,
//     InformationCollector? informationCollector,
//   }) {
//     assert(() {
//       bool hasErrors = false;
//       final StringBuffer errorMessage = StringBuffer('\n');
//       void verify(bool check, String message) {
//         if (check) return;
//         hasErrors = true;
//         errorMessage.writeln('  $message');
//       }

//       void verifyDouble(double property, String name,
//           {bool mustBePositive = false, bool mustBeNegative = false}) {
//         verify(property != null, 'The "$name" is null.');
//         if (property.isNaN) {
//           String additional = '.';
//           if (mustBePositive) {
//             additional = ', expected greater than or equal to zero.';
//           } else if (mustBeNegative) {
//             additional = ', expected less than or equal to zero.';
//           }
//           verify(false, 'The "$name" is NaN$additional');
//         } else if (mustBePositive) {
//           verify(property >= 0.0, 'The "$name" is negative.');
//         } else if (mustBeNegative) {
//           verify(property <= 0.0, 'The "$name" is positive.');
//         }
//       }

//       verify(axis != null, 'The "axis" is null.');
//       verify(growthDirection != null, 'The "growthDirection" is null.');
//       verifyDouble(scrollOffset, 'scrollOffset');
//       verifyDouble(overlap, 'overlap');
//       verifyDouble(crossAxisExtent, 'crossAxisExtent');
//       verifyDouble(scrollOffset, 'scrollOffset', mustBePositive: true);
//       verify(crossAxisDirection != null, 'The "crossAxisDirection" is null.');
//       verify(
//           axisDirectionToAxis(axisDirection) !=
//               axisDirectionToAxis(crossAxisDirection),
//           'The "axisDirection" and the "crossAxisDirection" are along the same axis.');
//       verifyDouble(viewportMainAxisExtent, 'viewportMainAxisExtent',
//           mustBePositive: true);
//       verifyDouble(remainingPaintExtent, 'remainingPaintExtent',
//           mustBePositive: true);
//       verifyDouble(remainingCacheExtent, 'remainingCacheExtent',
//           mustBePositive: true);
//       verifyDouble(cacheOrigin, 'cacheOrigin', mustBeNegative: true);
//       verifyDouble(precedingScrollExtent, 'precedingScrollExtent',
//           mustBePositive: true);
//       verify(isNormalized, 'The constraints are not normalized.');
//       if (hasErrors) {
//         throw FlutterError.fromParts(<DiagnosticsNode>[
//           ErrorSummary('$runtimeType is not valid: $errorMessage'),
//           if (informationCollector != null) ...informationCollector(),
//           DiagnosticsProperty<SliverConstraints>(
//               'The offending constraints were', this,
//               style: DiagnosticsTreeStyle.errorProperty),
//         ]);
//       }
//       return true;
//     }());
//     return true;
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! SliverConstraints) return false;
//     assert(other.debugAssertIsValid());
//     return other.axisDirection == axisDirection &&
//         other.growthDirection == growthDirection &&
//         other.scrollOffset == scrollOffset &&
//         other.overlap == overlap &&
//         other.remainingPaintExtent == remainingPaintExtent &&
//         other.crossAxisExtent == crossAxisExtent &&
//         other.crossAxisDirection == crossAxisDirection &&
//         other.viewportMainAxisExtent == viewportMainAxisExtent &&
//         other.remainingCacheExtent == remainingCacheExtent &&
//         other.cacheOrigin == cacheOrigin;
//   }

//   @override
//   int get hashCode {
//     return hashValues(
//       axisDirection,
//       growthDirection,
//       scrollOffset,
//       overlap,
//       remainingPaintExtent,
//       crossAxisExtent,
//       crossAxisDirection,
//       viewportMainAxisExtent,
//       remainingCacheExtent,
//       cacheOrigin,
//     );
//   }

//   @override
//   String toString() {
//     final List<String> properties = <String>[
//       '$axisDirection',
//       '$growthDirection',
//       '$userScrollDirection',
//       'scrollOffset: ${scrollOffset.toStringAsFixed(1)}',
//       'remainingPaintExtent: ${remainingPaintExtent.toStringAsFixed(1)}',
//       if (overlap != 0.0) 'overlap: ${overlap.toStringAsFixed(1)}',
//       'crossAxisExtent: ${crossAxisExtent.toStringAsFixed(1)}',
//       'crossAxisDirection: $crossAxisDirection',
//       'viewportMainAxisExtent: ${viewportMainAxisExtent.toStringAsFixed(1)}',
//       'remainingCacheExtent: ${remainingCacheExtent.toStringAsFixed(1)}',
//       'cacheOrigin: ${cacheOrigin.toStringAsFixed(1)}',
//     ];
//     return 'SliverConstraints(${properties.join(', ')})';
//   }
// }

// class DiagnosticsProperty<T> extends DiagnosticsNode {
//   DiagnosticsProperty(
//     String? name,
//     T? value, {
//     String? description,
//     String? ifNull,
//     this.ifEmpty,
//     bool showName = true,
//     bool showSeparator = true,
//     this.defaultValue = kNoDefaultValue,
//     this.tooltip,
//     this.missingIfNull = false,
//     String? linePrefix,
//     this.expandableValue = false,
//     this.allowWrap = true,
//     this.allowNameWrap = true,
//     DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine,
//     DiagnosticLevel level = DiagnosticLevel.info,
//   })  : assert(showName != null),
//         assert(showSeparator != null),
//         assert(style != null),
//         assert(level != null),
//         _description = description,
//         _valueComputed = true,
//         _value = value,
//         _computeValue = null,
//         ifNull = ifNull ?? (missingIfNull ? 'MISSING' : null),
//         _defaultLevel = level,
//         super(
//           name: name,
//           showName: showName,
//           showSeparator: showSeparator,
//           style: style,
//           linePrefix: linePrefix,
//         );

//   DiagnosticsProperty.lazy(
//     String? name,
//     ComputePropertyValueCallback<T> computeValue, {
//     String? description,
//     String? ifNull,
//     this.ifEmpty,
//     bool showName = true,
//     bool showSeparator = true,
//     this.defaultValue = kNoDefaultValue,
//     this.tooltip,
//     this.missingIfNull = false,
//     this.expandableValue = false,
//     this.allowWrap = true,
//     this.allowNameWrap = true,
//     DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine,
//     DiagnosticLevel level = DiagnosticLevel.info,
//   })  : assert(showName != null),
//         assert(showSeparator != null),
//         assert(defaultValue == kNoDefaultValue || defaultValue is T?),
//         assert(missingIfNull != null),
//         assert(style != null),
//         assert(level != null),
//         _description = description,
//         _valueComputed = false,
//         _value = null,
//         _computeValue = computeValue,
//         _defaultLevel = level,
//         ifNull = ifNull ?? (missingIfNull ? 'MISSING' : null),
//         super(
//           name: name,
//           showName: showName,
//           showSeparator: showSeparator,
//           style: style,
//         );

//   final String? _description;

//   final bool expandableValue;

//   @override
//   final bool allowWrap;

//   @override
//   final bool allowNameWrap;

//   @override
//   Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate) {
//     final T? v = value;
//     List<Map<String, Object?>>? properties;
//     if (delegate.expandPropertyValues &&
//         delegate.includeProperties &&
//         v is Diagnosticable &&
//         getProperties().isEmpty) {
//       delegate = delegate.copyWith(subtreeDepth: 0, includeProperties: false);
//       properties = DiagnosticsNode.toJsonList(
//         delegate.filterProperties(v.toDiagnosticsNode().getProperties(), this),
//         this,
//         delegate,
//       );
//     }
//     final Map<String, Object?> json = super.toJsonMap(delegate);
//     if (properties != null) {
//       json['properties'] = properties;
//     }
//     if (defaultValue != kNoDefaultValue)
//       json['defaultValue'] = defaultValue.toString();
//     if (ifEmpty != null) json['ifEmpty'] = ifEmpty;
//     if (ifNull != null) json['ifNull'] = ifNull;
//     if (tooltip != null) json['tooltip'] = tooltip;
//     json['missingIfNull'] = missingIfNull;
//     if (exception != null) json['exception'] = exception.toString();
//     json['propertyType'] = propertyType.toString();
//     json['defaultLevel'] = _defaultLevel.name;
//     if (value is Diagnosticable || value is DiagnosticsNode)
//       json['isDiagnosticableValue'] = true;
//     if (v is num) json['value'] = v.isFinite ? v : v.toString();
//     if (value is String || value is bool || value == null)
//       json['value'] = value;
//     return json;
//   }

//   String valueToString({TextTreeConfiguration? parentConfiguration}) {
//     final T? v = value;

//     return v is DiagnosticableTree ? v.toStringShort() : v.toString();
//   }

//   @override
//   String toDescription({TextTreeConfiguration? parentConfiguration}) {
//     if (_description != null) return _addTooltip(_description!);

//     if (exception != null) return 'EXCEPTION (${exception.runtimeType})';

//     if (ifNull != null && value == null) return _addTooltip(ifNull!);

//     String result = valueToString(parentConfiguration: parentConfiguration);
//     if (result.isEmpty && ifEmpty != null) result = ifEmpty!;
//     return _addTooltip(result);
//   }

//   String _addTooltip(String text) {
//     assert(text != null);
//     return tooltip == null ? text : '$text ($tooltip)';
//   }

//   final String? ifNull;

//   final String? ifEmpty;

//   final String? tooltip;

//   final bool missingIfNull;

//   Type get propertyType => T;

//   @override
//   T? get value {
//     _maybeCacheValue();
//     return _value;
//   }

//   T? _value;

//   bool _valueComputed;

//   Object? _exception;

//   Object? get exception {
//     _maybeCacheValue();
//     return _exception;
//   }

//   void _maybeCacheValue() {
//     if (_valueComputed) return;

//     _valueComputed = true;
//     assert(_computeValue != null);
//     try {
//       _value = _computeValue!();
//     } catch (exception) {
//       _exception = exception;
//       _value = null;
//     }
//   }

//   final Object? defaultValue;

//   bool get isInteresting =>
//       defaultValue == kNoDefaultValue || value != defaultValue;

//   final DiagnosticLevel _defaultLevel;

//   @override
//   DiagnosticLevel get level {
//     if (_defaultLevel == DiagnosticLevel.hidden) return _defaultLevel;

//     if (exception != null) return DiagnosticLevel.error;

//     if (value == null && missingIfNull) return DiagnosticLevel.warning;

//     if (!isInteresting) return DiagnosticLevel.fine;

//     return _defaultLevel;
//   }

//   final ComputePropertyValueCallback<T>? _computeValue;

//   @override
//   List<DiagnosticsNode> getProperties() {
//     if (expandableValue) {
//       final T? object = value;
//       if (object is DiagnosticsNode) {
//         return object.getProperties();
//       }
//       if (object is Diagnosticable) {
//         return object.toDiagnosticsNode(style: style).getProperties();
//       }
//     }
//     return const <DiagnosticsNode>[];
//   }

//   @override
//   List<DiagnosticsNode> getChildren() {
//     if (expandableValue) {
//       final T? object = value;
//       if (object is DiagnosticsNode) {
//         return object.getChildren();
//       }
//       if (object is Diagnosticable) {
//         return object.toDiagnosticsNode(style: style).getChildren();
//       }
//     }
//     return const <DiagnosticsNode>[];
//   }
// }

// mixin Diagnosticable {
//   String toStringShort() => describeIdentity(this);

//   @override
//   String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
//     String? fullString;
//     assert(() {
//       fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine)
//           .toString(minLevel: minLevel);
//       return true;
//     }());
//     return fullString ?? toStringShort();
//   }

//   DiagnosticsNode toDiagnosticsNode(
//       {String? name, DiagnosticsTreeStyle? style}) {
//     return DiagnosticableNode<Diagnosticable>(
//       name: name,
//       value: this,
//       style: style,
//     );
//   }

//   @protected
//   @mustCallSuper
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {}
// }

// class DiagnosticPropertiesBuilder {
//   DiagnosticPropertiesBuilder() : properties = <DiagnosticsNode>[];

//   DiagnosticPropertiesBuilder.fromProperties(this.properties);

//   void add(DiagnosticsNode property) {
//     assert(() {
//       properties.add(property);
//       return true;
//     }());
//   }

//   final List<DiagnosticsNode> properties;

//   DiagnosticsTreeStyle defaultDiagnosticsTreeStyle =
//       DiagnosticsTreeStyle.sparse;

//   String? emptyBodyDescription;
// }

// class DiagnosticableNode<T extends Diagnosticable> extends DiagnosticsNode {
//   DiagnosticableNode({
//     String? name,
//     required this.value,
//     required DiagnosticsTreeStyle? style,
//   })  : assert(value != null),
//         super(
//           name: name,
//           style: style,
//         );

//   @override
//   final T value;

//   DiagnosticPropertiesBuilder? _cachedBuilder;

//   DiagnosticPropertiesBuilder? get builder {
//     if (kReleaseMode) {
//       return null;
//     } else {
//       assert(() {
//         if (_cachedBuilder == null) {
//           _cachedBuilder = DiagnosticPropertiesBuilder();
//           value.debugFillProperties(_cachedBuilder!);
//         }
//         return true;
//       }());
//       return _cachedBuilder;
//     }
//   }

//   @override
//   DiagnosticsTreeStyle get style {
//     return kReleaseMode
//         ? DiagnosticsTreeStyle.none
//         : super.style ?? builder!.defaultDiagnosticsTreeStyle;
//   }

//   @override
//   String? get emptyBodyDescription =>
//       (kReleaseMode || kProfileMode) ? '' : builder!.emptyBodyDescription;

//   @override
//   List<DiagnosticsNode> getProperties() => (kReleaseMode || kProfileMode)
//       ? const <DiagnosticsNode>[]
//       : builder!.properties;

//   @override
//   List<DiagnosticsNode> getChildren() {
//     return const <DiagnosticsNode>[];
//   }

//   @override
//   String toDescription({TextTreeConfiguration? parentConfiguration}) {
//     String result = '';
//     assert(() {
//       result = value.toStringShort();
//       return true;
//     }());
//     return result;
//   }
// }

// class TextTreeConfiguration {
//   /// Create a configuration object describing how to render a tree as text.
//   ///
//   /// All of the arguments must not be null.
//   TextTreeConfiguration({
//     required this.prefixLineOne,
//     required this.prefixOtherLines,
//     required this.prefixLastChildLineOne,
//     required this.prefixOtherLinesRootNode,
//     required this.linkCharacter,
//     required this.propertyPrefixIfChildren,
//     required this.propertyPrefixNoChildren,
//     this.lineBreak = '\n',
//     this.lineBreakProperties = true,
//     this.afterName = ':',
//     this.afterDescriptionIfBody = '',
//     this.afterDescription = '',
//     this.beforeProperties = '',
//     this.afterProperties = '',
//     this.mandatoryAfterProperties = '',
//     this.propertySeparator = '',
//     this.bodyIndent = '',
//     this.footer = '',
//     this.showChildren = true,
//     this.addBlankLineIfNoChildren = true,
//     this.isNameOnOwnLine = false,
//     this.isBlankLineBetweenPropertiesAndChildren = true,
//     this.beforeName = '',
//     this.suffixLineOne = '',
//     this.mandatoryFooter = '',
//   })  : assert(prefixLineOne != null),
//         assert(prefixOtherLines != null),
//         assert(prefixLastChildLineOne != null),
//         assert(prefixOtherLinesRootNode != null),
//         assert(linkCharacter != null),
//         assert(propertyPrefixIfChildren != null),
//         assert(propertyPrefixNoChildren != null),
//         assert(lineBreak != null),
//         assert(lineBreakProperties != null),
//         assert(afterName != null),
//         assert(afterDescriptionIfBody != null),
//         assert(afterDescription != null),
//         assert(beforeProperties != null),
//         assert(afterProperties != null),
//         assert(propertySeparator != null),
//         assert(bodyIndent != null),
//         assert(footer != null),
//         assert(showChildren != null),
//         assert(addBlankLineIfNoChildren != null),
//         assert(isNameOnOwnLine != null),
//         assert(isBlankLineBetweenPropertiesAndChildren != null),
//         childLinkSpace = ' ' * linkCharacter.length;

//   /// Prefix to add to the first line to display a child with this style.
//   final String prefixLineOne;

//   /// Suffix to add to end of the first line to make its length match the footer.
//   final String suffixLineOne;

//   /// Prefix to add to other lines to display a child with this style.
//   ///
//   /// [prefixOtherLines] should typically be one character shorter than
//   /// [prefixLineOne] is.
//   final String prefixOtherLines;

//   /// Prefix to add to the first line to display the last child of a node with
//   /// this style.
//   final String prefixLastChildLineOne;

//   /// Additional prefix to add to other lines of a node if this is the root node
//   /// of the tree.
//   final String prefixOtherLinesRootNode;

//   /// Prefix to add before each property if the node as children.
//   ///
//   /// Plays a similar role to [linkCharacter] except that some configurations
//   /// intentionally use a different line style than the [linkCharacter].
//   final String propertyPrefixIfChildren;

//   /// Prefix to add before each property if the node does not have children.
//   ///
//   /// This string is typically a whitespace string the same length as
//   /// [propertyPrefixIfChildren] but can have a different length.
//   final String propertyPrefixNoChildren;

//   /// Character to use to draw line linking parent to child.
//   ///
//   /// The first child does not require a line but all subsequent children do
//   /// with the line drawn immediately before the left edge of the previous
//   /// sibling.
//   final String linkCharacter;

//   /// Whitespace to draw instead of the childLink character if this node is the
//   /// last child of its parent so no link line is required.
//   final String childLinkSpace;

//   /// Character(s) to use to separate lines.
//   ///
//   /// Typically leave set at the default value of '\n' unless this style needs
//   /// to treat lines differently as is the case for
//   /// [singleLineTextConfiguration].
//   final String lineBreak;

//   /// Whether to place line breaks between properties or to leave all
//   /// properties on one line.
//   final bool lineBreakProperties;

//   /// Text added immediately before the name of the node.
//   ///
//   /// See [errorTextConfiguration] for an example of using this to achieve a
//   /// custom line art style.
//   final String beforeName;

//   /// Text added immediately after the name of the node.
//   ///
//   /// See [transitionTextConfiguration] for an example of using a value other
//   /// than ':' to achieve a custom line art style.
//   final String afterName;

//   /// Text to add immediately after the description line of a node with
//   /// properties and/or children if the node has a body.
//   final String afterDescriptionIfBody;

//   /// Text to add immediately after the description line of a node with
//   /// properties and/or children.
//   final String afterDescription;

//   /// Optional string to add before the properties of a node.
//   ///
//   /// Only displayed if the node has properties.
//   /// See [singleLineTextConfiguration] for an example of using this field
//   /// to enclose the property list with parenthesis.
//   final String beforeProperties;

//   /// Optional string to add after the properties of a node.
//   ///
//   /// See documentation for [beforeProperties].
//   final String afterProperties;

//   /// Mandatory string to add after the properties of a node regardless of
//   /// whether the node has any properties.
//   final String mandatoryAfterProperties;

//   /// Property separator to add between properties.
//   ///
//   /// See [singleLineTextConfiguration] for an example of using this field
//   /// to render properties as a comma separated list.
//   final String propertySeparator;

//   /// Prefix to add to all lines of the body of the tree node.
//   ///
//   /// The body is all content in the node other than the name and description.
//   final String bodyIndent;

//   /// Whether the children of a node should be shown.
//   ///
//   /// See [singleLineTextConfiguration] for an example of using this field to
//   /// hide all children of a node.
//   final bool showChildren;

//   /// Whether to add a blank line at the end of the output for a node if it has
//   /// no children.
//   ///
//   /// See [denseTextConfiguration] for an example of setting this to false.
//   final bool addBlankLineIfNoChildren;

//   /// Whether the name should be displayed on the same line as the description.
//   final bool isNameOnOwnLine;

//   /// Footer to add as its own line at the end of a non-root node.
//   ///
//   /// See [transitionTextConfiguration] for an example of using footer to draw a box
//   /// around the node. [footer] is indented the same amount as [prefixOtherLines].
//   final String footer;

//   /// Footer to add even for root nodes.
//   final String mandatoryFooter;

//   /// Add a blank line between properties and children if both are present.
//   final bool isBlankLineBetweenPropertiesAndChildren;
// }

// class SliverStaggeredGridDelegateWithMaxCrossAxisExtent
//     extends SliverStaggeredGridDelegate {
//   /// Creates a delegate that makes staggered grid layouts with tiles that
//   /// have a maximum cross-axis extent.
//   ///
//   /// All of the arguments must not be null. The [maxCrossAxisExtent],
//   /// [mainAxisSpacing] and [crossAxisSpacing] arguments must not be negative.
//   const SliverStaggeredGridDelegateWithMaxCrossAxisExtent({
//     required this.maxCrossAxisExtent,
//     required IndexedStaggeredTileBuilder staggeredTileBuilder,
//     double mainAxisSpacing = 0,
//     double crossAxisSpacing = 0,
//     int? staggeredTileCount,
//   })  : assert(maxCrossAxisExtent > 0),
//         super(
//           staggeredTileBuilder: staggeredTileBuilder,
//           mainAxisSpacing: mainAxisSpacing,
//           crossAxisSpacing: crossAxisSpacing,
//           staggeredTileCount: staggeredTileCount,
//         );

//   /// The maximum extent of tiles in the cross axis.
//   ///
//   /// This delegate will select a cross-axis extent for the tiles that is as
//   /// large as possible subject to the following conditions:
//   ///
//   ///  - The extent evenly divides the cross-axis extent of the grid.
//   ///  - The extent is at most [maxCrossAxisExtent].
//   ///
//   /// For example, if the grid is vertical, the grid is 500.0 pixels wide, and
//   /// [maxCrossAxisExtent] is 150.0, this delegate will create a grid with 4
//   /// columns that are 125.0 pixels wide.
//   final double maxCrossAxisExtent;

//   @override
//   bool _debugAssertIsValid() {
//     assert(maxCrossAxisExtent >= 0);
//     return super._debugAssertIsValid();
//   }

//   @override
//   StaggeredGridConfiguration getConfiguration(SliverConstraints constraints) {
//     assert(_debugAssertIsValid());
//     final int crossAxisCount =
//         ((constraints.crossAxisExtent + crossAxisSpacing) /
//                 (maxCrossAxisExtent + crossAxisSpacing))
//             .ceil();

//     final double usableCrossAxisExtent =
//         constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);

//     final double cellExtent = usableCrossAxisExtent / crossAxisCount;
//     return StaggeredGridConfiguration(
//       crossAxisCount: crossAxisCount,
//       staggeredTileBuilder: staggeredTileBuilder,
//       staggeredTileCount: staggeredTileCount,
//       cellExtent: cellExtent,
//       mainAxisSpacing: mainAxisSpacing,
//       crossAxisSpacing: crossAxisSpacing,
//       reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
//     );
//   }

//   @override
//   bool shouldRelayout(
//       covariant SliverStaggeredGridDelegateWithMaxCrossAxisExtent oldDelegate) {
//     return oldDelegate.maxCrossAxisExtent != maxCrossAxisExtent ||
//         super.shouldRelayout(oldDelegate);
//   }
// }

// enum DiagnosticsTreeStyle {
//   none,

//   sparse,

//   offstage,

//   dense,

//   transition,

//   error,

//   whitespace,

//   flat,

//   singleLine,

//   errorProperty,

//   shallow,

//   truncateChildren,
// }
