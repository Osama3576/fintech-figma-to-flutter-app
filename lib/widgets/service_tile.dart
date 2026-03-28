import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final double width;

  const ServiceTile({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Color tileColor =
        active ? const Color(0xFF456EFE) : const Color(0xFFF4F6FC);

    final Color iconColor = active ? Colors.white : const Color(0xFF4F73FF);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: width,
            height: 58,
            decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4F73FF).withValues(alpha: 0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 16,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7D8596),
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
