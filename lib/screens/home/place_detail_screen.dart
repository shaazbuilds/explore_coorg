import 'package:explore_coorg/providers/favourites_provider.dart';
import 'package:explore_coorg/screens/home/explore_screen.dart';
import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailScreen extends StatefulWidget {
  final TouristPlace place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  // ── Extended data per place ───────────────────────────
  // In a real app, this would come from your data layer / API
  static const Map<String, Map<String, dynamic>> _placeDetails = {
    "Abbey Falls": {
      "rating": 4.8,
      "duration": "30 min",
      "temp": "22°C",
      "entryFee": "₹15.00",
      "isTopRated": true,
      "fullLocation": "Madikeri, Coorg, Karnataka",
      "about":
          "Tucked away amidst the lush coffee plantations and spice estates of Coorg, Abbey Falls is a spectacular sight where the Kaveri River cascades down from a height of 70 feet. The roar of the water can be heard from the main road, leading you through a private aromatic plantation to a hanging bridge that offers the best vantage point.",
      "activities": [
        {"label": "Hiking", "icon": Icons.hiking_rounded},
        {"label": "Photography", "icon": Icons.camera_alt_rounded},
        {"label": "Sightseeing", "icon": Icons.park_rounded},
      ],
      "bestTime":
          "July to October (Monsoon season) is the peak experience when the water flow is at its mightiest.",
      "mapLabel": "Abbey Falls, Madikeri",
      "lat": 12.4244,
      "lng": 75.7382,
    },
    "Nagarhole National Park": {
      "rating": 4.7,
      "duration": "3–4 hrs",
      "temp": "24°C",
      "entryFee": "₹200.00",
      "isTopRated": true,
      "fullLocation": "Virajpet, Coorg, Karnataka",
      "about":
          "Nagarhole National Park, also known as Rajiv Gandhi National Park, is one of the finest wildlife sanctuaries in India. Spread over 643 sq km, it is home to Bengal tigers, Indian elephants, leopards, and over 270 species of birds. The park is part of the Nilgiri Biosphere Reserve — a UNESCO World Heritage Site.",
      "activities": [
        {"label": "Safari", "icon": Icons.directions_car_rounded},
        {"label": "Birdwatching", "icon": Icons.visibility_rounded},
        {"label": "Photography", "icon": Icons.camera_alt_rounded},
      ],
      "bestTime":
          "October to May is ideal. Avoid monsoon season as roads can be inaccessible.",
      "mapLabel": "Nagarhole National Park",
      "lat": 12.0490,
      "lng": 76.1060,
    },
    "Raja's Seat": {
      "rating": 4.5,
      "duration": "1 hr",
      "temp": "18°C",
      "entryFee": "₹10.00",
      "isTopRated": false,
      "fullLocation": "Madikeri, Coorg, Karnataka",
      "about":
          "Raja's Seat — 'The Seat of the King' — is a scenic garden and viewpoint perched at the edge of the hills in Madikeri. Legend holds that the kings of Coorg would sit here to watch the sunset over the lush valley below. The gardens are beautifully maintained with toy trains, fountains, and flower beds.",
      "activities": [
        {"label": "Sunset View", "icon": Icons.wb_twilight_rounded},
        {"label": "Photography", "icon": Icons.camera_alt_rounded},
        {"label": "Gardens", "icon": Icons.local_florist_rounded},
      ],
      "bestTime":
          "October to March offers clear skies and cool weather, perfect for sunset views.",
      "mapLabel": "Raja's Seat, Madikeri",
      "lat": 12.4218,
      "lng": 75.7382,
    },
  };

  Map<String, dynamic> get _details {
    return _placeDetails[widget.place.name] ??
        {
          "rating": 4.5,
          "duration": "1–2 hrs",
          "temp": "20°C",
          "entryFee": "Free",
          "isTopRated": false,
          "fullLocation": "${widget.place.location}, Coorg, Karnataka",
          "about":
              "A beautiful destination in the heart of Coorg, Karnataka — offering a unique mix of natural beauty, cultural heritage, and adventure experiences that make every visit unforgettable.",
          "activities": [
            {"label": "Sightseeing", "icon": Icons.park_rounded},
            {"label": "Photography", "icon": Icons.camera_alt_rounded},
            {"label": "Exploring", "icon": Icons.explore_rounded},
          ],
          "bestTime":
              "October to May offers the most pleasant weather for visiting Coorg.",
          "mapLabel": "${widget.place.name}, Coorg",
          "lat": 12.4244,
          "lng": 75.7382,
        };
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openDirections() async {
    final lat = _details["lat"] as double;
    final lng = _details["lng"] as double;
    final name = Uri.encodeComponent(widget.place.name);
    final url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=$name",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Read favourite state from provider ─────────────────
    final notifier = FavouritesProvider.of(context);
    final isFavourite = notifier.isFavourite(widget.place);

    final Color bg = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.cardDark : Colors.white;
    final Color textPri = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSec = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color divider = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    // Header opacity based on scroll
    final double headerOpacity = (_scrollOffset / 200).clamp(0.0, 1.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: bg,
        body: Stack(
          children: [
            // ── Scrollable body ─────────────────────────────
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // ── Hero image + title ─────────────────────
                SliverToBoxAdapter(
                  child: _HeroSection(
                    place: widget.place,
                    details: _details,
                    isFavourite: isFavourite,
                    isDark: isDark,
                    onFavouriteTap: () => notifier.toggle(widget.place),
                  ),
                ),

                // ── Stats row ──────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: divider),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.07),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: Row(
                        children: [
                          _StatItem(
                            icon: Icons.star_rounded,
                            iconColor: const Color(0xFFFFC107),
                            value: "${_details["rating"]}",
                            label: "RATING",
                            isDark: isDark,
                          ),
                          _Divider(isDark: isDark),
                          _StatItem(
                            icon: Icons.schedule_rounded,
                            iconColor: AppColors.primaryLight,
                            value: _details["duration"] as String,
                            label: "DURATION",
                            isDark: isDark,
                          ),
                          _Divider(isDark: isDark),
                          _StatItem(
                            icon: Icons.thermostat_rounded,
                            iconColor: const Color(0xFF1565C0),
                            value: _details["temp"] as String,
                            label: "TEMP",
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── About section ──────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(
                          title:
                              "About the ${widget.place.category == "Waterfalls"
                                  ? "Falls"
                                  : widget.place.category == "Temples"
                                  ? "Temple"
                                  : "Place"}",
                          textPri: textPri,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _details["about"] as String,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: textSec,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Activities ─────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(title: "Activities", textPri: textPri),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            for (final activity
                                in (_details["activities"] as List))
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: divider),
                                    boxShadow: isDark
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.06),
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        activity["icon"] as IconData,
                                        color: isDark
                                            ? AppColors.primaryBright
                                            : AppColors.primary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        activity["label"] as String,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: textSec,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            // Padding for last item (no right margin)
                            const SizedBox(width: 0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Best time to visit ─────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.cardLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? AppColors.dividerDark
                              : AppColors.dividerLight,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primary.withOpacity(0.3)
                                  : AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: isDark
                                  ? AppColors.primaryBright
                                  : AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Best Time to Visit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: textPri,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _details["bestTime"] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: textSec,
                                    height: 1.55,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Location section ───────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionTitle(title: "Location", textPri: textPri),
                            GestureDetector(
                              onTap: _openDirections,
                              child: Text(
                                "OPEN FULL MAP",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.primaryBright
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Static map placeholder
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Stack(
                            children: [
                              // Map image (static placeholder using OpenStreetMap tile)
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.cardDark
                                      : const Color(0xFFD4E9D4),
                                ),
                                child: Image.network(
                                  "https://staticmap.openstreetmap.de/staticmap.php?center=${_details["lat"]},${_details["lng"]}&zoom=13&size=400x180&markers=${_details["lat"]},${_details["lng"]},red",
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: isDark
                                        ? AppColors.surfaceDark
                                        : const Color(0xFFD4E9D4),
                                    child: Center(
                                      child: Icon(
                                        Icons.map_outlined,
                                        size: 52,
                                        color: AppColors.primaryLight
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Map pin
                              const Positioned.fill(
                                child: Center(
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.accent,
                                    size: 40,
                                  ),
                                ),
                              ),
                              // Destination label
                              Positioned(
                                bottom: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.93),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "DESTINATION",
                                        style: TextStyle(
                                          fontSize: 9,
                                          letterSpacing: 1.2,
                                          color: Colors.black.withOpacity(0.45),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _details["mapLabel"] as String,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1B2E1B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Bottom padding ─────────────────────────
                const SliverToBoxAdapter(child: SizedBox(height: 110)),
              ],
            ),

            // ── Floating app bar ────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.backgroundDark.withOpacity(headerOpacity)
                      : Colors.white.withOpacity(headerOpacity),
                  boxShadow: headerOpacity > 0.5
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.06 * headerOpacity,
                            ),
                            blurRadius: 8,
                          ),
                        ]
                      : [],
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Back button
                        _CircleButton(
                          icon: Icons.arrow_back_rounded,
                          isDark: isDark,
                          scrolled: headerOpacity > 0.5,
                          onTap: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        // Share
                        _CircleButton(
                          icon: Icons.ios_share_rounded,
                          isDark: isDark,
                          scrolled: headerOpacity > 0.5,
                          onTap: () {},
                        ),
                        const SizedBox(width: 10),
                        // Favourite
                        _CircleButton(
                          icon: isFavourite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          isDark: isDark,
                          scrolled: headerOpacity > 0.5,
                          iconColor: isFavourite ? Colors.redAccent : null,
                          onTap: () => notifier.toggle(widget.place),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom bar: entry fee + directions ──────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  14,
                  20,
                  MediaQuery.of(context).padding.bottom + 14,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.07),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "ENTRY FEE",
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.2,
                            color: textSec,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _details["entryFee"] as String,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: textPri,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: _openDirections,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.4),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Get Directions",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero section ──────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final TouristPlace place;
  final Map<String, dynamic> details;
  final bool isFavourite;
  final bool isDark;
  final VoidCallback onFavouriteTap;

  const _HeroSection({
    required this.place,
    required this.details,
    required this.isFavourite,
    required this.isDark,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          Image.asset(
            place.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              child: Center(
                child: Text(place.emoji, style: const TextStyle(fontSize: 80)),
              ),
            ),
          ),

          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0x88000000),
                  Color(0xDD000000),
                ],
                stops: [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          // Title & location at bottom
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top rated badge
                if (details["isTopRated"] == true)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "TOP RATED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                // Place name
                Text(
                  place.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white70,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      details["fullLocation"] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat item ─────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final bool isDark;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color textPri = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSec = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: textPri,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textSec,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}

// ── Section title ─────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color textPri;
  const _SectionTitle({required this.title, required this.textPri});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: textPri,
        letterSpacing: -0.3,
      ),
    );
  }
}

// ── Floating circle button ────────────────────────────────
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final bool scrolled;
  final Color? iconColor;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.isDark,
    required this.scrolled,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool useDark = scrolled ? isDark : true; // always dark style on hero
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: useDark
              ? Colors.black.withOpacity(0.4)
              : Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color:
              iconColor ??
              (useDark ? Colors.white : AppColors.textPrimaryLight),
        ),
      ),
    );
  }
}
