import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TownsScreen extends StatelessWidget {
  const TownsScreen({super.key});

  static const List<Map<String, dynamic>> _towns = [
    {
      "name": "Madikeri",
      "aka": "Mercara",
      "desc":
          "The capital of Kodagu — home to Raja's Seat, Omkareshwara Temple, and misty viewpoints.",
      "emoji": "🏛️",
    },
    {
      "name": "Virajpet",
      "aka": "Virarajendrapet",
      "desc":
          "Gateway to Nagarhole and Brahmagiri, rich in Kodava culture and wildlife trails.",
      "emoji": "🌳",
    },
    {
      "name": "Kushalnagar",
      "aka": "Little Tibet",
      "desc":
          "Home to the Tibetan settlement, golden temples, and Dubare Elephant Camp.",
      "emoji": "🏔️",
    },
    {
      "name": "Somwarpet",
      "aka": "Coffee Town",
      "desc":
          "Coorg's coffee heartland — rolling estates, misty mornings, and serene village life.",
      "emoji": "☕",
    },
    {
      "name": "Gonikoppal",
      "aka": "Spice Capital",
      "desc":
          "A quaint town surrounded by pepper and cardamom plantations near Iruppu Falls.",
      "emoji": "🌶️",
    },
    {
      "name": "Kakkabe",
      "aka": "Trekker's Base",
      "desc":
          "The base camp for Tadiandamol peak, nestled in deep forest and estate country.",
      "emoji": "🥾",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
    final Color iconBg = isDark ? AppColors.surfaceDark : AppColors.cardLight;
    final Color divider = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    return Container(
      color: bg,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Famous Towns",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: textPri,
                        letterSpacing: -1,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Explore Coorg's iconic towns & villages",
                      style: TextStyle(fontSize: 14, color: textSec),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final town = _towns[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: divider),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Emoji icon box
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: iconBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: divider),
                          ),
                          child: Center(
                            child: Text(
                              town["emoji"] as String,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    town["name"] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textPri,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "· ${town["aka"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.primaryBright
                                          : AppColors.primaryLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                town["desc"] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textSec,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: _towns.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
