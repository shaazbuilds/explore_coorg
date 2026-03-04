import 'package:explore_coorg/screens/home/place_detail_screen.dart';
import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ── Data model ────────────────────────────────────────────
class TouristPlace {
  final String name;
  final String description;
  final String category;
  final String imagePath;
  final String location;
  final String emoji;

  const TouristPlace({
    required this.name,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.location,
    required this.emoji,
  });
}

// ── Sample data ───────────────────────────────────────────
const List<TouristPlace> allPlaces = [
  TouristPlace(
    name: "Abbey Falls",
    description:
        "A stunning 70ft waterfall surrounded by lush coffee and spice plantations.",
    category: "Waterfalls",
    imagePath: "assets/images/abbey_falls.jpg",
    location: "Madikeri",
    emoji: "💧",
  ),
  TouristPlace(
    name: "Iruppu Falls",
    description:
        "Sacred waterfall near Brahmagiri Wildlife Sanctuary, perfect for trekking.",
    category: "Waterfalls",
    imagePath: "assets/images/iruppu_falls.jpg",
    location: "Gonikoppal",
    emoji: "💧",
  ),
  TouristPlace(
    name: "Chelavara Falls",
    description:
        "A serene, lesser-known waterfall framed by dense mist and greenery.",
    category: "Waterfalls",
    imagePath: "assets/images/chelavara_falls.jpg",
    location: "Napoklu",
    emoji: "💧",
  ),
  TouristPlace(
    name: "Kote Abby Falls",
    description:
        "A serene, lesser-known 70-foot waterfall near Hattihole, Mukkodlu village, roughly 25 km from Madikeri, Coorg, offering a tranquil alternative to crowded tourist spots. Nestled in coffee plantations",
    category: "Waterfalls",
    imagePath: "assets/images/kotteabbyfalls.jpg",
    location: "Hattihole",
    emoji: "💧",
  ),

  TouristPlace(
    name: "Nagarhole National Park",
    description:
        "Home to tigers, elephants, and leopards in dense deciduous forests.",
    category: "Wildlife",
    imagePath: "assets/images/nagarhole.jpg",
    location: "Virajpet",
    emoji: "🐘",
  ),
  TouristPlace(
    name: "Kaveri Nisargadhama",
    description:
        "A tranquil river island eco-tourism spot in Coorg, Karnataka, known for its lush bamboo groves, sandalwood/teak trees, deer park, and activities like boat rides, nature walks, birds park, and a children's play",
    category: "Wildlife",
    imagePath: "assets/images/nisargadhama.jpg",
    location: "Kushalnagar",
    emoji: "🐘",
  ),
  TouristPlace(
    name: "Dubare Elephant Camp",
    description:
        "An unforgettable experience bathing and feeding elephants on the Cauvery riverbank.",
    category: "Wildlife",
    imagePath: "assets/images/dubare.jpg",
    location: "Kushalnagar",
    emoji: "🐘",
  ),

  TouristPlace(
    name: "Omkareshwara Temple",
    description:
        "A 200-year-old temple blending Islamic and Gothic architecture.",
    category: "Temples",
    imagePath: "assets/images/omkareshwara.jpg",
    location: "Madikeri",
    emoji: "🛕",
  ),
  TouristPlace(
    name: "Bhagamandala",
    description:
        "Sacred confluence of the Cauvery, Kannike, and Sujyothi rivers.",
    category: "Temples",
    imagePath: "assets/images/bhagamandala.jpg",
    location: "Bhagamandala",
    emoji: "🛕",
  ),
  TouristPlace(
    name: "Raja's Seat",
    description:
        "A breathtaking sunset viewpoint once used by Coorg kings for evening relaxation.",
    category: "Viewpoints",
    imagePath: "assets/images/rajas_seat.png",
    location: "Madikeri",
    emoji: "🌅",
  ),
  TouristPlace(
    name: "Mandalpatti",
    description:
        "Mist-wrapped hilltop offering sweeping views of the Western Ghats valleys.",
    category: "Viewpoints",
    imagePath: "assets/images/mandalpatti.jpg",
    location: "Madikeri",
    emoji: "🌅",
  ),
  TouristPlace(
    name: "Tadiandamol Peak",
    description:
        "The highest peak in Coorg at 1,748m with panoramic monsoon-season views.",
    category: "Trekking",
    imagePath: "assets/images/tadiandamol.jpg",
    location: "Kakkabe",
    emoji: "🥾",
  ),
  TouristPlace(
    name: "Kotte Betta Peak",
    description:
        "Coorg's third-highest peak features a moderate 10km trek through coffee estates and Shola forests. The summit hosts an ancient Shiva temple with panoramic views and mystical Pandava-era stone structures.",
    category: "Trekking",
    imagePath: "assets/images/kotebetta.jpg",
    location: "Madapura",
    emoji: "🥾",
  ),
  TouristPlace(
    name: "Brahmagiri Trek",
    description:
        "A moderately challenging trek through misty forests to a scenic hilltop.",
    category: "Trekking",
    imagePath: "assets/images/brahmagiri.jpg",
    location: "Virajpet",
    emoji: "🥾",
  ),
];

// ── Categories with icons ─────────────────────────────────
const List<Map<String, dynamic>> _categories = [
  {"label": "All", "icon": Icons.grid_view_rounded},
  {"label": "Waterfalls", "icon": Icons.water_rounded},
  {"label": "Wildlife", "icon": Icons.pets_rounded},
  {"label": "Temples", "icon": Icons.temple_hindu_rounded},
  {"label": "Viewpoints", "icon": Icons.panorama_rounded},
  {"label": "Trekking", "icon": Icons.hiking_rounded},
];

// ── Per-category accent colors (semantic, not brand) ──────
const Map<String, Color> _categoryAccents = {
  "All": AppColors.primary,
  "Waterfalls": Color(0xFF1565C0),
  "Wildlife": Color(0xFF6D4C41),
  "Temples": Color(0xFFE65100),
  "Viewpoints": Color(0xFF6A1B9A),
  "Trekking": AppColors.primaryLight,
};

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = "All";
  String _searchQuery = "";

  List<TouristPlace> get _filteredPlaces => allPlaces.where((p) {
    final matchCat =
        _selectedCategory == "All" || p.category == _selectedCategory;
    final matchSrch =
        p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p.location.toLowerCase().contains(_searchQuery.toLowerCase());
    return matchCat && matchSrch;
  }).toList();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bg = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color textPri = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSec = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.cardDark : Colors.white;
    final Color inputBg = isDark ? AppColors.cardDark : Colors.white;
    final Color divider = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    return Container(
      color: bg,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(
                          isDark ? 0.25 : 0.10,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryLight.withOpacity(0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: AppColors.primaryLight,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Kodagu, Karnataka",
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.primaryBright
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Title
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Discover\n",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: textPri,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: "Coorg's Wonders",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.primaryBright
                                  : AppColors.primary,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: inputBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: divider),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        style: TextStyle(fontSize: 14, color: textPri),
                        decoration: InputDecoration(
                          hintText: "Search places, landmarks...",
                          hintStyle: TextStyle(
                            color: textSec.withOpacity(0.6),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: AppColors.primaryLight,
                            size: 20,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () =>
                                      setState(() => _searchQuery = ""),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                    color: textSec,
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Category chips ────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final String label = cat["label"] as String;
                    final IconData icon = cat["icon"] as IconData;
                    final bool isSelected = label == _selectedCategory;
                    final Color accent =
                        _categoryAccents[label] ?? AppColors.primary;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = label),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? accent
                              : (isDark ? AppColors.cardDark : Colors.white),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? accent
                                : (isDark
                                      ? AppColors.dividerDark
                                      : AppColors.dividerLight),
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: accent.withOpacity(0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              size: 14,
                              color: isSelected ? Colors.white : textSec,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : textSec,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ── Section label + count ─────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _selectedCategory == "All"
                          ? "All Places"
                          : _selectedCategory,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textPri,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(
                          isDark ? 0.3 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${_filteredPlaces.length}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.primaryBright
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Empty state ───────────────────────────────────
            if (_filteredPlaces.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        const Text("🌿", style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          "No places found",
                          style: TextStyle(
                            color: textSec,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // ── Places list ───────────────────────────────────
            if (_filteredPlaces.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _PlaceCard(
                      place: _filteredPlaces[index],
                      cardBg: cardBg,
                      textPri: textPri,
                      textSec: textSec,
                      isDark: isDark,
                    ),
                    childCount: _filteredPlaces.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Place card ────────────────────────────────────────────
class _PlaceCard extends StatelessWidget {
  final TouristPlace place;
  final Color cardBg;
  final Color textPri;
  final Color textSec;
  final bool isDark;

  const _PlaceCard({
    required this.place,
    required this.cardBg,
    required this.textPri,
    required this.textSec,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = _categoryAccents[place.category] ?? AppColors.primary;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: isDark ? Border.all(color: AppColors.dividerDark) : null,
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    place.imagePath,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 190,
                      color: isDark ? AppColors.cardDark : AppColors.cardLight,
                      child: Center(
                        child: Text(
                          place.emoji,
                          style: const TextStyle(fontSize: 52),
                        ),
                      ),
                    ),
                  ),
                  // Gradient over image bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Category badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        place.category,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          place.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textPri,
                            letterSpacing: -0.3,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 13,
                            color: AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            place.location,
                            style: TextStyle(
                              fontSize: 12,
                              color: textSec,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Container(
                    width: 32,
                    height: 2,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    place.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: textSec,
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
