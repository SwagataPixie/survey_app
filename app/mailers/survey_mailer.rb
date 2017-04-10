class SurveyMailer < ApplicationMailer
  default from: 'swagatabiswasiitkgp@gmail.com'

  layout "mailer"

  def send_survey_email(user, survey)
    @user = user
    @url = url_for(controller: 'surveys', action: 'show', id: survey.id)
    mail(to: @user.email, subject: 'Survey Email')
  end
end
