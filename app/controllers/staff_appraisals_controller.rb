class StaffAppraisalsController < ApplicationController
  # GET /staff_appraisals
  # GET /staff_appraisals.xml
  
  filter_resource_access
  
  def index
    all2a=StaffAppraisal.with_permissions_to(:index)
    @filters=StaffAppraisal.filters(all2a)
    if params[:show] && params[:search]
      @staff_appraisals = StaffAppraisal.with_permissions_to(:index).search(params[:show], params[:search])
    else
      @staff_appraisals = StaffAppraisal.with_permissions_to(:index).find(:all, :order => 'evaluation_year DESC, staff_id ASC')
    end
    @staff_appraisals = @staff_appraisals.paginate(:per_page => 20, :page => params[:page]) 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_appraisals }
      format.js
    end
  end

  # GET /staff_appraisals/1
  # GET /staff_appraisals/1.xml
  def show
    @staff_appraisal = StaffAppraisal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff_appraisal }
      format.js
    end
  end

  # GET /staff_appraisals/new
  # GET /staff_appraisals/new.xml
  def new
    @staff_appraisal = StaffAppraisal.new
    @staff_appraisal.staff_appraisal_skts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff_appraisal }
    end
  end

  # GET /staff_appraisals/1/edit
  def edit
    @staff_appraisal = StaffAppraisal.find(params[:id])
    #2.times {@staff_appraisal.staff_appraisal_skts.build}
    if params[:job_type] && params[:job_level]
      @job_type=params[:job_type] #redo_performance
      @job_level=params[:job_level]
    end
  end

  # POST /staff_appraisals
  # POST /staff_appraisals.xml
  def create
    @staff_appraisal = StaffAppraisal.new(params[:staff_appraisal])

    respond_to do |format|
      if @staff_appraisal.save
        format.html { redirect_to(@staff_appraisal, :notice => t('evaluation.appraisal.title')+" "+t('updated')) }
        format.xml  { render :xml => @staff_appraisal, :status => :created, :location => @staff_appraisal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff_appraisal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staff_appraisals/1
  # PUT /staff_appraisals/1.xml
  def update
    @staff_appraisal = StaffAppraisal.find(params[:id])
    respond_to do |format|
      if @staff_appraisal.update_attributes(params[:staff_appraisal])
        format.html { redirect_to(@staff_appraisal, :notice => t('evaluation.appraisal.title')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :job_type=>"redo_performance", :job_level => "skt_revision"}
        format.xml  { render :xml => @staff_appraisal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staff_appraisals/1
  # DELETE /staff_appraisals/1.xml
  def destroy
    @staff_appraisal = StaffAppraisal.find(params[:id])
    @staff_appraisal.destroy

    respond_to do |format|
      format.html { redirect_to(staff_appraisals_url) }
      format.xml  { head :ok }
    end
  end
  
  def appraisal_form
    @staff_appraisal = StaffAppraisal.find(params[:id])
    render :layout => 'report'
  end
  
  
end
