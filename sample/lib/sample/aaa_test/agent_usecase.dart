import 'package:dio/dio.dart';
import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

class AgentUseCaseImpl extends AgentUseCase {
  final AgentRepository repository;
  AgentUseCaseImpl({required this.repository});
  @override
  Future<Result<UserDataModel>> login({required int id, required int pw}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ProjectModel>>> getProjects() {
    throw UnimplementedError();
  }
}

class AgentUseCaseTestImpl extends AgentUseCase {
  AgentUseCaseTestImpl();
  @override
  Future<Result<UserDataModel>> login({required int id, required int pw}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ProjectModel>>> getProjects() {
    throw UnimplementedError();
  }
}

abstract interface class AgentUseCase implements UseCase {
  Future<Result<UserDataModel>> login({
    required int id,
    required int pw,
  });
  Future<Result<List<ProjectModel>>> getProjects();
}

class AgentRepository {
  final AgentDataSource ds;
  AgentRepository({required this.ds});
}

class AgentDataSource {
  final Dio dio;
  AgentDataSource({required this.dio});
}
