import 'package:flutter/material.dart';

import '../widgets/action_tile.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/payment_tile.dart';
import '../widgets/service_tile.dart';

class FintechHomeScreen extends StatefulWidget {
  const FintechHomeScreen({super.key});

  @override
  State<FintechHomeScreen> createState() => _FintechHomeScreenState();
}

class _FintechHomeScreenState extends State<FintechHomeScreen>
    with TickerProviderStateMixin {
  late final PageController _cardController;
  late final AnimationController _introController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  int _activeCard = 0;
  int _activeTab = 2;

  final List<CardData> _cards = const [
    CardData(
      balance: '5,229.76',
      holder: 'Anna Kapustina',
      colorA: Color(0xFF4E73F8),
      colorB: Color(0xFF325CF4),
    ),
    CardData(
      balance: '8,745.21',
      holder: 'Mason Arthur',
      colorA: Color(0xFF57C6A8),
      colorB: Color(0xFF2BBE96),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cardController = PageController(viewportFraction: 0.86);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutCubic,
      ),
    );
    _introController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFCFD),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 18),
                        _buildCardsSection(),
                        const SizedBox(height: 16),
                        _buildQuickActions(),
                        const SizedBox(height: 18),
                        _buildServicesSection(),
                        const SizedBox(height: 20),
                        _buildScheduledPayments(),
                      ],
                    ),
                  ),
                ),
                DashboardBottomNavBar(
                  activeIndex: _activeTab,
                  onChanged: (index) {
                    setState(() {
                      _activeTab = index;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.pexels.com/photos/6476065/pexels-photo-6476065.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFD0B2), Color(0xFFE1A785)],
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 23,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFD0B2), Color(0xFFE1A785)],
                        ),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5F63),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        const Text(
          'Fintech',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF262932),
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF777E8B),
              ),
              Positioned(
                right: 12,
                top: 11,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6A6C),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: _cardController,
            itemCount: _cards.length,
            onPageChanged: (index) {
              setState(() {
                _activeCard = index;
              });
            },
            itemBuilder: (context, index) {
              final card = _cards[index];
              return AnimatedBuilder(
                animation: _cardController,
                builder: (context, child) {
                  double page = 0;
                  if (_cardController.hasClients &&
                      _cardController.position.hasContentDimensions) {
                    page = _cardController.page ?? _activeCard.toDouble();
                  } else {
                    page = _activeCard.toDouble();
                  }

                  final distance = (page - index).abs();
                  final scale = 1 - (distance * 0.08).clamp(0.0, 0.08);
                  final rotation = (distance * 0.05).clamp(0.0, 0.05);

                  return Transform.translate(
                    offset: Offset(index == _activeCard ? 0 : 6, 0),
                    child: Transform.scale(
                      scale: scale,
                      child: Transform.rotate(
                        angle: index < page ? -rotation : rotation,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: BalanceCard(card: card),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _cards.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: index == _activeCard ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: index == _activeCard
                    ? const Color(0xFF6584FF)
                    : const Color(0xFFD7DCE7),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2A2D37),
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 120,
                  child: ActionTile(
                    icon: Icons.send_rounded,
                    label: 'Money Transfer',
                    iconColor: Color(0xFF39CDA4),
                    iconBackground: Color(0xFFE8FBF4),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 120,
                  child: ActionTile(
                    icon: Icons.description_outlined,
                    label: 'Pay Bill',
                    iconColor: Color(0xFF6D8CFF),
                    iconBackground: Color(0xFFF3F6FF),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 120,
                  child: ActionTile(
                    icon: Icons.account_balance_outlined,
                    label: 'Bank to Bank',
                    iconColor: Color(0xFFB1B5C3),
                    iconBackground: Color(0xFFF7F7FA),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    final services = [
      const ServiceData(Icons.phone_android_outlined, 'Recharge', false),
      const ServiceData(Icons.volunteer_activism_outlined, 'Charity', false),
      const ServiceData(Icons.attach_money_rounded, 'Loan', false),
      const ServiceData(Icons.card_giftcard_rounded, 'Gifts', true),
      const ServiceData(Icons.health_and_safety_outlined, 'Insurance', false),
    ];

    const double spacing = 12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2A2D37),
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final double itemWidth = (constraints.maxWidth - (spacing * 3)) / 4;

            return SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: services.length,
                separatorBuilder: (_, __) => const SizedBox(width: spacing),
                itemBuilder: (context, index) {
                  final item = services[index];
                  return ServiceTile(
                    width: itemWidth,
                    icon: item.icon,
                    label: item.label,
                    active: item.active,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildScheduledPayments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Schedule Payments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2A2D37),
              ),
            ),
            const Spacer(),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFB4BAC6).withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const PaymentTile(
          logo: PaymentLogo.netflix,
          title: 'Netflix',
          date: '12/04',
          amount: '\$1.00',
        ),
        const SizedBox(height: 12),
        const PaymentTile(
          logo: PaymentLogo.paypal,
          title: 'Paypal',
          date: '14/04',
          amount: '\$3.50',
        ),
        const SizedBox(height: 12),
        const PaymentTile(
          logo: PaymentLogo.spotify,
          title: 'Spotify',
          date: '13/04',
          amount: '\$10.00',
        ),
      ],
    );
  }
}

class CardData {
  final String balance;
  final String holder;
  final Color colorA;
  final Color colorB;

  const CardData({
    required this.balance,
    required this.holder,
    required this.colorA,
    required this.colorB,
  });
}

class ServiceData {
  final IconData icon;
  final String label;
  final bool active;

  const ServiceData(this.icon, this.label, this.active);
}
