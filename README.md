# 不思議のチェシャネ工房

## 開発用

### データベース

```sh
% bundle
% bundle exec rake db:create_user
% bundle exec rake db:create
% bundle exec rake db:schema:load
```

## テスト用

### データベース

```sh
% RAILS_ENV=test bundle exec rake db:create
% RAILS_ENV=test bundle exec rake db:schema:load
```

### 自動実行

```sh
% bundle exec guard
```
