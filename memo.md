#メモ
docker compose run --rm web bundle install
docker compose exec web rails console
docker compose run --rm web rails db:migrate
docker compose run --rm web rails routes

docker compose restart

Railwayに取り組むときは
docker compose up -d
やめる時は
docker compose down



- `GET /admin/schedules` でスケジュール一覧を表示する
- 作品・ID, 作品名を見出し(h2タグ)にし、その下にその作品の開始時刻・終了時刻がリストアップされているような形にする
- スケジュールが設定されていない作品は表示しなくてよい
- schedulesの全件・全カラムを表示する
- 各スケジュールはリンクになっていて、リンク先は `GET /admin/schedules/:id`
- `GET /admin/movies/:id` にリンクを追加
- `GET /admin/schedules`と同様にその作品に対応する`GET /admin/schedules/:id`へのリンクを置く
- `GET /admin/movies/:id/schedules/new`へのリンクを追加する
- `GET /admin/schedules/:id` でスケジュールを編集するためのフォームを表示する
- 開始時刻と終了時刻のフォームがあり、送信を押すと`PUT /admin/schedules/:id`へ送信される
- movie_idはここでは変更させない（必要なら削除して新規追加してもらう）
- 削除ボタンがあり、同様に確認ダイアログにOKを押すと`DELETE /schedules/:id`を送信する
- `PUT /schedules/:id`でidに対応するschedulesレコードを更新する
- `DELETE /schedules/:id`でidに対応するschedulesレコードを削除する
- 物理削除してよい