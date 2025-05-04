import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

class OxygenServicesIcon extends StatefulWidget {
  const OxygenServicesIcon({super.key});

  @override
  State<OxygenServicesIcon> createState() => _OxygenServicesIconState();
}

class _OxygenServicesIconState extends State<OxygenServicesIcon> {
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
      if (_nearbySuppliers.isNotEmpty || _errorMessage != null) {
        _navigateToDetailsScreen(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to get current location: $e';
      });
      _navigateToDetailsScreen(context);
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

  void _navigateToDetailsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OxygenDetailsScreen(
          suppliers: _nearbySuppliers,
          errorMessage: _errorMessage,
          isLoading: _isLoading,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.air),
      tooltip: 'Check Nearby Oxygen Services',
      onPressed: _getCurrentLocation,
    );
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

class OxygenDetailsScreen extends StatelessWidget {
  final List<OxygenSupplier> suppliers;
  final String? errorMessage;
  final bool isLoading;

  const OxygenDetailsScreen({
    super.key,
    required this.suppliers,
    this.errorMessage,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Oxygen Suppliers'),
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (errorMessage != null) {
            return Center(child: Text(errorMessage!));
          }

          if (suppliers.isEmpty) {
            return const Center(child: Text('No nearby oxygen suppliers found.'));
          }

          return ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
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
                          color: supplier.isAvailable ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final url =
                              'https://www.google.com/maps/search/?api=1&query=${supplier.latitude},${supplier.longitude}';
                          // Consider using url_launcher package for a more robust way to open maps
                          // For example:
                          // if (await canLaunchUrl(Uri.parse(url))) {
                          //   await launchUrl(Uri.parse(url));
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Could not open map.')),
                          //   );
                          // }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening map for ${supplier.name}'),
                            ),
                          );
                          // In a real app, use url_launcher to open the URL
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('View on Map'),
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
}
