import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const PlantIQApp());

const kGreen = Color(0xFF247A4A);
const kGreen2 = Color(0xFF2F9360);
const kDeep = Color(0xFF123B28);
const kMint = Color(0xFFE7F4EA);
const kBg = Color(0xFFF6FAF7);
const kInk = Color(0xFF17382A);
const kMuted = Color(0xFF6A7D72);
const kLine = Color(0xFFDDE9E1);

class PlantIQApp extends StatelessWidget {
  const PlantIQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLANTIQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kBg,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen, brightness: Brightness.light),
        fontFamily: 'Arial',
      ),
      home: const PlantIQShell(),
    );
  }
}

class Plant {
  final String name;
  final String scientific;
  final String image;
  final int health;
  final String status;
  final String water;
  final String light;
  final String temp;
  final String next;
  final bool needsAttention;

  const Plant({
    required this.name,
    required this.scientific,
    required this.image,
    required this.health,
    required this.status,
    required this.water,
    required this.light,
    required this.temp,
    required this.next,
    this.needsAttention = false,
  });
}

const plants = <Plant>[
  Plant(
    name: 'Monstera Deliciosa',
    scientific: 'Monstera',
    image: 'assets/images/monstera.png',
    health: 86,
    status: 'Healthy',
    water: 'in 2 days',
    light: '4.2 hrs',
    temp: '26°C',
    next: 'Water in 2 days',
  ),
  Plant(
    name: 'Snake Plant',
    scientific: 'Sansevieria trifasciata',
    image: 'assets/images/snake_plant.png',
    health: 92,
    status: 'Healthy',
    water: 'in 5 days',
    light: '3.5 hrs',
    temp: '24°C',
    next: 'Water in 5 days',
  ),
  Plant(
    name: 'Peace Lily',
    scientific: 'Spathiphyllum',
    image: 'assets/images/peace_lily.png',
    health: 78,
    status: 'Needs Attention',
    water: 'in 1 day',
    light: '2.8 hrs',
    temp: '24°C',
    next: 'Check today',
    needsAttention: true,
  ),
  Plant(
    name: 'Spider Plant',
    scientific: 'Chlorophytum comosum',
    image: 'assets/images/spider_plant.png',
    health: 90,
    status: 'Healthy',
    water: 'in 4 days',
    light: '4.5 hrs',
    temp: '24°C',
    next: 'Water in 4 days',
  ),
  Plant(
    name: 'Pothos',
    scientific: 'Epipremnum aureum',
    image: 'assets/images/pothos.png',
    health: 88,
    status: 'Healthy',
    water: 'in 3 days',
    light: '3.8 hrs',
    temp: '25°C',
    next: 'Water in 3 days',
  ),
  Plant(
    name: 'Aloe Vera',
    scientific: 'Aloe barbadensis miller',
    image: 'assets/images/aloe_vera.png',
    health: 75,
    status: 'Good',
    water: 'in 7 days',
    light: '5.0 hrs',
    temp: '26°C',
    next: 'Water in 7 days',
  ),
];

class PlantService {
  Future<String> analyzeAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Analysis complete — 5 plants are healthy and 1 needs attention.';
  }

  Future<String> logWatering(Plant plant) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return '${plant.name} watering has been logged.';
  }
}

class PlantIQShell extends StatefulWidget {
  const PlantIQShell({super.key});

  @override
  State<PlantIQShell> createState() => _PlantIQShellState();
}

class _PlantIQShellState extends State<PlantIQShell> {
  int page = 0;

  void navigate(int value) => setState(() => page = value);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DashboardPage(onNavigate: navigate),
      PlantsPage(),
      ServicesPage(),
      AiDoctorPage(),
      StudioPage(),
      CalendarPage(),
      NotificationsPage(),
      ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: Row(
        children: [
          Sidebar(selected: page, onSelected: navigate),
          Expanded(
            child: Column(
              children: [
                TopBar(onSearch: (_) {}),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: pages[page],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelected;
  const Sidebar({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: kLine)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(color: kMint, borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.eco_rounded, color: kGreen, size: 28),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PLANTIQ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kInk)),
                    Text('Smart Plant Care', style: TextStyle(fontSize: 10, color: kMuted)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ...[
            (0, Icons.home_rounded, 'Home'),
            (1, Icons.eco_outlined, 'My Plants'),
            (2, Icons.volunteer_activism_outlined, 'Care Services'),
            (3, Icons.psychology_outlined, 'AI Plant Doctor'),
            (4, Icons.photo_library_outlined, 'Plant Gallery'),
            (5, Icons.calendar_month_outlined, 'Care Calendar'),
            (6, Icons.notifications_none_rounded, 'Notifications'),
            (7, Icons.person_outline_rounded, 'Profile'),
          ].map((item) {
            final active = selected == item.$1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => onSelected(item.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFFDDF1E3) : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(item.$2, size: 22, color: active ? kGreen : kInk),
                      const SizedBox(width: 13),
                      Text(item.$3, style: TextStyle(color: active ? kGreen : kInk, fontWeight: active ? FontWeight.w800 : FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kMint,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.spa_outlined, color: kGreen),
                SizedBox(width: 10),
                Expanded(child: Text('Healthier plants\nHappier spaces', style: TextStyle(color: kGreen, fontSize: 12, height: 1.4))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final ValueChanged<String> onSearch;
  const TopBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      color: kBg,
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        children: [
          SizedBox(
            width: 470,
            height: 44,
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: 'Search plants...',
                prefixIcon: const Icon(Icons.search, color: kInk),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: const BorderSide(color: kLine)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: const BorderSide(color: kLine)),
              ),
            ),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.wb_sunny_outlined, color: kInk)),
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, color: kInk)),
              Positioned(right: 9, top: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
            ],
          ),
          const SizedBox(width: 12),
          Container(width: 1, height: 35, color: kLine),
          const SizedBox(width: 18),
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/images/profile.png'),
            backgroundColor: kMint,
          ),
          const SizedBox(width: 10),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, Sreya', style: TextStyle(fontWeight: FontWeight.w800, color: kInk)),
              Text('Plant Parent', style: TextStyle(fontSize: 11, color: kMuted)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final ValueChanged<int> onNavigate;
  const DashboardPage({super.key, required this.onNavigate});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String filter = 'All';
  String query = '';
  bool analyzing = false;

  List<Plant> get visiblePlants {
    var list = plants.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    if (filter == 'Healthy') list = list.where((p) => p.health >= 85).toList();
    if (filter == 'Needs Attention') list = list.where((p) => p.needsAttention).toList();
    if (filter == 'Water Due') list = list.where((p) => p.water.contains('1 day')).toList();
    if (filter == 'Fertilizer Due') list = list.where((p) => p.name == 'Aloe Vera').toList();
    return list;
  }

  Future<void> analyze() async {
    setState(() => analyzing = true);
    final result = await PlantService().analyzeAll();
    if (!mounted) return;
    setState(() => analyzing = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 1250;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 2, 22, 26),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: compact ? 10 : 13,
                    child: Column(
                      children: [
                        const HeroBanner(),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Text('Your Plants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: kInk)),
                            const Spacer(),
                            FilledButton.icon(
                              onPressed: () => showAddPlantDialog(context),
                              icon: const Icon(Icons.add, size: 19),
                              label: const Text('Add Plant'),
                              style: FilledButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: ['All', 'Healthy', 'Needs Attention', 'Water Due', 'Fertilizer Due'].map((f) {
                              final active = filter == f;
                              return ChoiceChip(
                                label: Text(f),
                                selected: active,
                                onSelected: (_) => setState(() => filter = f),
                                selectedColor: kGreen,
                                labelStyle: TextStyle(color: active ? Colors.white : kInk, fontWeight: FontWeight.w600),
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: kLine),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 14),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: visiblePlants.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: compact ? 2 : 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: compact ? 0.93 : 0.84,
                          ),
                          itemBuilder: (_, i) => PlantCard(plant: visiblePlants[i]),
                        ),
                      ],
                    ),
                  ),
                  if (!compact) ...[
                    const SizedBox(width: 18),
                    SizedBox(
                      width: 310,
                      child: Column(
                        children: [
                          HealthOverview(),
                          const SizedBox(height: 14),
                          AiWidget(analyzing: analyzing, onAnalyze: analyze),
                          const SizedBox(height: 14),
                          TasksWidget(),
                          const SizedBox(height: 14),
                          StudioWidget(onOpen: () => widget.onNavigate(4)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 166,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: [Color(0xFFD9F1DF), Color(0xFFEAF6EC)]),
        image: const DecorationImage(image: AssetImage('assets/images/banner.png'), alignment: Alignment.centerRight, fit: BoxFit.cover, opacity: .92),
      ),
      padding: const EdgeInsets.fromLTRB(30, 25, 300, 20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🍃  GOOD MORNING, SREYA', style: TextStyle(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w800, color: kDeep)),
          SizedBox(height: 12),
          Text('Your Plant Collection', style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900, color: kDeep)),
          SizedBox(height: 9),
          Text('6 plants  •  3 needs attention  •  100% growth potential', style: TextStyle(color: kGreen, fontSize: 14)),
        ],
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;
  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19), side: const BorderSide(color: kLine)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F7F2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        plant.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(plant.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: kInk)),
                    const SizedBox(height: 3),
                    Text(plant.scientific, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: kMuted)),
                  ]),
                ),
                HealthRing(score: plant.health, size: 52),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                StatusPill(text: plant.status, warning: plant.needsAttention),
                const Spacer(),
                Icon(Icons.water_drop_outlined, size: 14, color: Colors.lightBlue.shade600),
                const SizedBox(width: 3),
                Text(plant.water, style: const TextStyle(fontSize: 9, color: kInk)),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                const Icon(Icons.wb_sunny_outlined, size: 14, color: kGreen),
                const SizedBox(width: 3),
                Text(plant.light, style: const TextStyle(fontSize: 9, color: kMuted)),
                const Spacer(),
                const Icon(Icons.thermostat_outlined, size: 14, color: kGreen),
                const SizedBox(width: 3),
                Text(plant.temp, style: const TextStyle(fontSize: 9, color: kMuted)),
              ],
            ),
            const SizedBox(height: 9),
            SizedBox(
              width: double.infinity,
              height: 33,
              child: FilledButton(
                onPressed: () => showPlantDetails(context, plant),
                style: FilledButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white),
                child: const Text('View Details  →', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthRing extends StatelessWidget {
  final int score;
  final double size;
  const HealthRing({super.key, required this.score, this.size = 92});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: RingPainter(score / 100),
        child: Center(
          child: Text('$score%', style: TextStyle(fontSize: size * .22, fontWeight: FontWeight.w900, color: kInk)),
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double value;
  RingPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 5;
    final base = Paint()..color = const Color(0xFFD8EBDD)..style = PaintingStyle.stroke..strokeWidth = 7;
    final progress = Paint()..color = kGreen..style = PaintingStyle.stroke..strokeWidth = 7..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, base);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, math.pi * 2 * value, false, progress);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) => oldDelegate.value != value;
}

class StatusPill extends StatelessWidget {
  final String text;
  final bool warning;
  const StatusPill({super.key, required this.text, this.warning = false});

  @override
  Widget build(BuildContext context) {
    final color = warning ? const Color(0xFFF2D23B) : kGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: warning ? kDeep : Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
    );
  }
}

class HealthOverview extends StatelessWidget {
  const HealthOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(icon: Icons.eco_rounded, title: 'Plant Health Overview'),
          const SizedBox(height: 16),
          Row(
            children: [
              const HealthRing(score: 85, size: 118),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DotLine(color: kGreen, text: 'Healthy', count: '4'),
                    SizedBox(height: 12),
                    DotLine(color: Color(0xFFE2B929), text: 'Needs Attention', count: '1'),
                    SizedBox(height: 12),
                    DotLine(color: Color(0xFF2B78D6), text: 'Water Due', count: '1'),
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

class DotLine extends StatelessWidget {
  final Color color;
  final String text;
  final String count;
  const DotLine({super.key, required this.color, required this.text, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: kInk))),
      Text(count, style: const TextStyle(fontWeight: FontWeight.w800, color: kInk)),
    ]);
  }
}

class AiWidget extends StatelessWidget {
  final bool analyzing;
  final VoidCallback onAnalyze;
  const AiWidget({super.key, required this.analyzing, required this.onAnalyze});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeader(icon: Icons.smart_toy_outlined, title: 'AI Plant Doctor'),
        const SizedBox(height: 8),
        const Text('Get personalized care advice for your plants using AI.', style: TextStyle(color: kMuted, height: 1.45, fontSize: 12)),
        const SizedBox(height: 13),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: analyzing ? null : onAnalyze,
            style: FilledButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white),
            child: Text(analyzing ? 'ANALYZING...' : 'Analyze All Plants  →'),
          ),
        ),
      ]),
    );
  }
}

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeader(icon: Icons.calendar_month_outlined, title: "Today's Tasks"),
        const SizedBox(height: 7),
        const Text('3 tasks • 2 completed', style: TextStyle(color: kMuted, fontSize: 11)),
        const SizedBox(height: 13),
        const TaskRow(done: true, title: 'Water Monstera', sub: 'Completed • 9:00 AM'),
        const SizedBox(height: 12),
        const TaskRow(done: false, title: 'Check Peace Lily', sub: 'Due in 3 hours'),
        const SizedBox(height: 12),
        const TaskRow(done: false, title: 'Fertilize Aloe Vera', sub: 'Due tomorrow'),
      ]),
    );
  }
}

class TaskRow extends StatelessWidget {
  final bool done;
  final String title;
  final String sub;
  const TaskRow({super.key, required this.done, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 24, height: 24,
        decoration: BoxDecoration(shape: BoxShape.circle, color: done ? kGreen : Colors.transparent, border: Border.all(color: done ? kGreen : const Color(0xFF9CC2AB), width: 1.5)),
        child: done ? const Icon(Icons.check, size: 15, color: Colors.white) : null,
      ),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kInk)),
        const SizedBox(height: 3),
        Text(sub, style: const TextStyle(fontSize: 10, color: kMuted)),
      ])),
    ]);
  }
}

class StudioWidget extends StatelessWidget {
  final VoidCallback onOpen;
  const StudioWidget({super.key, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onOpen,
      child: Container(
        height: 210,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF3B6D55), Color(0xFF143B29)]),
        ),
        child: Stack(
          children: [
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Explore', style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 5),
              Text('Plant Gallery', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
              SizedBox(height: 8),
              Text('Browse your plants and learn more about their care.', style: TextStyle(color: Color(0xFFD5E8DA), fontSize: 11, height: 1.4)),
              SizedBox(height: 12),
              Text('Open Gallery  →', style: TextStyle(color: kDeep, fontWeight: FontWeight.w800)),
            ]),
            Positioned(right: -15, bottom: -20, child: SizedBox(width: 150, height: 150, child: ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.asset('assets/images/monstera.png', fit: BoxFit.cover)))),
          ],
        ),
      ),
    );
  }
}

class WhiteCard extends StatelessWidget {
  final Widget child;
  const WhiteCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: kLine)),
    child: child,
  );
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 30, height: 30, decoration: BoxDecoration(color: kMint, borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: kGreen, size: 18)),
    const SizedBox(width: 9),
    Expanded(child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: kInk))),
  ]);
}

void showPlantDetails(BuildContext context, Plant plant) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: SizedBox(
        width: 900,
        height: 610,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFFF0F7F2), borderRadius: BorderRadius.circular(22)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(22), child: Image.asset(plant.image, fit: BoxFit.contain)),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Spacer(), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))]),
                  Text(plant.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: kInk)),
                  const SizedBox(height: 5),
                  Text(plant.scientific, style: const TextStyle(color: kMuted)),
                  const SizedBox(height: 16),
                  StatusPill(text: plant.status, warning: plant.needsAttention),
                  const SizedBox(height: 20),
                  HealthRing(score: plant.health, size: 130),
                  const SizedBox(height: 18),
                  Text('Care profile', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: kGreen)),
                  const SizedBox(height: 12),
                  CareLine(icon: Icons.water_drop_outlined, label: 'Watering', value: plant.water),
                  CareLine(icon: Icons.wb_sunny_outlined, label: 'Sunlight', value: plant.light),
                  CareLine(icon: Icons.thermostat_outlined, label: 'Temperature', value: plant.temp),
                  const Spacer(),
                  SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () async {
                    final message = await PlantService().logWatering(plant);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                    }
                  }, icon: const Icon(Icons.water_drop_outlined), label: const Text('Log watering'))),
                ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CareLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const CareLine({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(children: [
      Icon(icon, size: 18, color: kGreen),
      const SizedBox(width: 10),
      Expanded(child: Text(label, style: const TextStyle(color: kMuted))),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800, color: kInk)),
    ]),
  );
}

void showAddPlantDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Add New Plant'),
      content: const Text('Create a new care profile. This demo keeps the collection local so it can be demonstrated without a backend.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Create Profile')),
      ],
    ),
  );
}

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    eyebrow: 'Collection',
    title: 'My Plants',
    subtitle: 'Every plant in your collection with clear care information.',
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: .9),
      itemBuilder: (_, i) => PlantCard(plant: plants[i]),
    ),
  );
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      (Icons.water_drop_outlined, 'Smart Watering', 'Track moisture and get watering reminders.'),
      (Icons.wb_sunny_outlined, 'Light Check', 'Compare sunlight levels with each plant profile.'),
      (Icons.medical_services_outlined, 'Plant Health Scan', 'Run an AI-style health analysis before problems grow.'),
      (Icons.calendar_month_outlined, 'Care Scheduler', 'Plan watering, fertilizing and repotting tasks.'),
      (Icons.local_shipping_outlined, 'Care Delivery', 'Request soil, pots and plant nutrients.'),
      (Icons.support_agent_outlined, 'Expert Help', 'Prepare a plant-care question for consultation.'),
    ];
    return PageFrame(
      eyebrow: 'PLANTIQ ecosystem',
      title: 'Care Services',
      subtitle: 'Everything you need to keep your indoor garden thriving.',
      child: GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 3, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 1.7,
        children: data.map((s) => WhiteCard(child: Row(children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(color: kMint, borderRadius: BorderRadius.circular(17)), child: Icon(s.$1, color: kGreen, size: 27)),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(s.$2, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: kInk)),
            const SizedBox(height: 6),
            Text(s.$3, style: const TextStyle(color: kMuted, height: 1.35, fontSize: 12)),
          ])),
        ]))).toList(),
      ),
    );
  }
}

class AiDoctorPage extends StatefulWidget {
  const AiDoctorPage({super.key});
  @override State<AiDoctorPage> createState() => _AiDoctorPageState();
}
class _AiDoctorPageState extends State<AiDoctorPage> {
  bool running=false; String message='Ready to analyze your collection.';
  Future<void> runScan() async {
    setState(() { running=true; message='Reading moisture, light and temperature...'; });
    await Future.delayed(const Duration(seconds: 1));
    setState(() => message='Comparing each plant with its care profile...');
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() { running=false; message='Analysis complete. One plant needs attention today.'; });
  }
  @override Widget build(BuildContext context) => PageFrame(
    eyebrow:'Intelligence', title:'AI Plant Doctor', subtitle:'A guided plant-health workflow for your collection.',
    child: Column(children:[
      WhiteCard(child: Row(children:[
        Container(width:100,height:100,decoration:BoxDecoration(color:kMint,borderRadius:BorderRadius.circular(28)),child:const Icon(Icons.smart_toy_rounded,color:kGreen,size:48)),
        const SizedBox(width:22),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('PLANT HEALTH ANALYSIS',style:TextStyle(fontSize:11,letterSpacing:1.7,color:kGreen,fontWeight:FontWeight.w900)),
          const SizedBox(height:8), Text(message,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800,color:kInk)),
          const SizedBox(height:12), const Text('PLANTIQ combines your care data into a simple actionable recommendation.',style:TextStyle(color:kMuted)),
        ])),
        FilledButton(onPressed:running?null:runScan,child:Text(running?'ANALYZING...':'RUN AI ANALYSIS')),
      ])),
      const SizedBox(height:16),
      Row(children:[
        Expanded(child:WhiteCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const SectionHeader(icon:Icons.health_and_safety_outlined,title:'Collection score'),const SizedBox(height:20),const Center(child:HealthRing(score:85,size:180)),const SizedBox(height:10),const Center(child:Text('Overall plant health',style:TextStyle(color:kMuted)))]))),
        const SizedBox(width:16),
        Expanded(child:WhiteCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const SectionHeader(icon:Icons.insights_outlined,title:'Diagnosis'),
          const SizedBox(height:18),
          const CareLine(icon:Icons.water_drop_outlined,label:'Average moisture',value:'68%'),
          const CareLine(icon:Icons.wb_sunny_outlined,label:'Average sunlight',value:'74%'),
          const CareLine(icon:Icons.thermostat_outlined,label:'Average temperature',value:'25°C'),
          const CareLine(icon:Icons.warning_amber_outlined,label:'Attention needed',value:'1 plant'),
          const SizedBox(height:12),
          Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:kMint,borderRadius:BorderRadius.circular(15)),child:const Text('Recommendation: keep the Peace Lily closer to bright indirect light and check its soil today.',style:TextStyle(color:kInk,height:1.45,fontWeight:FontWeight.w600))),
        ]))),
      ])
    ]),
  );
}

class StudioPage extends StatefulWidget {
  const StudioPage({super.key});
  @override State<StudioPage> createState()=>_StudioPageState();
}
class _StudioPageState extends State<StudioPage> {
  int selected=0;
  @override Widget build(BuildContext context) {
    final p=plants[selected];
    return PageFrame(
      eyebrow:'Plant Gallery', title:'Plant Gallery', subtitle:'Browse your plants and learn more about their care.',
      child:Column(children:[
        WhiteCard(child:Row(children:[
          ...List.generate(plants.length,(i)=>Padding(padding:const EdgeInsets.only(right:8),child:ChoiceChip(label:Text(plants[i].name.split(' ').first),selected:selected==i,onSelected:(_)=>setState(()=>selected=i),selectedColor:kGreen,labelStyle:TextStyle(color:selected==i?Colors.white:kInk,fontSize:11)))),
        ])),
        const SizedBox(height:16),
        Container(height:550,width:double.infinity,decoration:BoxDecoration(color:const Color(0xFFF0F7F2),borderRadius:BorderRadius.circular(25),border:Border.all(color:kLine)),child:ClipRRect(borderRadius:BorderRadius.circular(25),child:Image.asset(p.image,fit:BoxFit.contain))),
        const SizedBox(height:12),
        Text('Plant image • ${p.name}',style:const TextStyle(color:kMuted)),
      ]),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override Widget build(BuildContext context)=>PageFrame(
    eyebrow:'Planning',title:'Care Calendar',subtitle:'Your next watering and maintenance schedule.',
    child:WhiteCard(child:Column(children:[
      ...plants.map((p)=>Padding(padding:const EdgeInsets.symmetric(vertical:10),child:Row(children:[
        Container(width:46,height:46,decoration:BoxDecoration(color:kMint,borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.eco_outlined,color:kGreen)),
        const SizedBox(width:14),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(p.name,style:const TextStyle(fontWeight:FontWeight.w800,color:kInk)),Text(p.next,style:const TextStyle(color:kMuted,fontSize:12))])),
        StatusPill(text:p.status,warning:p.needsAttention),
      ]))),
    ])),
  );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override Widget build(BuildContext context)=>PageFrame(
    eyebrow:'Updates',title:'Notifications',subtitle:'Recent plant-care activity.',
    child:Column(children:[
      ...['Monstera watering was logged','Peace Lily needs a soil check','Aloe Vera fertilizer is due tomorrow','Weekly plant health report is ready'].map((n)=>Padding(padding:const EdgeInsets.only(bottom:12),child:WhiteCard(child:Row(children:[const Icon(Icons.notifications_none_rounded,color:kGreen),const SizedBox(width:14),Expanded(child:Text(n,style:const TextStyle(fontWeight:FontWeight.w700,color:kInk))),const Icon(Icons.chevron_right_rounded,color:kMuted)])))),
    ]),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context)=>PageFrame(
    eyebrow:'Account',title:'Profile',subtitle:'Personalize your PLANTIQ experience.',
    child:Column(children:[
      WhiteCard(child:Row(children:[const CircleAvatar(radius:38,backgroundImage:AssetImage('assets/images/profile.png'),backgroundColor:kMint),const SizedBox(width:18),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Hello, Sreya',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900,color:kInk)),Text('Plant Parent • 6 active plants',style:TextStyle(color:kMuted))])),OutlinedButton(onPressed:(){},child:const Text('Edit Profile'))])),
      const SizedBox(height:14),
      WhiteCard(child:Column(children:const[
        SettingLine(icon:Icons.notifications_none,title:'Care reminders',value:'On'),
        Divider(height:28),SettingLine(icon:Icons.language_outlined,title:'Language',value:'English'),
        Divider(height:28),SettingLine(icon:Icons.cloud_outlined,title:'Data sync',value:'Local demo'),
        Divider(height:28),SettingLine(icon:Icons.security_outlined,title:'Privacy',value:'Protected'),
      ])),
    ]),
  );
}

class SettingLine extends StatelessWidget {
  final IconData icon; final String title; final String value;
  const SettingLine({super.key,required this.icon,required this.title,required this.value});
  @override Widget build(BuildContext context)=>Row(children:[Icon(icon,color:kGreen),const SizedBox(width:14),Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.w700,color:kInk))),Text(value,style:const TextStyle(color:kMuted))]);
}

class PageFrame extends StatelessWidget {
  final String eyebrow,title,subtitle; final Widget child;
  const PageFrame({super.key,required this.eyebrow,required this.title,required this.subtitle,required this.child});
  @override Widget build(BuildContext context)=>SingleChildScrollView(padding:const EdgeInsets.fromLTRB(34,22,34,34),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(eyebrow.toUpperCase(),style:const TextStyle(letterSpacing:2,color:kGreen,fontSize:11,fontWeight:FontWeight.w900)),
    const SizedBox(height:5),Text(title,style:const TextStyle(fontSize:32,fontWeight:FontWeight.w900,color:kInk)),
    const SizedBox(height:6),Text(subtitle,style:const TextStyle(color:kMuted)),
    const SizedBox(height:22),child,
  ]));
}
