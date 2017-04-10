# Preview all emails at http://localhost:3000/rails/mailers/survey_mailer
class SurveyMailerPreview < ActionMailer::Preview
  def survey_mail_preview
    user = User.first
    survey = Survey.first
    SurveyMailer.send_survey_email(user, survey)
  end
end
