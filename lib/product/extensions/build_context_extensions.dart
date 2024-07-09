
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext{
  double dynamicWidht(double val) => MediaQuery.sizeOf(this).width * val;
  double dynamicHeight(double val) => MediaQuery.sizeOf(this).height * val;

  TextTheme textTheme(){
    return Theme.of(this).textTheme;
  }
}

extension NumberExtension on BuildContext{
  double get lowValue1 => dynamicHeight(0.01);
  double get lowValue2 => dynamicHeight(0.02);
  double get mediumValue => dynamicHeight(0.03);
  double get highValue => dynamicHeight(0.05);
  double get buttonHeight => dynamicHeight(0.075);
  double get highLogoHeight => dynamicHeight(0.3);
  double get  mediumLogoHeight => dynamicHeight(0.13);
  
}


extension PaddingExtension on BuildContext{
  EdgeInsets get paddingAllLow1 => EdgeInsets.all(lowValue1);
  EdgeInsets get paddingAllLow2 => EdgeInsets.all(lowValue2);
  EdgeInsets get paddingColumnHorizontal => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingColumnHorizontalLow1 => EdgeInsets.symmetric(horizontal: lowValue1);
  EdgeInsets get paddingColumnHorizontalLow2 => EdgeInsets.symmetric(horizontal: lowValue2);

}