import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/widgets/history/Container_history_service.dart';
import 'package:fixnow/presentation/providers/service/history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  final HistoryService _historyService = HistoryService();
  Map<String, dynamic>? _response;
  bool _isLoading = true;
  String _filterStatus = 'ALL'; // Filtro actual.

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }


  Future<void> _loadHistory() async {
    final userUuid = ref.read(authProvider).user!.id;
    final response = await _historyService.fetchHistory(userUuid);

    setState(() {
      _response = response;
      _isLoading = false;
    });

    if (response['status'] == 404) {
      print('No se encontraron registros.');
    } else if (response['status'] == 500) {
      print('Error interno del servidor.');
    } else {
      print('Datos cargados: ${response['data']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_response == null) {
      return Center(
        child: Text(
          'Error desconocido.',
          style: TextStyle(color: colors.error),
        ),
      );
    }

    final status = _response!['status'];
    final message = _response!['message'];

    if (status == 404) {
      return Center(
        child: Text(
          message ?? 'No se encontraron registros.',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      );
    }

    if (status == 500) {
      return Center(
        child: Text(
          message ?? 'Error interno del servidor.',
          style: TextStyle(color: colors.error),
        ),
      );
    }

    final data = _response!['data'];
    final history = data['history'] as List<dynamic>?;

    if (history == null || history.isEmpty) {
      return Center(
        child: Text(
          'No hay historial disponible.',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      );
    }

    // Filtrar los datos según el filtro actual (_filterStatus).
    final filteredHistory = _filterStatus == 'ALL'
        ? history
        : history.where((service) => service['status'] == _filterStatus).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => setState(() => _filterStatus = 'ALL'),
                child: Text(
                  'Todos',
                  style: TextStyle(
                    color: _filterStatus == 'ALL' ? colors.primary : colors.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _filterStatus = 'PENDING'),
                child: Text(
                  'Pendientes',
                  style: TextStyle(
                    color: _filterStatus == 'PENDING' ? Colors.blue : colors.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _filterStatus = 'CONFIRMED'),
                child: Text(
                  'Confirmados',
                  style: TextStyle(
                    color: _filterStatus == 'CONFIRMED' ? Colors.green : colors.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _filterStatus = 'CANCELLED'),
                child: Text(
                  'Cancelados',
                  style: TextStyle(
                    color: _filterStatus == 'CANCELLED' ? Colors.red : colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ContainerHistoryService(services: filteredHistory),
          ),
        ],
      ),
    );
  }
}
