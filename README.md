# gridded_pageview

A simple flutter widget based on code used multiple private projects.
Pass a list of similar sized widgets to the `GriddedPageView` and set a preferred size to display them in a combination of `GridView` and `PageView`.
`GriddedPageView` distrubutes its children over these pages depending on the available size.

This widget uses [page_indicator](https://pub.dev/packages/page_indicator).


![Demo GriddedPageView](https://user-images.githubusercontent.com/9255132/121788040-626bdb00-cbca-11eb-8804-1d286a9e3501.gif)

# Usage

Example (see [example main.dart](example/lib/main.dart)):
```dart
GriddedPageView(
  controller: _controller,
  preferredChildWidth: 160,
  preferredChildHeight: 160,
  children: List<Widget>.generate(20, (int index) {
    return Container(
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    );
  }),
  // overlapIndicator: false,
);
```

`GriddedPageView` accepts the following arguments:
- `controller` (required): a [PageController](https://api.flutter.dev/flutter/widgets/PageController-class.html)
- `children` (required): a List of Widgets
- `minChildWidth` (required): the minimum width of each child. Used to calculate how many columns can fit on a page
- `minChildHeight`(required): the minimum height of each child. Used to calculate how many rows can fit on a page
- `onPageChanged`: a callback used to report a page change
- `onPageAmountChanged:` a callback used to report a change in the amount of pages
- `showIndicator`: whether to show the page indicator (true by default)
- `overLapIndicator`: whether the page indicator should overlap the children (true by default)
- `pagePadding`: padding around the page content (GridView)
- `indicatorPadding`: padding around the page indicator
- `indicatorColor`: color of the page indicator
- `indicatorSelectorColor`: color of the current page indicator

# Contributing

Feel free to ask questions, report issues, fork and create pull requests.

I will not maintain this actively beyond my specific needs, so don't expect me to implement new features. 
