class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @lecture_type = params[:lecture_type]
    @start_date = params[:start_date]
    # puts(@start_date)

    case @lecture_type
    when "20" then
      @schedules = Schedule.all
    when "40" then
      @schedules = Schedule.all
      @temp = []
      @schedules.each do |schedule|
        @tutor = Tutor.find(schedule.tutor_id)
        puts(@tutor.name)
        next_time_block = schedule.start_date + 30.minutes
        @next = Schedule.find_by(tutor_id: schedule.tutor_id, start_date: next_time_block)
        # puts(schedule.start_date)
        # puts(next_time_block.utc)
        # puts(schedule.start_date.to_date)
        # puts(schedule.start_date.to_date + 30.minutes)
        puts(@next ? "exists" : "")
        @next ? @temp.append(schedule) : ""
        # wday = schedule.start_date.strftime('%A')
        # puts(wday)
      end
      @schedules = @temp
    else
      @schedules = Schedule.all
    end
    # puts(@schedules.map{|s| s.start_date})


  end

  def check
    puts("가능한 수업 선생님들은..")
    # input : start_date, lesson_type(20/40)
    # output : 해당 start_date에 {lesson_type}수업이 가능한 선생님들의 목록
    puts(params[:date])
    puts(Schedule.find_by_start_date(params[:date]).tutor_id)
    redirect_to '/available'
  end

  def available

  end

  def main

  end

  def mock
    Tutor.delete_all
    Schedule.delete_all
    Tutor.new(
      name: 'tutor Choi'
    ).save
    Tutor.new(
      name: 'tutor Kim'
    ).save
    Tutor.new(
      name: 'tutor So'
    ).save
    Tutor.new(
      name: 'tutor lucy'
    ).save
    Tutor.new(
      name: 'tutor Park'
    ).save
    Tutor.new(
      name: 'tutor Lee'
    ).save
    Tutor.new(
      name: 'tutor Gon'
    ).save
    Tutor.new(
      name: 'tutor Paik'
    ).save

    Schedule.new(
      start_date: '2022-2-28 00:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 00:30:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 01:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 01:30:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 02:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-28 01:00:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 01:30:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 02:00:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 04:00:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 04:30:00',
      tutor_id: 2,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-1 00:30:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-1 01:00:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-1 05:00:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-1 08:00:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-1 08:30:00',
      tutor_id: 3,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-2 01:30:00',
      tutor_id: 4,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-2 02:00:00',
      tutor_id: 4,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-2 02:30:00',
      tutor_id: 4,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-2 03:00:00',
      tutor_id: 4,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-03 00:00:00',
      tutor_id: 5,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-03 00:30:00',
      tutor_id: 5,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-03 00:30:00',
      tutor_id: 6,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-03 01:00:00',
      tutor_id: 6,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-03 01:30:00',
      tutor_id: 6,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-04 03:30:00',
      tutor_id: 7,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-04 04:00:00',
      tutor_id: 7,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-28 04:00:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-01 04:00:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-02 04:00:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-24 00:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-24 00:30:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-24 01:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-25 01:30:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-2-25 02:00:00',
      tutor_id: 1,
      active: 2
    ).save
    redirect_to '/home/index'
  end

  def init
    Tutor.delete_all
    Schedule.delete_all
    redirect_to '/home/index'
  end
end
