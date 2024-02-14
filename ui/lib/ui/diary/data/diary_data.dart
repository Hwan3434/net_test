import 'package:ui/ui/diary/data/diary_model.dart';

enum BottomTabs {
  diary,
  delete,
}

final Map<int, DiaryUserModel> allUsers = {
  DiaryUserModel.jj().id: DiaryUserModel.jj(),
  DiaryUserModel.nb().id: DiaryUserModel.nb(),
  DiaryUserModel.gb().id: DiaryUserModel.gb(),
  DiaryUserModel.wb().id: DiaryUserModel.wb()
};

final List<DiaryModel> allData = [
  DiaryModel(
    id: 1,
    color: DiaryColor.blue,
    date: DateTime(2023, 3, 16),
    content: '내용ㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇㅈㅇ라라라라라라라라라라라라라라 으아아아악 나와',
    fav: true,
    selectedState: true,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.gb(),
    ],
    etc: [
      '기타 1번이요',
      '호놀롤로',
      '후루루루루',
    ],
  ),
  DiaryModel(
    id: 2,
    color: DiaryColor.green,
    date: DateTime(2023, 3, 17),
    content: '1234',
    fav: true,
    selectedState: true,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.gb(),
    ],
    etc: [],
  ),
  DiaryModel(
    id: 3,
    color: DiaryColor.yellow,
    date: DateTime(2023, 3, 18),
    content: 'ㅎㅎㅎㅎ',
    fav: false,
    selectedState: false,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.wb(),
    ],
    etc: [],
  ),
  DiaryModel(
    id: 4,
    color: DiaryColor.red,
    date: DateTime(2023, 3, 21),
    content: '567',
    fav: true,
    selectedState: false,
    users: [
      DiaryUserModel.nb(),
    ],
    etc: [],
  ),
  DiaryModel(
    id: 5,
    color: DiaryColor.red,
    date: DateTime(2023, 3, 29),
    content: '89',
    fav: true,
    selectedState: false,
    users: [
      DiaryUserModel.nb(),
    ],
    etc: [],
  )
];

final List<DiaryModel> deleteData = [
  DiaryModel(
    id: 7,
    color: DiaryColor.blue,
    date: DateTime(2023, 3, 15),
    content: 'ㅋㅋㅋㅋㅋㅋㅋ',
    fav: false,
    selectedState: false,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.gb(),
    ],
    etc: [],
  ),
  DiaryModel(
    id: 8,
    color: DiaryColor.green,
    date: DateTime(2023, 3, 14),
    content: 'ㅋㅋㅋㅋㅋ',
    fav: false,
    selectedState: false,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.gb(),
    ],
    etc: [],
  ),
  DiaryModel(
    id: 9,
    color: DiaryColor.yellow,
    date: DateTime(2023, 3, 8),
    content: 'ㅋㅋㅋㅋㅋㅋㅋ',
    fav: false,
    selectedState: false,
    users: [
      DiaryUserModel.jj(),
      DiaryUserModel.gb(),
    ],
    etc: [],
  )
];