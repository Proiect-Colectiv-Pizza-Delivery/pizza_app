import 'package:flutter/material.dart';
import 'package:pizza_app/common/theme/colors.dart';

class TextStyler {
  static Widget subtitle(BuildContext context, String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.secondary,
            ),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
