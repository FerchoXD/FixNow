import 'package:fixnow/presentation/providers/service/history_provider.dart';
import 'package:fixnow/presentation/widgets/history/container_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerStatefulWidget {
  final String userId;
  final String role;
  const HistoryView({super.key, required this.userId, required this.role});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(historyProvider.notifier).getHistory(widget.userId, widget.role);
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyProvider);
    final colors = Theme.of(context).colorScheme;
    return historyState.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SegmentedButton(
                          segments: const [
                            ButtonSegment(
                              value: HistoryOption.all,
                              icon: Text(
                                'Todos',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ButtonSegment(
                              value: HistoryOption.pending,
                              icon: Text(
                                'Pendientes',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ButtonSegment(
                              value: HistoryOption.progress,
                              icon: Text(
                                'En progreso',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                          selected: <HistoryOption>{historyState.historyOption},
                          onSelectionChanged: (value) {
                            ref
                                .read(historyProvider.notifier)
                                .updateOption(value.first);
                          },
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SegmentedButton(
                          segments: const [
                            ButtonSegment(
                              value: HistoryOption.confirmed,
                              icon: Text(
                                'Realizado',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ButtonSegment(
                              value: HistoryOption.canceled,
                              icon: Text(
                                'Cancelados',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                          selected: <HistoryOption>{historyState.historyOption},
                          onSelectionChanged: (value) {
                            ref
                                .read(historyProvider.notifier)
                                .updateOption(value.first);
                          },
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ContainerHistoryService(
                    userId: widget.userId,
                    role: widget.role,
                    services: historyState.history != null
                        ? historyState.history!['data']['history']
                        : [],
                    selectedOption: historyState.historyOption,
                  ),
                ),
              ],
            ),
          );
  }
}
