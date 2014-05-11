require 'open-uri'
require 'treat'
require 'date'
include Treat::Core::DSL

class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :edit, :update, :destroy]

  # GET /queries
  # GET /queries.json
  def index
    @queries = Query.all
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
    
    c=@query.val.gsub("wanna","want to").split(" ").map {|x| x.downcase.capitalize }.join(' ')
    c=c.apply(:tokenize,:category)
    if c.verbs
      action=c.verbs.join.downcase 
      if action.match("fly").to_s=="fly"
       
        fr=c.nouns[0].to_s.upcase
        to=c.nouns[1].to_s.upcase
        dat=c.adjectives.count>0 ? (c.adjectives[0].to_s + ' '+ c.nouns[2].to_s) : (c.nouns[2].to_s + ' '+ c.nouns[3].to_s)
        dat=Chronic.parse(dat).to_date.strftime("%d/%m/%Y")
        redirect_to "http://www.cleartrip.com/flights/results?from="+fr+"&to="+to+"&depart_date="+dat+"&adults=1&childs=0&infants=0&class=Economy&airline=&carrier=&intl=n&page=loaded"
      
      elsif (action.match("buy").to_s=="buy")||(action.match("purchase").to_s=="purchase")

        @page_am=Mechanize.new.get("http://www.amazon.in/s/?field-keywords="+c.nouns.join(' ').strip.gsub(" ","%20"))
        @page_fl=Nokogiri::HTML(open("http://www.flipkart.com/search?q="+c.nouns.join(' ').strip.gsub(" ","%20")))
      
      elsif action.match("read").to_s=="read"
        gon.topic=c.nouns.join(' ').gsub(" ","%20")
        render :partial => 'news'  
     end
    

   end


  end

  # GET /queries/new
  def new
    @query = Query.new
  end

  # GET /queries/1/edit
  def edit
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)

    respond_to do |format|
      if @query.save
        
        format.html { redirect_to @query, notice: 'Query was successfully created.' }
        format.json { render action: 'show', status: :created, location: @query }
      else
        format.html { render action: 'new' }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queries/1
  # PATCH/PUT /queries/1.json
  def update
    respond_to do |format|
      if @query.update(query_params)
        format.html { redirect_to @query, notice: 'Query was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:val)
    end
end
