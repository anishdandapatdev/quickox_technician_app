import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Screen displaying products and spare parts catalog
/// matching the user mockup with category filters, search bar,
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
  String _selectedCategory = 'All Products';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Initial cart: 3 items → subtotal ₹2,240 (matching mockup)
  final Map<int, int> _cart = {
    1: 1, // AC Power Cord ₹180
    2: 1, // AC PCB ₹1800
    3: 1, // Solar Junction Box ₹160 → total = 2140, + 100 extra = 2240
  };

  static const List<Map<String, dynamic>> _categories = [
    {'title': 'All Products', 'icon': Icons.grid_view_rounded, 'color': Color(0xFF2563EB)},
    {'title': 'Electrical', 'icon': Icons.bolt_rounded, 'color': Color(0xFFF59E0B)},
    {'title': 'AC & Cooling', 'icon': Icons.ac_unit_rounded, 'color': Color(0xFF0284C7)},
    {'title': 'Plumbing', 'icon': Icons.plumbing_rounded, 'color': Color(0xFF7C3AED)},
    {'title': 'Appliances', 'icon': Icons.kitchen_rounded, 'color': Color(0xFF6366F1)},
  ];

  static const List<_ProductItem> _allProducts = [
    _ProductItem(
      id: 1,
      title: 'AC Power Cord',
      description: 'AC replacement power cable',
      category: 'AC & Cooling',
      price: 180,
      originalPrice: 220,
      tag1: 'Universal',
      tag2: 'High Quality',
      assetPath: 'assets/images/products/ac_power_cord.jpg',
      fallbackIcon: Icons.power_rounded,
    ),
    _ProductItem(
      id: 2,
      title: 'AC PCB',
      description: 'AC main control board',
      category: 'AC & Cooling',
      price: 1800,
      originalPrice: 2200,
      tag1: 'Original',
      tag2: '1 Year Warranty',
      assetPath: 'assets/images/products/ac_pcb.jpg',
      fallbackIcon: Icons.memory_rounded,
    ),
    _ProductItem(
      id: 3,
      title: 'Solar Junction Box',
      description: 'Panel connection box',
      category: 'Electrical',
      price: 160,
      originalPrice: 199,
      tag1: 'Durable',
      tag2: 'Weather Resistant',
      assetPath: 'assets/images/products/solar_junction_box.jpg',
      fallbackIcon: Icons.solar_power_rounded,
    ),
    _ProductItem(
      id: 4,
      title: 'CCTV Camera Mount',
      description: 'Camera mounting bracket',
      category: 'Electrical',
      price: 160,
      originalPrice: 200,
      tag1: 'Universal',
      tag2: 'Easy Install',
      assetPath: 'assets/images/products/cctv_camera_mount.jpg',
      fallbackIcon: Icons.videocam_rounded,
    ),
    _ProductItem(
      id: 5,
      title: 'Flush Valve',
      description: 'Toilet flush replacement valve',
      category: 'Plumbing',
      price: 150,
      originalPrice: 199,
      tag1: 'Brass',
      tag2: 'Long Life',
      assetPath: 'assets/images/products/flush_valve.jpg',
      fallbackIcon: Icons.water_drop_rounded,
    ),
    _ProductItem(
      id: 6,
      title: 'Fan Capacitor',
      description: 'Fan motor capacitor',
      category: 'Electrical',
      price: 60,
      originalPrice: 90,
      tag1: 'High Performance',
      tag2: 'Durable',
      assetPath: 'assets/images/products/fan_capacitor.jpg',
      fallbackIcon: Icons.battery_charging_full_rounded,
    ),
    _ProductItem(
      id: 7,
      title: 'Cleaning Spray Bottle',
      description: 'Refillable spray bottle',
      category: 'Appliances',
      price: 70,
      originalPrice: 99,
      tag1: 'Multi Purpose',
      tag2: 'Premium',
      assetPath: 'assets/images/products/flush_valve.jpg',
      fallbackIcon: Icons.cleaning_services_rounded,
    ),
    _ProductItem(
      id: 8,
      title: 'MCB',
      description: 'High-quality MCB - 6A, 10A, 16A, 20A, 32A',
      category: 'Electrical',
      price: 189,
      originalPrice: 235,
      tag1: 'Branded',
      tag2: 'ISI Certified',
      assetPath: 'assets/images/products/ac_pcb.jpg',
      fallbackIcon: Icons.electrical_services_rounded,
    ),
    _ProductItem(
      id: 9,
      title: 'Fan Motor',
      description: 'Replacement ceiling fan motor',
      category: 'Appliances',
      price: 899,
      originalPrice: 1200,
      tag1: 'Heavy Duty',
      tag2: 'Long Life',
      assetPath: 'assets/images/products/fan_capacitor.jpg',
      fallbackIcon: Icons.wind_power_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory.isNotEmpty) {
      _selectedCategory = widget.initialCategory;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalCartCount => _cart.values.fold(0, (s, c) => s + c);

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

  void _addToCart(int productId) => setState(() {
        _cart[productId] = (_cart[productId] ?? 0) + 1;
      });

  void _removeFromCart(int productId) => setState(() {
        if (_cart.containsKey(productId)) {
          if (_cart[productId]! > 1) {
            _cart[productId] = _cart[productId]! - 1;
          } else {
            _cart.remove(productId);
          }
        }
      });

  // ── Cart bottom sheet ─────────────────────────────────────────────────────

  void _showCartSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final itemsInCart = _cart.entries
              .map((e) => MapEntry(
                    _allProducts.firstWhere((p) => p.id == e.key),
                    e.value,
                  ))
              .toList();

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.85,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),

                // Header
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
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                    p.assetPath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, e, s) => Icon(
                                      p.fallbackIcon,
                                      color: AppColors.primary,
                                      size: 26,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.title,
                                        style: const TextStyle(
                                          fontSize: 13,
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
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        _removeFromCart(p.id);
                                        setSheetState(() {});
                                      },
                                    ),
                                    Text(
                                      '$qty',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        size: 22,
                                        color: AppColors.primary,
                                      ),
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

                // Subtotal + Checkout
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
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(sheetCtx);
                            _showOrderSuccessDialog();
                          },
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 15,
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
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A34A),
                size: 48,
              ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _allProducts.where((p) {
      final matchesCat = _selectedCategory == 'All Products' ||
          p.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesQuery;
    }).toList();

    // Fallback: never show a blank screen
    final displayProducts =
        filteredProducts.isNotEmpty ? filteredProducts : _allProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // ── Category chips
          _buildCategoryChips(),
          const SizedBox(height: 10),
          // ── Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSearchBar(),
          ),
          const SizedBox(height: 10),
          // ── Product list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: displayProducts.length,
              separatorBuilder: (_, i) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final product = displayProducts[index];
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
      // Sticky cart bar at bottom
      bottomNavigationBar:
          _totalCartCount > 0 ? _buildStickyCartBar() : null,
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Color(0xFF0F172A),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Products & Spare Parts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Genuine spare parts & products delivered to your doorstep.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 24,
                color: Color(0xFF0F172A),
              ),
              onPressed: _showCartSheet,
            ),
            if (_totalCartCount > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
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
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Category chips ────────────────────────────────────────────────────────

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
              onTap: () =>
                  setState(() => _selectedCategory = cat['title'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2563EB)
                      : Colors.white,
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
                      color: isSelected
                          ? Colors.white
                          : cat['color'] as Color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat['title'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF1E293B),
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

  // ── Search bar ────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF0F172A),
              ),
              decoration: const InputDecoration(
                hintText: 'Search parts, brands, or models...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Icon(
            Icons.tune_rounded,
            size: 20,
            color: Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // ── Sticky cart bar ───────────────────────────────────────────────────────

  Widget _buildStickyCartBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          border: const Border(top: BorderSide(color: Color(0xFFDBEAFE))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Cart icon with badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
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
                  top: -3,
                  right: -3,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 16),
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

            // Summary text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$_totalCartCount items in your cart',
                    style: const TextStyle(
                      fontSize: 13,
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

            // View Cart button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
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
                      fontSize: 13,
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
      ),
    );
  }
}

// ── Data model ──────────────────────────────────────────────────────────────

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
    required this.assetPath,
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
  final String assetPath;
  final IconData fallbackIcon;
}

// ── Product Card ─────────────────────────────────────────────────────────────

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Product image ────────────────────────────────────────────────
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              product.assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, e, s) => Center(
                child: Icon(
                  product.fallbackIcon,
                  size: 34,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // ── Info & tags ──────────────────────────────────────────────────
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
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                // Tags row
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    _Tag(label: product.tag1, isBlue: true),
                    _Tag(label: product.tag2, isBlue: false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // ── Price & action ────────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${product.price}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '₹${product.originalPrice}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF94A3B8),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 8),
              if (quantity == 0)
                // Add to Cart button
                _AddToCartButton(onPressed: onAddToCart)
              else
                // Quantity stepper (green, matching mockup)
                _QuantityStepper(
                  quantity: quantity,
                  onDecrement: onDecrement,
                  onIncrement: onIncrement,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Tag chip ─────────────────────────────────────────────────────────────────

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.isBlue});

  final String label;
  final bool isBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: isBlue ? const Color(0xFFEFF6FF) : const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isBlue ? const Color(0xFF2563EB) : const Color(0xFF16A34A),
        ),
      ),
    );
  }
}

// ── Add to Cart button ────────────────────────────────────────────────────────

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF2563EB),
        side: const BorderSide(color: Color(0xFF2563EB)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        minimumSize: const Size(0, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.add_shopping_cart_rounded, size: 13),
      label: const Text(
        'Add to Cart',
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Quantity stepper ──────────────────────────────────────────────────────────

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDecrement,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Icon(
                Icons.remove_rounded,
                size: 14,
                color: Color(0xFF16A34A),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Icon(
                Icons.add_rounded,
                size: 14,
                color: Color(0xFF16A34A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
