# codexSandboxApp

Flutter製TODOアプリの雛形です。  
トップビュー・追加ビュー・編集ビューの3画面でTODOの作成/編集を行います。

## ファイル設計

- `/pubspec.yaml`
  - Flutterアプリの依存関係定義。`flutter`, `flutter_test`, `flutter_lints` を設定。
- `/analysis_options.yaml`
  - Dart/Flutterの静的解析ルールを `flutter_lints` で有効化。
- `/lib/main.dart`
  - エントリーポイント。`MaterialApp` を定義し、トップビュー（`TodoListView`）を起動。
- `/lib/models/todo.dart`
  - TODOモデル定義。以下の4項目を保持。
    - タイトル (`title`)
    - 作成日時 (`createdAt`)
    - 締切 (`deadline`)
    - 詳細 (`description`)
- `/lib/views/todo_list_view.dart`
  - トップビュー。TODO一覧表示、右下ボタンで追加ビュー遷移、項目タップで編集ビュー遷移。
- `/lib/views/add_todo_view.dart`
  - 追加ビュー。タイトル/締切/詳細を入力し、追加でトップビューへ返却。
- `/lib/views/edit_todo_view.dart`
  - 編集ビュー。既存TODOを初期値として表示し、更新してトップビューへ返却。
- `/lib/views/todo_form_view.dart`
  - 追加・編集で共通利用する入力フォーム部品。タイトル、締切、詳細入力と送信処理を担当。
