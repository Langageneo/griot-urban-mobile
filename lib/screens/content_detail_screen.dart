// Remplace la partie audio par ceci :
GestureDetector(
  onTap: () async {
    if (_isPlaying) {
      await IvoirianBeat.stop();
    } else {
      await IvoirianBeat.play(); // Utilise le beat généré
    }
    setState(() => _isPlaying = !_isPlaying);
  },
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    decoration: BoxDecoration(
      gradient: AppColors.buttonGradient,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_isPlaying ? Icons.stop : Icons.play_arrow, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          _isPlaying ? 'STOP' : 'JOUER LE BEAT',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
),
