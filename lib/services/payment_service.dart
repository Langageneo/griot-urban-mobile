static Future<void> startFlutterwavePayment(
  BuildContext context,
  String email,
  String amount,
  String currency,
  String txRef,
) async {
  try {
    final response = await Flutterwave.forContext(context)
      .setAmount(amount)                     // Montant en FCFA (ex: "5000" pour 5000 FCFA)
      .setCurrency("XOF")                     // Devise : FCFA (XOF)
      .setPaymentOptions("card, mobilemoney, ussd")  // Méthodes activées
      .setCustomerEmail(email)
      .setTxRef(txRef)                        // Référence unique (ex: "GRIOT-${DateTime.now().millisecondsSinceEpoch}")
      .setMeta({"metaname": "Griot Urban"})   // Métadonnées
      .initializeForUiPayments();            // Lance l'interface de paiement

    if (response.status == "successful") {
      // Vérifie le paiement côté serveur (obligatoire pour éviter les fraudes)
      final verification = await verifyFlutterwavePayment(response.transactionId);
      return verification;
    } else {
      throw Exception("Paiement échoué: ${response.status}");
    }
  } catch (e) {
    throw Exception("Erreur Flutterwave: ${e.toString()}");
  }
}
