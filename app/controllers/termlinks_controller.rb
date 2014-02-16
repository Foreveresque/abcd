class TermlinksController < ApplicationController
  def destroy
    termlink = Termlink.find(params[:id])
    term_id = termlink.term_id
    link_id = termlink.link_id
    termlink.destroy
    if other = Termlink.find_by_term_id_and_link_id(link_id,term_id)
      other.destroy
    end

    respond_to do |format|
      format.html { redirect_to terms_url }
      format.json { head :no_content }
    end
  end
end
