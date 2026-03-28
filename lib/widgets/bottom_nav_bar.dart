import 'package:flutter/material.dart';

class DashboardBottomNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onChanged;

  const DashboardBottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      Icons.home_rounded,
      Icons.location_on_outlined,
      Icons.bar_chart_rounded,
      Icons.equalizer_rounded,
      Icons.grid_view_rounded,
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final isActive = index == activeIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF4F73F8) : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4F73F8).withOpacity(0.28),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                items[index],
                color: isActive ? Colors.white : const Color(0xFFA3A9B6),
                size: isActive ? 22 : 20,
              ),
            ),
          );
        }),
      ),
    );
  }
}
