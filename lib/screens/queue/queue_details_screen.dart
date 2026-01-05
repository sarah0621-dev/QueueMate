import 'package:flutter/material.dart';

class QueueDetailsScreen extends StatefulWidget {
  const QueueDetailsScreen({super.key});

  @override
  State<QueueDetailsScreen> createState() => _QueueDetailsScreenState();
}

class _QueueDetailsScreenState extends State<QueueDetailsScreen> {
  final String currentService = 'Sydney Service NSW';
  final int queuePosition = 12;
  final int estimatedWaitMinutes = 18;

  final List<Map<String, dynamic>> statusUpdates = [
    {
      'time': '10:42 AM',
      'status': 'Joined the queue',
      'isActive': false,
    },
    {
      'time': '10:55 AM',
      'status': 'Moved to waiting',
      'isActive': true,
    },
    {
      'time': '11:15 AM',
      'status': 'Estimated service time',
      'isActive': false,
      'isEstimate': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Queue Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      "You're in queue at",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          currentService,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF5B5FC7)),
                      ),
                      child: Text(
                        'Position : $queuePosition',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B5FC7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatusStep('Joined', false, true),
                        _buildStatusLine(true),
                        _buildStatusStep('Waiting', true, true),
                        _buildStatusLine(false),
                        _buildStatusStep('Next', false, false),
                        _buildStatusLine(false),
                        _buildStatusStep('Serving', false, false),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Estimated wait ~ $estimatedWaitMinutes minutes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Leave queue
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Leave Queue',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Updates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...statusUpdates.map((update) => _buildStatusUpdate(
                          update['time'] as String,
                          update['status'] as String,
                          update['isActive'] as bool,
                          update['isEstimate'] as bool? ?? false,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What Happens next?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      '⚠️',
                      "You'll be notified when you're next",
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      '📍',
                      'Please stay within 10 minutes travel distance',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      '⏰',
                      'Missing your turn may reset your position',
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

  Widget _buildStatusStep(String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? const Color(0xFF5B5FC7)
                : isCompleted
                    ? Colors.grey[400]
                    : Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? const Color(0xFF5B5FC7)
                : isCompleted
                    ? Colors.grey[600]
                    : Colors.grey[400],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLine(bool isCompleted) {
    return Container(
      width: 32,
      height: 2,
      color: isCompleted ? Colors.grey[400] : Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _buildStatusUpdate(
      String time, String status, bool isActive, bool isEstimate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? const Color(0xFF5B5FC7)
                  : isEstimate
                      ? Colors.grey[300]
                      : Colors.grey[400],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: isEstimate ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 15,
                    color: isEstimate ? Colors.grey[500] : Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String emoji, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
