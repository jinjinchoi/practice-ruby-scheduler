class ScheduleController < ApplicationController
  def new
    @tutors = Tutor.all
    if @tutors.blank?
      @tutors = nil
    end
    @error = params[:error]=='true'
  end

  def addSchedule
    new_schedule = Schedule.new
    new_schedule.tutor_id = params[:tutor_id]
    _start_date = DateTime.new(params["start_date(1i)"].to_i, params["start_date(2i)"].to_i, params["start_date(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(5i)"].to_i, 0, '+9')
    puts(_start_date)
    puts(_start_date.localtime)
    new_schedule.start_date = _start_date.localtime
    new_schedule.active = 1
    if new_schedule.save
      redirect_to "/schedule/update/?tutor_id=#{params[:tutor_id]}&schedule_id=#{new_schedule.id}"
    else
      new_schedule.errors.full_messages.each do |message|
        if message == 'Start date has already been taken'
          redirect_to "/schedule/new?error=true"
        end
      end
    end
  end
  def create
    # new_schedule = Schedule.new
    # new_schedule.name = params[:name]
    # // :start_time, :tutor_id, :active

    # new_schedule.save
    redirect_to '/'
  end
end
