# CHANGELOG

## 0.3.0
- Fixed some bugs.
- Added new `Image` methods:
    - `#resize_to_fit`
    - `#property`
    - `#set_property`
    - `#delete_property`
    - `#xmp`
- Renamed `Image#extend` back to `Image#extent` because `extend` is a reserved word in Crystal.
- Removed some unnecessary alias types in `LibMagick`.

## 0.2.0
- Improved `Image` and `Pixel` APIs.
- Added comments to a lot of `Image` methods.
- Added `Brush` class as an analog to the `LibMagick::DrawingWand` class.
- Updated examples, all examples now use the `Image`, `Pixel`, and `Brush` classes with no reliance on `LibMagick`.

## 0.1.0
- First release
