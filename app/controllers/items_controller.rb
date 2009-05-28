class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    case params[:order]
    when 'priority'
      @items = Item.find(:all, :order => 'priority,due_date')
    when 'description'
      @items = Item.find(:all, :order => 'description,due_date')
    when 'category'
      @items = Item.find(:all, :include => 'category', :order => 'categories.category,due_date')
    else
      @items = Item.find(:all, :order => 'due_date,priority')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @categories = Category.find(:all)
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @categories = Category.find(:all)
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    begin
      @item = Item.new(params[:item])
      if @item.save
        respond_to do |format|
          flash[:notice] = 'Item was successfully created.'
          format.html { redirect_to(items_url) }
          format.xml  { render :xml => @item, :status => :created, :location => @item }
        end
      else
        railse
      end
    rescue
      respond_to do |format|
        flash[:notice] = 'Item could not be saved.'
        @categories = Category.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(items_url) }
        format.xml  { head :ok }
      else
        @categories = Category.find(:all)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end

  def purge_completed
    Item.destroy_all "done = 't'"
    redirect_to :action => 'index'
  end

  def updater
    params[:item].each do |item_id, attr|
      item = Item.find(item_id)
      if item.done != eval(attr[:done])
        item.update_attribute(:done,attr[:done])
      end
    end
    redirect_to(items_url)
  end
end
