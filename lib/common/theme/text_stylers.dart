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
  static Widget priceSection(BuildContext context, int price) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(
            "${(price * 1.3).toDouble().toStringAsPrecision(4)} \$",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
                color: AppColors.black.withOpacity(0.4),
                decoration: TextDecoration.lineThrough),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                "${price.toDouble().toStringAsPrecision(4)} \$",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}