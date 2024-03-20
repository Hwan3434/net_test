import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/util/log.dart';

typedef ProjectCallBack = void Function(ProjectModel projectModel);

class DialogProjectSelectorBody extends StatelessWidget {
  final List<ProjectModel> projects;
  final ProjectCallBack onTab;
  const DialogProjectSelectorBody({
    required this.projects,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            child: InkWell(
              onTap: () {
                onTab(project);
                context.pop();
              },
              child: Text(
                project.name,
              ),
            ),
          );
        },
      ),
    );
  }
}
