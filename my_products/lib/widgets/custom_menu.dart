import 'package:flutter/material.dart';

class MyPopupMenu<T> extends PopupMenuItem<T> {
  @override
  final Widget child;
  final Function OnClick;
  MyPopupMenu({required this.OnClick, required this.child})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenu<T>> {
  @override
  void handleTap() {
    widget.OnClick();
  }
}
