import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening maps
import 'dart:math';

class OxygenDetailsScreen extends StatefulWidget {
  const OxygenDetailsScreen({super.key});

  @override
  State<OxygenDetailsScreen> createState() => _OxygenDetailsScreenState();
}

class _OxygenDetailsScreenState extends State<OxygenDetailsScreen> {
  Position? _currentPosition;
  List<OxygenSupplier> _nearbySuppliers = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Dummy data for oxygen suppliers (replace with your actual data source)
  final List<OxygenSupplier> _oxygenSuppliersData = [
    OxygenSupplier(
      name: 'City Oxygen Supplies',
      latitude: 12.9716,
      longitude: 77.5946,
      isAvailable: true,
    ),
    OxygenSupplier(
      name: 'MedPlus Pharmacy - Koramangala',
      latitude: 12.9352,
      longitude: 77.6245,
      isAvailable: true,
    ),
    OxygenSupplier(
      name: 'Global Healthcare Oxygen',
      latitude: 13.0203,
      longitude: 77.5699,
      isAvailable: false,
    ),
    OxygenSupplier(
      name: 'Sai Oxygen Agency',
      latitude: 12.9000,
      longitude: 77.7000,
      isAvailable: true,
    ),
    // Add more oxygen supply centers with their details
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _nearbySuppliers.clear();
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Location services are disabled. Please enable them in your device settings.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Location permissions are denied. Please grant location access to use this feature.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Location permissions are permanently denied. Please enable them in the app settings.';
      });
      return;
    }

    try {
      _currentPosition = await Geolocator.getCurrentPosition();
      await _findNearbyOxygenSuppliers();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to get current location: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _findNearbyOxygenSuppliers() async {
    if (_currentPosition == null) {
      return;
    }

    List<OxygenSupplier> nearby = [];
    for (final supplier in _oxygenSuppliersData) {
      final distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        supplier.latitude,
        supplier.longitude,
      );

      // You can adjust this threshold to define "nearby" (e.g., 10km = 10000 meters)
      if (distanceInMeters <= 10000) {
        nearby.add(supplier.copyWith(distance: distanceInMeters));
      }
    }

    nearby.sort((a, b) => a.distance!.compareTo(b.distance!));

    setState(() {
      _nearbySuppliers = nearby;
    });
  }

  String _formatDistance(double? distance) {
    if (distance == null) {
      return 'Distance unavailable';
    }
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} meters';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Oxygen Suppliers'),
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_errorMessage != null) {
            return Center(child: Text(_errorMessage!));
          }

          if (_nearbySuppliers.isEmpty) {
            return const Center(child: Text('No nearby oxygen suppliers found.'));
          }

          return ListView.builder(
            itemCount: _nearbySuppliers.length,
            itemBuilder: (context, index) {
              final supplier = _nearbySuppliers[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplier.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('Distance: ${_formatDistance(supplier.distance)}'),
                      const SizedBox(height: 8),
                      Text(
                        'Availability: ${supplier.isAvailable ? 'Available' : 'Not Available'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: supplier.isAvailable
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          _openMap(supplier.latitude, supplier.longitude);
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('View on Map'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openMap(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open map.')),
      );
    }
  }
}

class OxygenSupplier {
  final String name;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  double? distance;

  OxygenSupplier({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    this.distance,
  });

  OxygenSupplier copyWith({double? distance}) {
    return OxygenSupplier(
      name: name,
      latitude: latitude,
      longitude: longitude,
      isAvailable: isAvailable,
      distance: distance ?? this.distance,
    );
  }
}
