class ScheduleController < ApplicationController
  def new
    @tutors = Tutor.all
    if @tutors.blank?
      @tutors = nil
    end
  end

  def addSchedule
    new_schedule = Schedule.new
    new_schedule.tutor_id = params[:tutor_id]
    _start_date = DateTime.new(params["start_time(1i)"].to_i, params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(5i)"].to_i, 0, '+9')
    new_schedule.start_date = _start_date
    new_schedule.active = 1
    if new_schedule.save
      redirect_to "/schedule/update/?tutor_id=#{params[:tutor_id]}&schedule_id=#{new_schedule.id}"
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
