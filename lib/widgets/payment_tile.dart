import 'package:flutter/material.dart';

enum PaymentLogo { netflix, paypal, spotify }

class PaymentTile extends StatelessWidget {
  final PaymentLogo logo;
  final String title;
  final String date;
  final String amount;

  const PaymentTile({
    super.key,
    required this.logo,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildLogo(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E323B),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: 'Next Payment: ',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBBC0CC),
                    ),
                    children: [
                      TextSpan(
                        text: date,
                        style: const TextStyle(
                          color: Color(0xFF6D8CFF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: amount,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D313A),
                letterSpacing: -0.4,
              ),
              children: const [
                TextSpan(
                  text: ' USD',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB1B6C3),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    switch (logo) {
      case PaymentLogo.netflix:
        return _logoContainer(
          background: const Color(0xFF111111),
          child: const Text(
            'N',
            style: TextStyle(
              color: Color(0xFFE50914),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        );
      case PaymentLogo.paypal:
        return _logoContainer(
          background: const Color(0xFFF3F6FF),
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Positioned(
                left: 12,
                child: Text(
                  'P',
                  style: TextStyle(
                    color: Color(0xFF1F5AA8),
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                left: 18,
                child: Text(
                  'P',
                  style: TextStyle(
                    color: Color(0xFF179BD7),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        );
      case PaymentLogo.spotify:
        return _logoContainer(
          background: const Color(0xFF1ED760),
          child: const Icon(Icons.graphic_eq_rounded,
              color: Colors.white, size: 22),
        );
    }
  }

  Widget _logoContainer({required Color background, required Widget child}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: child),
    );
  }
}
