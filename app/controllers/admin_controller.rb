

class AdminController < ApplicationController
  before_filter :check_authentication, :except => [:signin]

	#filtro para validar q el usuario esta logado en cualquier accion del controlador de administracion
  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name      
      redirect_to :action => "signin"
    end
  end

	#accion para logarse en la parte de administracion
	def signin
		if request.post?
			session[:user] = User.authenticate(params[:username], params[:password]).id
			redirect_to :action => session[:intended_action],:controller => session[:intended_controller]
		end

	end

	def signout
		session[:user] = nil
		redirect_to :action=>:signin
	end

	def index
	end

	def hello
		render :text => "hello"
	end

  def list_products
    @prds = Product.all(:order=>:model)
		@title = "Listado de productos"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prs }
    end
  end

  def edit_product
		@title = "Editar producto"
    @prd = Product.find(params[:id])
  end

	def update_product
		@prd = Product.find(params[:id])

		#if (params[:enabled]) &&  !(@prd.enabled)
		#	fileSrc = File.join(get_directory,"#{@prd.id}.jpg" ) 
		#	fileTrg = File.join(get_directory,"#{@prd.model}.jpg" )
		#	File.rename(fileSrc,fileTrg)  
		#elsif !(params[:enabled]) &&  (@prd.enabled)
		#	fileTrg = File.join(get_directory,"#{@prd.id}.gz" )		
		#	File.rename(fileSrc,fileTrg) 
		#end 

		respond_to do |format|
      if @prd.update_attributes(params[:prd])
        format.html { redirect_to(:action=>:list_products) }
      else
        format.html { render :action => "edit" }
      end
    end	
	end

	def edit_banner
		@title = "Editar banner"
    @cfg = Configuration.find_by_key("banner")
  end

	def update_banner
		@cfg = Configuration.find(params[:id])
		respond_to do |format|
      if @cfg.update_attributes(params[:cfg])
        format.html { redirect_to(:action=>:index) }
      else
        format.html { render :action => "edit" }
      end
    end	
	end

  def list_buyers
    @buyers = Buyers.all(:order=>:created_at)
		@title = "Listado de compradores"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prs }
    end
  end
  
	def delete_buyer
		@buy = Buyers.find(params[:id])
		@buy.delete()
		redirect_to(:action=>:list_buyers)
	end 
	def list_contacts
    @contacts = Contact.all(:order=>:created_at)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prs }
    end
  end

	def upload_ima1
		upload_imas("portada01.jpg",params['ima1'])
	end

	def upload_ima2
		upload_imas("portada02.jpg",params['ima2'])
	end

	def upload_ima3
		upload_imas("portada03.jpg",params['ima3'])
	end
	
#*******************PROMOCODES************************************
	def new_promocode
		@title ="Nuevo promocode"
		@prc = Promocode.new()
		@prc.code =  ""; 8.times{@prc.code  << (65 + rand(25)).chr}	
		@prc.start_date = Date.today
		@prc.state = true
	end

	def view_promocode
		@prc=Promocode.new(params[:promocode])
		if !@prc.valid?()
			render(:action=>:new_promocode) 		
		else			
			@prc.end_date = @prc.start_date + @prc.days
			@prc.save()
		end
	end
	
	def list_promocodes
		@prcs = Promocode.find(:all)
	end
	
	def delete_promocode
		@prc = Promocode.find(params[:id])
		@prc.delete()
		redirect_to(:action=>:list_promocodes)
	end 
	
	def make_codes
		610.times do
			p=Promocode.new()
			p.code =  ""; 8.times{p.code  << (65 + rand(25)).chr}	
			p.start_date = Date.today
			p.end_date = Date.today+29
			p.state = true
			p.days =29
			p.value =10
			p.save()
		end
	end

private

	def get_directory
		"#{RAILS_ROOT}/public/images"
	end

	def	upload_imas(filename,ima)
		if (ima)
			directory = get_directory
		  # create the file path
		  path = File.join(directory, filename)
		
			del_file(path)
    	# write the file
    	File.open(path, "wb") { |f| f.write(ima.read) }
		end if 
		redirect_to :action=>:set_imas
	end

	def del_file(filename)
		File.delete("#{filename}")  if File.exist?("#{filename}")	
	end



end
