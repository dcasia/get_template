/*
 * @Description: 颜色相关
 * @Author: iamsmiling
 * @Date: 2021-09-18 16:00:13
 * @LastEditTime: 2021-09-18 16:04:50
 */
part of r;

class _RColor {
  static _RColor _singleton = _RColor._();
  // ignore: unused_element
  _RColor._();
  factory _RColor() => _singleton;

  final Color primary = const Color(0xFF39CAAF);

  final Color textButton = const Color(0xFF33BAA1);

  final Color white = Colors.white;

  final Color textFieldBorder = const Color(0xFF222222);

  final Color scaffoldBgColor = const Color(0xFFF4F4F4);
}
