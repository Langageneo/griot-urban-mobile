import 'package:flutter/material.dart';
import 'package:griot_urban_app/constants/colors.dart';
import 'package:griot_urban_app/services/payment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionScreen extends StatefulWidget {
  final String token;

  const SubscriptionScreen({Key? key, required this.token}) : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isLoading = false;
  String? _subscriptionStatus;

  @override
  void initState() {
    super.initState();
    _checkSubscription();
  }

  Future<void> _checkSubscription() async {
    try {
      final response = await PaymentService.checkSubscription(widget.token);
      setState(() {
        _subscriptionStatus = response['subscription'];
      });
    } catch (e) {
      setState(() {
        _subscriptionStatus = 'free';
      });
    }
  }

  Future<void> _subscribe(String planId) async {
    setState(() => _isLoading = true);
    try {
      final response = await PaymentService.createSubscription(widget.token, planId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('subscription', response['subscription']);
      setState(() {
        _subscriptionStatus = response['subscription'];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Abonnement réussi !')),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abonnements'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Choisissez un abonnement',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPlanCard(
              title: 'Gratuit',
              price: '0€',
              features: ['Accès limité', 'Publicités', 'Contenu basique'],
              isActive: _subscriptionStatus == 'free',
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            _buildPlanCard(
              title: 'Premium',
              price: '4,99€/mois',
              features: ['Accès illimité', 'Pas de pubs', 'Contenu exclusif'],
              isActive: _subscriptionStatus == 'premium',
              onPressed: () => _subscribe('premium_monthly'),
            ),
            const SizedBox(height: 10),
            _buildPlanCard(
              title: 'À vie',
              price: '49,99€',
              features: ['Accès illimité', 'Pas de pubs', 'Contenu exclusif', 'Mises à jour gratuites'],
              isActive: _subscriptionStatus == 'lifetime',
              onPressed: () => _subscribe('lifetime'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required List<String> features,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: isActive ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isActive
            ? const BorderSide(color: AppColors.secondary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isActive ? AppColors.secondary : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(feature),
                ],
              ),
            )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? AppColors.secondary : AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        isActive ? 'ABONNÉ' : 'SOUSCRIRE',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
