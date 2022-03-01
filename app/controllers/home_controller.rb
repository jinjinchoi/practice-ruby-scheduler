class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @schedules = Schedule.all
    @lecture_type = params[:lecture_type]

    start_date = params[:start_date]
    if start_date.blank?
      @start_date = DateTime.now
    else
      @start_date = DateTime.parse(start_date)
    end

    date_range = (@start_date.beginning_of_week..@start_date.end_of_week).to_a
    hour_range = (@start_date.localtime.beginning_of_day.to_i..@start_date.localtime.end_of_day.to_i).step(30.minutes)

    @active = Array.new(hour_range.size) { Array.new(date_range.size) { false } }
    if @lecture_type == "mock" || @lecture_type == "init"
      return
    end

    # hour_range.each_with_index do |hour, idx_hour|
    #   date_range.each_with_index do |day, idx_day|
    #     _hour = Time.at(hour).localtime
    #     _day = Time.at(day).localtime
    #     datetime = DateTime.new(_day.year, _day.month, _day.day, _hour.hour, _hour.min, _hour.sec, '+9')
    #     schedule_list = Schedule.where(active: 1, start_date: datetime)
    #     unless schedule_list.empty?
    #       schedule_list.each do |schedule|
    #         case @lecture_type
    #         when "20" then
    #           @active[idx_hour][idx_day] = true
    #         when "40" then
    #           @tutor = Tutor.find(schedule.tutor_id)
    #           next_time_block = schedule.start_date + 30.minutes
    #           if Schedule.find_by(tutor_id: schedule.tutor_id, start_date: next_time_block)
    #             @active[idx_hour][idx_day] = true
    #           end
    #         else
    #         end
    #       end
    #     end
    #   end
    # end

    # 이번 주 동안 active한 스케줄들을 다 불러옴
    list_of_schedules = Schedule.where(active:1, :start_date => (@start_date.beginning_of_week)..(@start_date.end_of_week)).order(start_date: :asc)
    # puts(_temp.map{|t| t.start_date})
    # 스케줄이 yymmdd hhmm이면 -> beginning of week부터 end of week까지를 column index로
    # 00시부터 23:00까지를 row index로
    # 20분 권의 경우 active하면 active[row][col] = true로
    # 40분 권의 경우
    # 각 schedule의 튜터가 다음 시간대에도 active한지 체크를 해야 함
    #

    # puts("@start_date.localtime.beginning_of_day.to_datetime #{@start_date.localtime.beginning_of_day.to_datetime}")
    # puts("@start_date.localtime.end_of_day.to_datetime #{@start_date.localtime.end_of_day.to_datetime}")
    # puts("@start_date.beginning_of_week.to_datetime #{@start_date.beginning_of_week.to_datetime}")
    # puts("@start_date.end_of_week.to_datetime #{@start_date.end_of_week.to_datetime}")

    range_by_hour = (@start_date.localtime.beginning_of_day.to_datetime.to_i .. @start_date.localtime.end_of_day.to_datetime.to_i).step(30.minutes)
    range_by_day = (@start_date.beginning_of_week.to_datetime.to_i .. @start_date.end_of_week.to_datetime.to_i).step(1.day)


    calendar_array = Array.new(range_by_hour.size) { Array.new(range_by_day.size) { false } }
    range_by_hour.each_with_index do |hour, row|
      range_by_day.each_with_index do |day, column|
        calendar_array[row][column] = DateTime.new(Time.at(day).year, Time.at(day).month, Time.at(day).day, Time.at(hour).hour, Time.at(hour).min, Time.at(hour).sec, Time.at(hour).zone)
        # puts("active[#{row}][#{column}] #{DateTime.new(Time.at(day).year, Time.at(day).month, Time.at(day).day, Time.at(hour).hour, Time.at(hour).min, Time.at(hour).sec, Time.at(hour).zone)}")
      end
    end

    # puts(range_by_day.find_index("2022-03-01"))
    # puts(Time.at(range_by_day.to_a[0]))

    list_of_schedules.map{|t|
      # puts("yo #{t.start_date}")
      t.start_date
    }

    require 'matrix'



    case @lecture_type
    when "20" then
      list_of_schedules.map{ |s|
        active_index = Matrix[*calendar_array].index(s.start_date)
        @active[active_index[0]][active_index[1]] = true
      }
    when "40" then
      list_of_schedules.map{ |s|
        @tutor = Tutor.find(s.tutor_id)
        next_time_block = s.start_date + 30.minutes
        if Schedule.find_by(tutor_id: s.tutor_id, start_date: next_time_block)
          active_index = Matrix[*calendar_array].index(s.start_date)
          @active[active_index[0]][active_index[1]] = true
        end
      }
    else
    end

    # active_index = Matrix[*calendar_array].index(list_of_schedules[1].start_date)
    # @active[active_index[0]][active_index[1]] = true
    # puts(Matrix[*calendar_array].index(list_of_schedules[1].start_date))
    # puts(list_of_schedules[1][23])
    # puts(list_of_schedules[0].start_date)

  end

  def update
    @tutors = Tutor.all
    if @tutors.blank?
      @tutors = nil
    end
    tutor_id = params[:tutor_id]
    @s_id= params[:schedule_id]
    @edit_mode = params[:edit_mode]
    @tutor = Tutor.find_by(id: tutor_id)
    @schedules = Schedule.where(tutor_id: tutor_id).order(start_date: :asc)
    if @schedules.blank?
      @schedules = nil
    end
    @schedule = Schedule.find_by(id: @s_id, tutor_id: tutor_id)
  end

  def updateSchedule
    _active = params[:schedule][:active]
    _schedule = Schedule.find(params[:s_id])
    _schedule.active = _active
    _schedule.save
    redirect_to "/schedule/update/?tutor_id=#{params[:t_id]}&schedule_id=#{params[:s_id]}"
  end

  def deleteSchedule
    Schedule.destroy(params[:schedule_id])
    redirect_to '/schedule/update'
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
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-24 00:30:00',
      tutor_id: 1,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-24 01:00:00',
      tutor_id: 1,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-25 01:30:00',
      tutor_id: 1,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-2-25 02:00:00',
      tutor_id: 1,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-3-7 03:00:00',
      tutor_id: 4,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-07 00:00:00',
      tutor_id: 5,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-07 00:30:00',
      tutor_id: 5,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-08 02:30:00',
      tutor_id: 6,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-08 03:00:00',
      tutor_id: 6,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 02:30:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 03:00:00',
      tutor_id: 8,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-3-10 03:30:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 04:00:00',
      tutor_id: 8,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-3-10 04:30:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 05:00:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 03:30:00',
      tutor_id: 7,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 04:00:00',
      tutor_id: 7,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-10 04:30:00',
      tutor_id: 7,
      active: 2
    ).save

    Schedule.new(
      start_date: '2022-3-12 03:30:00',
      tutor_id: 8,
      active: 1
    ).save

    Schedule.new(
      start_date: '2022-3-12 04:00:00',
      tutor_id: 8,
      active: 1
    ).save
    redirect_to '/index/mock'
  end

  def init
    Tutor.delete_all
    Schedule.delete_all
    redirect_to '/index/init'
  end
end
