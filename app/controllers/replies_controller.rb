class RepliesController < ApplicationController
    def create
        @reply = Reply.new
        @reply.content = params[:content]
        @reply.post_id = params[:post_id]
        @reply.save
            
        redirect_to :back
    end
     
        
    def destroy
        @reply = Reply.find(params[:id])
        @reply.destroy
     
        redirect_to :back
    end    
end
