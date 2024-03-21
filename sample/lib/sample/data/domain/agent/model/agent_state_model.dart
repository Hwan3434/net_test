import 'package:sample/sample/data/domain/agent/model/agent_model.dart';

enum AgentState {
  logout,
  wait,
  loading,
  success,
  error,
}

class AgentStateModel {
  final AgentState state;
  final AgentModel? data;

  const AgentStateModel({
    required this.state,
    this.data,
  });

  factory AgentStateModel.init() => AgentStateModel(state: AgentState.wait);

  AgentStateModel copyWith({
    AgentState? state,
    AgentModel? model,
  }) {
    return AgentStateModel(
      state: state ?? this.state,
      data: model,
    );
  }
}
