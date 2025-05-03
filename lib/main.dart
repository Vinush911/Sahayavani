import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloodpage.dart';
import 'hospital.dart';
void main() {
  runApp(HelpApp());
}

class HelpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help App',
      debugShowCheckedModeBanner: false, // Remove debug banner for cleaner UI
      theme: ThemeData(
        primaryColor: const Color(0xFF1A365D), // Deep navy blue for a more formal look
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Slightly blue-tinted background
        fontFamily: GoogleFonts.poppins().fontFamily, // Switch to Poppins for a more formal font
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A365D),
            letterSpacing: -0.5,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A365D),
            letterSpacing: -0.3,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xFF334155), // Slate for better readability
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF64748B), // Lighter slate for secondary text
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1A365D),
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 2, // Lighter elevation for a more subtle effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Less rounded for a more formal look
          ),
          shadowColor: Colors.black.withOpacity(0.04),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A365D),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Less rounded for a more formal look
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 1, // Lower elevation for a more subtle look
            shadowColor: Colors.black.withOpacity(0.1),
          ),
        ),
        // Add divider theme for consistent dividers
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey.shade200,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A365D),
          primary: const Color(0xFF1A365D),
          secondary: const Color(0xFF2C5282), // Lighter blue for secondary elements
          tertiary: const Color(0xFF3182CE), // Even lighter blue for tertiary elements
          error: const Color(0xFFE53E3E), // Refined error color
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show app information dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About', style: Theme.of(context).textTheme.titleLarge),
                  content: Text(
                    'This application provides access to essential healthcare services and resources.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Introduction Section with more formal design
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1A365D),
                      const Color(0xFF2C5282),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Healthcare Resource Directory',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Access essential healthcare services and critical resources for medical assistance.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Action for emergency contact
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1A365D),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: const Text('Emergency Contact'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Section Title with decorative element
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Healthcare Services',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Services Grid with more formal styling
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.1, // Slightly wider than tall
                children: [
                  _buildServiceCard(
                    context,
                    title: 'Blood Banks',
                    description: 'Find blood donation centers',
                    iconData: Icons.bloodtype,
                    color: const Color(0xFFEF4444),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BloodBankListScreen()));
                    },
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Hospitals',
                    description: 'Locate nearby hospitals',
                    iconData: Icons.local_hospital,
                    color: const Color(0xFF3182CE),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalsListScreen()));
                    },
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Oxygen Supply',
                    description: 'Oxygen cylinder providers',
                    iconData: Icons.air,
                    color: const Color(0xFF10B981),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OxygenServicesScreen()));
                    },
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Ambulance',
                    description: 'Emergency transport',
                    iconData: Icons.emergency,
                    color: const Color(0xFFF59E0B),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceServicesScreen()));
                    },
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Helplines',
                    description: 'Essential contact numbers',
                    iconData: Icons.phone_in_talk,
                    color: const Color(0xFF8B5CF6),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelplineScreen()));
                    },
                  ),
                  _buildServiceCard(
                    context,
                    title: 'COVID Tests',
                    description: 'Testing centers & home kits',
                    iconData: Icons.science,
                    color: const Color(0xFF6366F1),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CovidTestScreen()));
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Additional resources section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional Resources',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildResourceItem(
                      context,
                      title: 'Ministry of Health',
                      subtitle: 'Official healthcare updates and guidelines',
                      iconData: Icons.public,
                    ),
                    _buildResourceItem(
                      context,
                      title: 'Health Insurance Information',
                      subtitle: 'Coverage details and policies',
                      iconData: Icons.health_and_safety,
                    ),
                    _buildResourceItem(
                      context,
                      title: 'Medical Education',
                      subtitle: 'Health awareness resources',
                      iconData: Icons.school,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, {
        required String title,
        required String description,
        required IconData iconData,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A365D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData iconData,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              iconData,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}



// Placeholder screens for other services with improved design


class OxygenServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oxygen Services')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.air,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
            const SizedBox(height: 24),
            Text(
              'Oxygen Supply Services',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Oxygen services data will be displayed here once available.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Find Oxygen Suppliers'),
            ),
          ],
        ),
      ),
    );
  }
}

class AmbulanceServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambulance Services')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emergency,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
            const SizedBox(height: 24),
            Text(
              'Emergency Transport',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Ambulance services data will be displayed here once available.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Contact Emergency Services'),
            ),
          ],
        ),
      ),
    );
  }
}

class HelplineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample helpline data - would come from API in a real app
    final List<Map<String, dynamic>> helplines = [
      {
        'name': 'National Emergency Number',
        'number': '112',
        'category': 'Emergency',
        'description': 'Unified emergency response service'
      },
      {
        'name': 'COVID-19 Helpline',
        'number': '1075',
        'category': 'Health',
        'description': 'National helpline for COVID-19 related assistance'
      },
      {
        'name': 'Women Helpline',
        'number': '1091',
        'category': 'Support',
        'description': 'National helpline for women in distress'
      },
      {
        'name': 'Child Helpline',
        'number': '1098',
        'category': 'Support',
        'description': 'National helpline for children in need of care and protection'
      },
      {
        'name': 'Mental Health Helpline',
        'number': '1800-599-0019',
        'category': 'Health',
        'description': 'National mental health rehabilitation helpline'
      },
      {
        'name': 'Senior Citizen Helpline',
        'number': '14567',
        'category': 'Support',
        'description': 'Elderly care services and assistance'
      },
    ];

    // Group helplines by category
    Map<String, List<Map<String, dynamic>>> groupedHelplines = {};
    for (var helpline in helplines) {
      final category = helpline['category'] as String;
      if (!groupedHelplines.containsKey(category)) {
        groupedHelplines[category] = [];
      }
      groupedHelplines[category]!.add(helpline);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpline Numbers'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Introduction banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency Contacts',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Important helpline numbers for various emergencies and support services.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // List of helplines grouped by category
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: groupedHelplines.entries.map((entry) {
                final category = entry.key;
                final categoryHelplines = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(category),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            category,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              color: const Color(0xFF1A365D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...categoryHelplines.map((helpline) => _buildHelplineCard(context, helpline)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Emergency':
        return const Color(0xFFEF4444);
      case 'Health':
        return const Color(0xFF10B981);
      case 'Support':
        return const Color(0xFF3182CE);
      default:
        return const Color(0xFF6366F1);
    }
  }

  Widget _buildHelplineCard(BuildContext context, Map<String, dynamic> helpline) {
    final Color categoryColor = _getCategoryColor(helpline['category']);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          final Uri phoneUri = Uri(scheme: 'tel', path: helpline['number']);
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: categoryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      helpline['name'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A365D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      helpline['description'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  helpline['number'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: categoryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CovidTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('COVID-19 Test Centers')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF4F46E5),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.2,
                      child: GridPattern(color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.science_outlined,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'COVID-19 Testing',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Information cards
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Testing Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  _buildInfoCard(
                    context,
                    title: 'Types of Tests',
                    content: 'Learn about RT-PCR, Rapid Antigen, and Antibody testing options available.',
                    icon: Icons.coronavirus_outlined,
                    color: const Color(0xFF6366F1),
                  ),

                  _buildInfoCard(
                    context,
                    title: 'When to Get Tested',
                    content: 'Guidelines on when you should consider getting tested for COVID-19.',
                    icon: Icons.event_note_outlined,
                    color: const Color(0xFF10B981),
                  ),

                  _buildInfoCard(
                    context,
                    title: 'Home Testing Kits',
                    content: 'Information about using self-testing kits properly and reporting results.',
                    icon: Icons.home_outlined,
                    color: const Color(0xFFF59E0B),
                  ),

                  const SizedBox(height: 24),

                  // Find test center section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Testing Centers',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Use your location to find the nearest COVID-19 testing facilities.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_outlined),
                            label: Text('Find Nearby Centers'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Guidelines section
                  Text(
                    'Testing Guidelines',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildGuidelineItem(
                    context,
                    number: '01',
                    title: 'Bring Identification',
                    description: 'Carry a valid ID proof and doctor\'s prescription if available.',
                  ),
                  _buildGuidelineItem(
                    context,
                    number: '02',
                    title: 'Wear a Mask',
                    description: 'Ensure you wear a proper face mask when visiting testing centers.',
                  ),
                  _buildGuidelineItem(
                    context,
                    number: '03',
                    title: 'Maintain Distance',
                    description: 'Follow social distancing guidelines at the testing facility.',
                  ),
                  _buildGuidelineItem(
                    context,
                    number: '04',
                    title: 'Post-Test Protocol',
                    description: 'Self-isolate until you receive your test results.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, {
        required String title,
        required String content,
        required IconData icon,
        required Color color,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A365D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        content,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(
      BuildContext context, {
        required String number,
        required String title,
        required String description,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A365D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom grid pattern for background
class GridPattern extends StatelessWidget {
  final Color color;

  const GridPattern({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(color: color),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    // Draw horizontal lines
    for (int i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), paint);
    }

    // Draw vertical lines
    for (int i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
