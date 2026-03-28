import 'dart:math' as math;

import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final dynamic card;

  const BalanceCard({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            card.colorA as Color,
            card.colorB as Color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (card.colorB as Color).withValues(alpha: 0.24),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative top-right circle
          Positioned(
            right: -16,
            top: 6,
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // Decorative bottom-left shape
          Positioned(
            left: -38,
            bottom: -48,
            child: Transform.rotate(
              angle: -math.pi / 4.7,
              child: Container(
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),

          // Chip
          Positioned(
            right: 18,
            top: 16,
            child: _buildChip(),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 15, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${card.balance}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.7,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text(
                      '••••',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 24),
                    Text(
                      '8635',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                const Row(
                  children: [
                    _CardMetaBlock(
                      label: 'Valid From',
                      value: '10/25',
                    ),
                    SizedBox(width: 22),
                    _CardMetaBlock(
                      label: 'Valid Thru',
                      value: '10/30',
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: _CardMetaBlock(
                        label: 'Card Holder',
                        value: card.holder as String,
                        valueFontSize: 12.2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildMasterLogo(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip() {
    return Container(
      width: 27,
      height: 21,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCF54),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ChipPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterLogo() {
    return SizedBox(
      width: 31,
      height: 18,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8A39),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4D50),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardMetaBlock extends StatelessWidget {
  final String label;
  final String value;
  final double valueFontSize;

  const _CardMetaBlock({
    required this.label,
    required this.value,
    this.valueFontSize = 9.8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.52),
            fontSize: 7.3,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: valueFontSize,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2B63D)
      ..strokeWidth = 1.15
      ..style = PaintingStyle.stroke;

    final verticals = [
      size.width * 0.28,
      size.width * 0.50,
      size.width * 0.72,
    ];

    for (final x in verticals) {
      canvas.drawLine(
        Offset(x, 4),
        Offset(x, size.height - 4),
        paint,
      );
    }

    final horizontals = [
      size.height * 0.34,
      size.height * 0.66,
    ];

    for (final y in horizontals) {
      canvas.drawLine(
        Offset(4, y),
        Offset(size.width - 4, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
