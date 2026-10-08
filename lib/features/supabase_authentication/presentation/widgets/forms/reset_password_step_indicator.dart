import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ResetPasswordStepIndicator extends StatelessWidget {
  const new({required this.currentStep, super.key});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    const List<String> stepLabels = <String>['Email', 'Code', 'Mot de passe'];
    final Color activeColor = theme.colorScheme.primary;
    final Color inactiveLineColor = theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2);

    return Stack(
      children: <Widget>[
        // Connecting lines between the centers of the 3 circles
        Positioned(
          top: 16, // Center of the 34px circle: (34 - 2) / 2 = 16
          left: 0,
          right: 0,
          child: Row(
            children: <Widget>[
              const Spacer(), // Takes 1/6 width to circle 1 center
              Expanded(
                flex: 2, // From circle 1 center to circle 2 center
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: currentStep >= 1 ? activeColor : inactiveLineColor,
                    borderRadius: const .all(.circular(1)),
                  ),
                ),
              ),
              Expanded(
                flex: 2, // From circle 2 center to circle 3 center
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: currentStep >= 2 ? activeColor : inactiveLineColor,
                    borderRadius: const .all(.circular(1)),
                  ),
                ),
              ),
              const Spacer(), // Takes 1/6 width from circle 3 center to right edge
            ],
          ),
        ),

        // 3 Equal-width columns (1/3 width each)
        Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            for (int i = 0; i < stepLabels.length; i++)
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  spacing: AppSpacing.space2xs.value,
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: i < currentStep
                            ? activeColor
                            : (i == currentStep ? theme.colorScheme.primaryContainer : theme.colorScheme.surface),
                        border: .all(
                          color: i <= currentStep ? activeColor : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                          width: i == currentStep ? 2 : 1,
                        ),
                        boxShadow: i == currentStep
                            ? <BoxShadow>[
                                BoxShadow(color: activeColor.withValues(alpha: 0.35), blurRadius: 10, spreadRadius: 1),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: i < currentStep
                            ? Icon(Icons.check, size: 18, color: theme.colorScheme.onPrimary)
                            : Text(
                                '${i + 1}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: i == currentStep ? activeColor : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                  fontWeight: i == currentStep ? .bold : .w500,
                                ),
                              ),
                      ),
                    ),
                    Text(
                      stepLabels[i],
                      textAlign: .center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: i == currentStep
                            ? activeColor
                            : (i < currentStep ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6)),
                        fontWeight: i == currentStep ? .bold : .w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
