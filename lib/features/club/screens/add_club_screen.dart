import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../core/extensions/context_ext.dart';
import '../../auth/widgets/app_text_field.dart';
import '../../auth/widgets/user_tile.dart';
import '../entities/club.dart';
import '../entities/club_levels.dart';
import '../entities/club_user.dart';
import '../widgets/background_picker.dart';
import '../widgets/label_tag.dart';
import 'club_user_picker_screen.dart';

class AddClubScreen extends ConsumerStatefulWidget {
  const AddClubScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinClubScreenState();
}

class _JoinClubScreenState extends ConsumerState<AddClubScreen> {
  final formKey = GlobalKey<FormState>();
  var club = Club.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Club'),
      ),
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BackgroundPicker(
                onChanged: (url) => club = club.copyWith(coverImgUrl: url),
              ),
              AppSizes.mediumY,
              AppTextField.name(
                label: 'Title',
                hint: 'A nice title or name of the club',
                onSubmit: (x) => club = club.copyWith(title: x),
              ),
              AppSizes.mediumY,
              AppTextField.name(
                label: 'Description',
                hint: 'Briefly describe the purpose of this club',
                maxLines: 2,
                onSubmit: (x) => club = club.copyWith(title: x),
              ),
              AppSizes.normalY,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Team',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushTo(
                        ClubUserPickerScreen(onSelected: addUser),
                      );
                    },
                    child: const Text('Select'),
                  ),
                ],
              ),
              AppSizes.tinyY,
              if (club.team.lead.userId.isNotEmpty)
                UserTile(
                  userId: club.team.lead.userId,
                  trailing: ClubLevelTag(club.team.lead.level),
                ),
              for (final colead in club.team.coleads)
                UserTile(
                  userId: colead.userId,
                  trailing: ClubLevelTag(colead.level),
                ),
              AppSizes.largeY,
            ],
          ),
        ),
      ),
      bottomSheet: const Divider(height: 0),
      bottomNavigationBar: Padding(
        padding: AppPaddings.normal,
        child: ElevatedButton(
          onPressed: save,
          child: const Text('Create'),
        ),
      ),
    );
  }

  void addUser(ClubUser user) {
    var team = club.team;
    if (user.level == ClubLevels.lead) {
      team = team.copyWith(lead: user);
    } else if (user.level == ClubLevels.colead) {
      team = team.copyWith(
        coleads: [...team.coleads, user],
      );
    }
    setState(() => club = club.copyWith(team: team));
  }

  void save() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid == false) return;
    formKey.currentState?.save();

    if (club.team.lead.userId.isEmpty) {
      context.showError('A club should have atleast one team lead');
      return;
    }

    context.pop();
  }
}
