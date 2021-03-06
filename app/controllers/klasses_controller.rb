class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.xml
  def index
    #raise params.inspect
    #---- search by programme --------- 24 Apr 2012------------------------------
    #@programme_id = params[:klass]#[:programme_id]
    #@programme_id2 = params[:klass][:programme_id]
  #	if @programme_id
  	 # @klasses = Klass.find(:all, :conditions => ["programme_id=?", params[:klass][:programme_id]])
   # else
     # @klasses = Klass.all 
   # end
 @klasses = Klass.search2(params[:programmeid])      #tak ok - kena specify nil value if no option selected!
  #@klasses = Klass.search2(nil)                                #ok
  #@klasses = Klass.search2(1)                                  #ok
  
  	
  	#@pages = Page.search(params[:search])
    #---- search by programme --------- 24 Apr 2012------------------------------
    
    #@klasses = Klass.search(params[:search]) #--------- 24 Apr 2012 ------- (search by class name)
    #@klasses = Klass.all 
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @klasses }
    end
  end

  # GET /klasses/1
  # GET /klasses/1.xml
  def show
    @klass = Klass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/new
  # GET /klasses/new.xml
  def new
    @klass = Klass.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
    @klass = Klass.find(params[:id])
  end

  # POST /klasses
  # POST /klasses.xml
  def create
    @klass = Klass.new(params[:klass])

    respond_to do |format|
      if @klass.save
        flash[:notice] = 'Klass was successfully created.'
        format.html { redirect_to(@klass) }
        format.xml  { render :xml => @klass, :status => :created, :location => @klass }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /klasses/1
  # PUT /klasses/1.xml
  def update
    @klass = Klass.find(params[:id])

    respond_to do |format|
      if @klass.update_attributes(params[:klass])
        flash[:notice] = 'Klass was successfully updated.'
        format.html { redirect_to(@klass) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1
  # DELETE /klasses/1.xml
  def destroy
    @klass = Klass.find(params[:id])
    @klass.destroy

    respond_to do |format|
      format.html { redirect_to(klasses_url) }
      format.xml  { head :ok }
    end
  end
  
  # Start - Filter subject by programme name -- 4 May 2012
  def view_subject
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      @subjects = Subject.find(:all, :joins => :programmes,:conditions => ['programme_id=?', @programme_id])
    end
    render :partial => 'view_subject', :layout => false
  end
  # End -Filter subject by programme name -- 4 May 2012
end
