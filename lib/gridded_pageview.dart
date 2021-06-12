/// Copyright (c) 2021, Wilkin van Roosmalen
/// This file is part of the "gridded_pageview" Flutter package and is released under the BSD 3-Clause License


library flutter_gridded_pageview;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class GriddedPageView extends StatelessWidget {

  final PageController controller;
  final List<Widget> children;
  final bool showIndicator;
  final bool overlapIndicator;
  final int minChildWidth;
  final int minChildHeight;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onPageAmountChanged;
  final EdgeInsets indicatorPadding;
  final Color indicatorColor;
  final Color indicatorSelectorColor;
  late final EdgeInsets pagePadding;

  GriddedPageView({
    required this.controller,
    required this.children,
    required this.minChildWidth,
    required this.minChildHeight,
    this.onPageChanged,
    this.onPageAmountChanged,
    this.showIndicator: true,
    this.overlapIndicator: true,
    this.indicatorPadding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
    this.indicatorSelectorColor: Colors.blue,
    this.indicatorColor: Colors.grey,
    pagePadding: EdgeInsets.zero,
  }) {
    this.pagePadding = overlapIndicator ? pagePadding : pagePadding.add(EdgeInsets.only(bottom: 32));
  }

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return Container();

    return LayoutBuilder(
        builder: (context, constraints) {
          int pages = (children.length / _itemsPerPage(constraints)).ceil();
          onPageAmountChanged?.call(pages);

          if (showIndicator && pages > 1) {
            return PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              padding: indicatorPadding,
              length: pages,
              indicatorColor: Colors.grey,
              indicatorSelectorColor: Colors.blue,
              child: _pageViewBuilder(
                  pages,
                  _itemsPerPage(constraints),
                  constraints
              ),
            );
          } else {
            return _pageViewBuilder(
                pages,
                _itemsPerPage(constraints),
                constraints
            );
          }
        }
    );
  }

  Widget _pageViewBuilder(int pages, int itemsPerPage, BoxConstraints constraints) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: pages,
      itemBuilder: (context, index) {
        int start = index * itemsPerPage;
        int end = start + itemsPerPage;
        if (end >= this.children.length) end = this.children.length;
        List<Widget> children = this.children.sublist(start, end);

        return Padding(
          padding: pagePadding,
          child: GridView.count(
            childAspectRatio: _calcAspectRatio(constraints),
            crossAxisCount: _calcColumns(constraints),
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        );
      },
    );
  }

  int _calcRows(BoxConstraints constraints) {
    int rows = (_availableHeight(constraints) / minChildHeight).floor();
    return (rows < 1)? 1 : (_availableHeight(constraints) / minChildHeight).floor();
  }

  int _calcColumns(BoxConstraints constraints) {
    int columns = (_availableWidth(constraints) / minChildWidth).floor();
    return (columns < 1)? 1 : (_availableWidth(constraints) / minChildWidth).floor();
  }

  double _calcAspectRatio(BoxConstraints constraints) {
    double width = _availableWidth(constraints) / _calcColumns(constraints);
    double height = _availableHeight(constraints) / _calcRows(constraints);
    return width/height;
  }

  int _itemsPerPage(BoxConstraints constraints) {
    int itemsPerPage = _calcRows(constraints) * _calcColumns(constraints);
    if (itemsPerPage >= children.length) itemsPerPage = children.length;
    return itemsPerPage;
  }

  double _availableWidth(BoxConstraints constraints) =>
      constraints.maxWidth - pagePadding.left - pagePadding.right;

  double _availableHeight(BoxConstraints constraints) =>
      constraints.maxHeight - pagePadding.bottom - pagePadding.top;

}
