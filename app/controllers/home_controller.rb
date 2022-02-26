class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def main

  end

  def data
    schedules = Schedule.all
    render json: schedules.map {|schedule| {
      id: schedule.id,
      start_date: schedule.start_date.to_formatted_s(:db),
      end_date: schedule.end_date.to_formatted_s(:db),
      text: schedule.text
    }}
  end

  def db_action
    mode = params["!nativeeditor_status"]
    id = params["id"]
    start_date = params["start_date"]
    end_date = params["end_date"]
    text = params["text"]

    case mode
    when "inserted"
      schedule = Schedule.new(
                  start_date: start_date,
                  end_date: end_date,
                  text: text
                )
      tid = schedule.id
      schedule.save
    when "deleted"
      Schedule.find(id).destroy
      tid = id
    when "updated"
      schedule = Schedule.find(id)
      schedule.start_date = start_date
      schedule.end_date = end_date
      schedule.text = text
      schedule.save
      id = id
    end

    render json: {
      type: mode,
      sid: id,
      tid: tid,
    }
  end

  def index
    @schedules = Schedule.all.order(start_time: :asc)

    @tue = []

    @schedules.each do |schedule|
      @tutor = Tutor.find(schedule.tutor_id)
      lessonInfo = @tutor.name + (schedule.type == 1 ? "20" : "40") + "분 수업"
      @info = [schedule.active, lessonInfo]
      @tue.append(@info)
    end


    @count = [@tue.length()].max

  end

  def mock
    Tutor.new(
      name: 'Jin Choi'
    ).save
    Tutor.new(
      name: 'Cool Kim'
    ).save
    Tutor.new(
      name: 'Sam So'
    ).save
    Tutor.new(
      name: 'Holiday lucy'
    ).save

    Schedule.new(
      start_date: '2022-2-28 12:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 12:00:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 12:30:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 13:30:00',
      tutor_id: 4,
      active: 1
    ).save


    redirect_to '/home/index'
  end
end
