import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../core/extensions/context_ext.dart';
import '../../auth/controllers/get_user_provider.dart';
import '../../auth/entities/user_data.dart';
import '../../auth/widgets/user_tile.dart';
import '../entities/club_levels.dart';
import '../entities/club_user.dart';
import '../widgets/info_message.dart';
import '../widgets/label_tag.dart';
import '../widgets/value_picker_dialog.dart';

class ClubUserPickerScreen extends ConsumerWidget {
  const ClubUserPickerScreen({
    super.key,
    this.selected = const [],
    required this.onSelected,
  });

  final List<ClubUser> selected;
  final void Function(ClubUser user) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(getAllUsersProvider);
    final users = usersAsync.valueOrNull ?? const [];

    void pick(UserData user, ClubLevels level) {
      onSelected(
        ClubUser(userId: user.uid, level: level),
      );
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a user'),
      ),
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              usersAsync.isLoading ? 'Loading Users' : '${users.length} Users',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSizes.smallY,
            if (usersAsync.hasError)
              Center(
                heightFactor: 10,
                child: InfoMessage.error(
                  title: 'An error occured',
                  description: usersAsync.error.toString(),
                ),
              )
            else if (users.isEmpty)
              const Center(
                heightFactor: 10,
                child: InfoMessage.empty(
                  title: 'No users found',
                  description: 'Wait for some users to register in the app',
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (_, i) => AppSizes.smallY,
                itemBuilder: (_, i) {
                  final selectedUsers = selected.where((u) => u.userId == users[i].uid);

                  return UserTile(
                    user: users[i],
                    onPressed: () {
                      ValuePickerDialog(
                        values: ClubLevels.values,
                        onPicked: (l) => pick(users[i], l),
                      ).show(context);
                    },
                    trailing: selectedUsers.isEmpty
                        ? null
                        : ClubLevelTag(
                            selectedUsers.first.level,
                          ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
