import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/common/usecase_manager.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/ui/login/login_view_model.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_field.dart';
import 'package:sample/sample/widget/common/login_text_widget.dart';

class LoginWidget
    extends ProviderStatefulWidget<LoginStateNotifier, LoginViewModel> {
  static String get path => 'Login';
  static String get name => 'LoginWidget';
  const LoginWidget();

  static final loginViewModelProvider =
      StateNotifierProvider.autoDispose<LoginStateNotifier, LoginViewModel>(
          (ref) {
    final agent = ref.read(GlobalStateStorage().agentStateProvider);
    final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);
    return LoginStateNotifier(
        LoginViewModel(
          state: agent.state,
          id: '',
          pw: '',
        ),
        agentUseCase);
  });

  @override
  ProviderState createState() => _LoginWidgetState();

  @override
  AutoDisposeStateNotifierProvider<LoginStateNotifier, LoginViewModel>
      get provider => loginViewModelProvider;
}

class _LoginWidgetState
    extends ProviderState<LoginWidget, LoginStateNotifier, LoginViewModel> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.addListener(() {
      ref.read(widget.provider.notifier).update(id: idController.text);
    });
    pwController.addListener(() {
      ref.read(widget.provider.notifier).update(pw: pwController.text);
    });
  }

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget pBuild(BuildContext context) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      Log.d('이번');
      ref.read(widget.provider.notifier).login(state: next.state);
    });

    ref.listen(widget.provider.select((value) => value.state),
        (previous, next) {
      Log.d('일번');
      if (next == AgentState.success) {
        context.goNamed(ContentView.name);
      }
    });

    final agentState =
        ref.watch(widget.provider.select((value) => value.state));
    Log.w('LoginWidget Builder 갱신 ');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BTextField(
            controller: idController,
          ),
          _UserIdTextBuilderTestWidget(),
          BTextField(
            controller: pwController,
          ),
          Consumer(
            builder: (context, ref, child) {
              final text =
                  ref.watch(widget.provider.select((value) => value.pw));
              Log.w('Consumer Password Bulder !!');
              return LoginTextWidget(
                text,
                validateFn: (text) {
                  if (text != 'dddd') {
                    return ValidateModel(
                      success: false,
                      color: Colors.red,
                      message: '비밀번호가 맞지않음',
                    );
                  } else {
                    return ValidateModel(
                      success: true,
                    );
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          if (agentState == AgentState.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (agentState == AgentState.wait)
            BButton(
              onPressed: () {
                final id = idController.text;
                final validate =
                    ref.read(widget.provider.notifier).isValidate();
                Log.d('사번');
                if (id.isNotEmpty && validate) {
                  Log.d('오번');
                  ref
                      .read(GlobalStateStorage().agentStateProvider.notifier)
                      .login(idController.text, pwController.text);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('에러')));
                }
              },
              child: Text('로그인(pw = "dddd")'),
            )
        ],
      ),
    );
  }
}

class _UserIdTextBuilderTestWidget
    extends ProviderStatelessWidget<LoginStateNotifier, LoginViewModel> {
  const _UserIdTextBuilderTestWidget({super.key});

  @override
  ProviderBase<LoginViewModel> get provider =>
      LoginWidget.loginViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    Log.w('_UserIdTextBuilderTestWidget Bulder !!');
    final id = ref.watch(provider.select((value) => value.id));
    return Text('userID : $id');
  }
}
