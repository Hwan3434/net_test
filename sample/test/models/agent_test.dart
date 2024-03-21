import 'package:flutter_test/flutter_test.dart';
import 'package:sample/sample/data/domain/agent/model/agent_state_model.dart';

void main() {
  group('에이전트 데이터 모델 조작 테스트', () {
    var agent = AgentStateModel.init();

    test('에이전트 초기화 상태 파악', () {
      expect(agent.state == AgentState.wait, true);
    });
  });
}
