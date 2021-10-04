import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

double foodDetailsImageAreaSize(BuildContext context) {
  return MediaQuery.of(context).size.height / 3;
}
