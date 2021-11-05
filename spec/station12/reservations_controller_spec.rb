require 'rails_helper'

RSpec.describe Admin::ReservationsController, type: :controller do
  render_views
  describe 'Station12 GET /admin/reservations' do
    let!(:movie) { create(:movie) } 
    let!(:sheets) { create_list(:sheet, 5) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 
    let!(:reservations) { create_list(:reservation, 3, { sheet_id: sheets.first.id, schedule_id: schedule.id }) }
    before { get 'index' }

    it ' 200が返ること' do
      expect(response).to have_http_status(200)
    end

    it '予約を全件出力していること' do
      expect(response.body).to include(reservations.first.name).and include(reservations.last.name) 
    end
  end

  describe 'Station12 GET /admin/reservations/new' do
    before { get :new }

    it '200が返ること' do
      expect(response).to have_http_status(200)
    end

    it 'schedule_id, sheet_id, name, emailのすべてを受け取るフォームがあること' do
      expect(response.body).to include("name").and include("email").and include("schedule_id").and include("sheet_id")
    end
  end

  describe 'Station12 POST /admin/reservations/' do
    let!(:movie) { create(:movie) } 
    let!(:sheets) { create_list(:sheet, 5) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 

    it 'schedule_id, sheet_id, name, email, dateのすべてがあるときに302を返す' do
      post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: "2019-04-16", sheet_id: sheets.first.id , schedule_id: schedule.id, movie_id: movie.id }}, session: {}
      expect(response).to have_http_status(302)
    end

    it 'DBのunique制約にかかったときに座席一覧に飛ぶ' do
      # 同じ日付の同じ映画の座席を予約してみる
      create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id, date: "2019-04-16" })
      post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: "2019-04-16", sheet_id: sheets.first.id , schedule_id: schedule.id, movie_id: movie.id }}, session: {}
      expect(response).to have_http_status(400)
    end
  end

  describe 'Station12 GET /admin/reservations/:id' do
    let!(:movie) { create(:movie) } 
    let!(:sheets) { create_list(:sheet, 5) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 
    let!(:reservation) { create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id, date: "2019-04-16" }) }
    before { get :edit, params: { id: reservation.id } }

    it 'schedule_id, sheet_id, name, emailのすべてを受け取るフォームがあること' do
      expect(response.body).to include("name").and include("email").and include("schedule_id").and include("sheet_id")
    end

    it 'DB上のデータがすでにフォームに入っていること' do
      expect(response.body).to include(reservation.name).and include(reservation.email)
    end
  end

  describe 'Station12 PUT /admin/reservations/:id' do
    let!(:movie) { create(:movie) } 
    let!(:sheets) { create_list(:sheet, 5) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 
    let!(:reservation) { create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id }) }

    it 'schedule_id, sheet_id, name, emailのすべてがあるときだけ302にすること' do
      put :update, params: { id: reservation.id, reservation: { schedule_id: reservation.schedule_id, sheet_id: reservation.sheet_id }}
      expect(response).to have_http_status(302)
    end
  end

  describe 'Station12 DELETE /admin/reservations/:id' do
    let!(:movie) { create(:movie) } 
    let!(:sheets) { create_list(:sheet, 5) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 
    let!(:reservation) { create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id, name: "TEST_NAME", email: "test@test.com", date: "2019-04-16" }) }

    it 'reservationテーブルから:idのレコードを物理削除していること' do
      expect do
        delete :destroy, params: { id: reservation.id }, session: {}
      end.to change(Reservation, :count).by(-1)
    end
  end
end
