class UserMailer < ApplicationMailer
  def send_contract(email, travel, origin = "Contract")
    @travel = travel
    @contract = origin
    mail(to: email, subject:"New #{@contract} created: #{@travel.id}") do |format|
      format.pdf do
        attachments["travel.pdf"] = WickedPdf.new.pdf_from_string(
          render_to_string(template: "travels/travel.pdf.erb")
        )
      end
    end
  end
end
