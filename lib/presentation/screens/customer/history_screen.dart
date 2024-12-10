import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/service/history_provider.dart';
import 'package:fixnow/presentation/widgets/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFE9FFE9),
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    ref.listen(historyProvider, (previous, next) {
      if (next.statusUpdated.isEmpty) return;
      showToast(next.statusUpdated);
    });

    final userState = ref.watch(authProvider);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Historial',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 3));
          ref
              .read(historyProvider.notifier)
              .getHistory();
        },
        child: HistoryView(
          userId: userState.user!.id!,
          role: userState.user!.role!,
        ),
      ),
    );
  }
}
