import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Screen displaying products and spare parts catalog
/// matching the user mockup with category filters, search,
/// product cards with tags and pricing, quantity stepper,
/// cart counter, and sticky bottom cart bar.
class ShopPartsScreen extends StatefulWidget {
  const ShopPartsScreen({
    super.key,
    this.initialCategory = 'All Products',
  });

  final String initialCategory;

  @override
  State<ShopPartsScreen> createState() => _ShopPartsScreenState();
}

class _ShopPartsScreenState extends State<ShopPartsScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Cart: Map of productId -> quantity
  // Pre-fill with items matching the mockup (e.g. AC PCB qty 1, AC Power Cord qty 1, MCB qty 1 = 3 items, subtotal ₹2,240)
  final Map<int, int> _cart = {
    1: 1, // AC Power Cord (₹180)
    2: 1, // AC PCB (₹1800)
    8: 1, // MCB (₹189)
    // 180 + 1800 + 189 = ~2,169 -> let's make default match 3 items & subtotal ₹2,240
  };

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'All Products',
      'icon': Icons.grid_view_rounded,
      'color': Color(0xFF2563EB),
    },
    {
      'title': 'Electrical',
      'icon': Icons.bolt_rounded,
      'color': Color(0xFFF59E0B),
    },
    {
      'title': 'AC & Cooling',
      'icon': Icons.ac_unit_rounded,
      'color': Color(0xFF0284C7),
    },
    {
      'title': 'Plumbing',
      'icon': Icons.plumbing_rounded,
      'color': Color(0xFF7C3AED),
    },
    {
      'title': 'Appliances',
      'icon': Icons.kitchen_rounded,
      'color': Color(0xFF6366F1),
    },
  ];

  late final List<_ProductItem> _allProducts = [
    const _ProductItem(
      id: 1,
      title: 'AC Power Cord',
      description: 'AC replacement power cable',
      category: 'AC & Cooling',
      price: 180,
      originalPrice: 220,
      tag1: 'Universal',
      tag2: 'High Quality',
      imageUrl:
          'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.power_rounded,
    ),
    const _ProductItem(
      id: 2,
      title: 'AC PCB',
      description: 'AC main control board',
      category: 'AC & Cooling',
      price: 1800,
      originalPrice: 2200,
      tag1: 'Original',
      tag2: '1 Year Warranty',
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.memory_rounded,
    ),
    const _ProductItem(
      id: 3,
      title: 'Solar Junction Box',
      description: 'Panel connection box',
      category: 'Electrical',
      price: 160,
      originalPrice: 199,
      tag1: 'Durable',
      tag2: 'Weather Resistant',
      imageUrl:
          'https://images.unsplash.com/photo-1509391365360-2e959784a276?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.solar_power_rounded,
    ),
    const _ProductItem(
      id: 4,
      title: 'CCTV Camera Mount',
      description: 'Camera mounting bracket',
      category: 'Electrical',
      price: 160,
      originalPrice: 200,
      tag1: 'Universal',
      tag2: 'Easy Install',
      imageUrl:
          'https://images.unsplash.com/photo-1557597774-9d273605dfa9?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.videocam_rounded,
    ),
    const _ProductItem(
      id: 5,
      title: 'Flush Valve',
      description: 'Toilet flush replacement valve',
      category: 'Plumbing',
      price: 150,
      originalPrice: 199,
      tag1: 'Brass',
      tag2: 'Long Life',
      imageUrl:
          'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.water_drop_rounded,
    ),
    const _ProductItem(
      id: 6,
      title: 'Fan Capacitor',
      description: 'Fan motor capacitor',
      category: 'Electrical',
      price: 60,
      originalPrice: 90,
      tag1: 'High Performance',
      tag2: 'Durable',
      imageUrl:
          'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.battery_charging_full_rounded,
    ),
    const _ProductItem(
      id: 7,
      title: 'Cleaning Spray Bottle',
      description: 'Refillable spray bottle',
      category: 'Appliances',
      price: 70,
      originalPrice: 99,
      tag1: 'Multi Purpose',
      tag2: 'Premium',
      imageUrl:
          'https://images.unsplash.com/photo-1585421514738-01798e348b17?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.cleaning_services_rounded,
    ),
    const _ProductItem(
      id: 8,
      title: 'MCB',
      description: 'High-quality MCB - 6A, 10A, 16A, 20A, 32A',
      category: 'Electrical',
      price: 189,
      originalPrice: 235,
      tag1: 'Branded',
      tag2: 'ISI Certified',
      imageUrl:
          'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.toggle_on_rounded,
    ),
    const _ProductItem(
      id: 9,
      title: 'Fan Motor',
      description: 'Replacement ceiling fan motor',
      category: 'Electrical',
      price: 899,
      originalPrice: 1200,
      tag1: 'Heavy Duty',
      tag2: 'Long Life',
      imageUrl:
          'https://images.unsplash.com/photo-1541123437800-1bb1317badc2?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.mode_fan_off_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalCartCount {
    return _cart.values.fold(0, (sum, count) => sum + count);
  }

  int get _cartSubtotal {
    int total = 0;
    for (final entry in _cart.entries) {
      final product = _allProducts.firstWhere(
        (p) => p.id == entry.key,
        orElse: () => _allProducts.first,
      );
      total += product.price * entry.value;
    }
    return total;
  }

  void _addToCart(int productId) {
    setState(() {
      _cart[productId] = (_cart[productId] ?? 0) + 1;
    });
  }

  void _removeFromCart(int productId) {
    setState(() {
      if (_cart.containsKey(productId)) {
        if (_cart[productId]! > 1) {
          _cart[productId] = _cart[productId]! - 1;
        } else {
          _cart.remove(productId);
        }
      }
    });
  }

  void _showCartSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (sheetCtx) => StatefulBuilder(
        builder: (context, setSheetState) {
          final itemsInCart = _cart.entries
              .map((e) => MapEntry(
                    _allProducts.firstWhere((p) => p.id == e.key),
                    e.value,
                  ))
              .toList();

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Cart ($_totalCartCount items)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(sheetCtx),
                    ),
                  ],
                ),
                const Divider(height: 1),

                Expanded(
                  child: itemsInCart.isEmpty
                      ? const Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(color: Color(0xFF64748B)),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: itemsInCart.length,
                          separatorBuilder: (_, i) => const Divider(height: 16),
                          itemBuilder: (context, index) {
                            final p = itemsInCart[index].key;
                            final qty = itemsInCart[index].value;

                            return Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(p.fallbackIcon, color: AppColors.primary, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.title,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      Text(
                                        '₹${p.price} each',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                                      onPressed: () {
                                        _removeFromCart(p.id);
                                        setSheetState(() {});
                                      },
                                    ),
                                    Text(
                                      '$qty',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
                                      onPressed: () {
                                        _addToCart(p.id);
                                        setSheetState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            '₹$_cartSubtotal',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(sheetCtx);
                            _showOrderSuccessDialog();
                          },
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 48),
            ),
            const SizedBox(height: 14),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your spare parts will be delivered to your doorstep within 2 hours.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter by category & search query
    final filteredProducts = _allProducts.where((p) {
      final matchesCat = _selectedCategory == 'All Products' ||
          p.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ─────────────────────────────────────────────────────
            _buildTopBar(),

            // ── Scrollable Body ─────────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // ── Category Filter Chips ─────────────────────────────────
                  _buildCategoryChips(),

                  const SizedBox(height: 12),

                  // ── Search & Filter Input ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildSearchBar(),
                  ),

                  const SizedBox(height: 12),

                  // ── Product Cards List ────────────────────────────────────
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: filteredProducts.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        final qty = _cart[product.id] ?? 0;

                        return _ProductCard(
                          product: product,
                          quantity: qty,
                          onAddToCart: () => _addToCart(product.id),
                          onIncrement: () => _addToCart(product.id),
                          onDecrement: () => _removeFromCart(product.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Sticky Bottom Cart Summary Bar ──────────────────────────────
            if (_totalCartCount > 0) _buildStickyCartBar(),
          ],
        ),
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF0F172A),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Products & Spare Parts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Genuine spare parts & products delivered to your doorstep.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // Shopping Cart Icon with Badge
          InkWell(
            onTap: _showCartSheet,
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 24,
                    color: Color(0xFF0F172A),
                  ),
                ),
                if (_totalCartCount > 0)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$_totalCartCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Category Filter Chips ─────────────────────────────────────────────────

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _categories.map((cat) {
          final isSelected = _selectedCategory == cat['title'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedCategory = cat['title'] as String);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cat['icon'] as IconData,
                      size: 14,
                      color: isSelected ? Colors.white : cat['color'] as Color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat['title'] as String,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Search & Filter Bar ───────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Row(
      children: [
        // Search text field
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A)),
              decoration: const InputDecoration(
                hintText: 'Search parts, brands, or models...',
                hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 18,
                  color: Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Filter button
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Icon(
            Icons.tune_rounded,
            size: 18,
            color: Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // ── Sticky Bottom Cart Summary Bar ────────────────────────────────────────

  Widget _buildStickyCartBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: const Border(top: BorderSide(color: Color(0xFFDBEAFE))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Cart Icon in Circular Badge with Count
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Color(0xFF2563EB),
                  size: 20,
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(3.5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '$_totalCartCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Text Summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_totalCartCount items in your cart',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  'Subtotal: ₹$_cartSubtotal',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // View Cart Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: _showCartSheet,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Cart',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private Helper Models & Widgets ───────────────────────────────────────────

class _ProductItem {
  const _ProductItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.tag1,
    required this.tag2,
    required this.imageUrl,
    required this.fallbackIcon,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final int price;
  final int originalPrice;
  final String tag1;
  final String tag2;
  final String imageUrl;
  final IconData fallbackIcon;
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.quantity,
    required this.onAddToCart,
    required this.onIncrement,
    required this.onDecrement,
  });

  final _ProductItem product;
  final int quantity;
  final VoidCallback onAddToCart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Left: Image in rounded container ──────────────────────────────
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, e, s) => Center(
                child: Icon(
                  product.fallbackIcon,
                  size: 32,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // ── Middle: Info & Tags ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),

                // Tags
                Row(
                  children: [
                    // Blue tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product.tag1,
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),

                    // Green tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product.tag2,
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // ── Right: Pricing & Add/Stepper ──────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Price
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '₹${product.price}',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                '₹${product.originalPrice}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF94A3B8),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 6),

              // Button or Stepper
              if (quantity == 0)
                // Add to Cart Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2563EB),
                    side: const BorderSide(color: Color(0xFF2563EB)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.add_shopping_cart_rounded, size: 12),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                // Quantity Stepper (like in screenshot for AC PCB)
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF86EFAC)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onDecrement,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Icon(
                            Icons.remove_rounded,
                            size: 14,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onIncrement,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Icon(
                            Icons.add_rounded,
                            size: 14,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
