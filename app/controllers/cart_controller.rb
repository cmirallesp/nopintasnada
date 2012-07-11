class CartController < ApplicationController

  # GET /products
  # GET /products.xml
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end


  # GET /products/edit/1
  # GET /products/edit.xml
  # configuracion de bamba (modelo, color, cordon)
  def edit    
    params[:edit] = true
    @param =params[:id]

    regEx =  params[:id].match(/(\d{3})([ABC])(\d{2})/)
    @model = regEx[1]
    @color =   regEx[2]
    @cordill = regEx[3]

    @p = Product.find_by_model(@model)
  end

  # Añade un item al carro de la compra
  def add    
    #lectura de parametres
    pr_id    = params[:id]
    pr_color = params[:color]
    pr_talla = params[:talla]
    pr_cord  = params[:cordill]

    #id per una hash format per la concatenacio de tots ells
    @id       = "#{pr_id}#{pr_color}#{pr_cord}#{pr_talla}"

    #carrito=entrada al hash de sessio
    #s_id     = session[:session_id]
    #@carrito  = session[s_id]    

    session[:cart]||={}

    @cart=session[:cart]

    #si existeix..
    if (@cart[@id])       
      #..afegim una unitat
      @cart[@id][:unitats] = @cart[@id][:unitats].to_i + 1            
    else   
      #buscamos el producto para el precio i la descripcion
      p=Product.find_by_model(pr_id)        
      #..afegim una nova entrada al hash
      @cart[@id] = { :model => pr_id, 
                     :color   => pr_color,
                     :talla   => pr_talla,
                     :cordill => pr_cord,
                     :preu    => p.preu,                       
                     :unitats => 1
      }          
    end

    @total,@envio = get_total_envio

  end

  def get_promocode
    promo = Promocode.find_by_code(params[:id])
    @code=""
    @cart = session[:cart]
    @error = nil		

    @error = "El Promo-code introducido no es válido" if !promo
    @error = "El Promo-code introducido ha caducado" if promo && promo.end_date<Date.today		
    @error = "El Promo-code introducido ya ha sido utilizado"		if promo && !promo.state

    if !@error   	
      session[:promocode] = params[:id]
      session[:promocode_val] = promo.value

      @total,@envio = get_total_envio   		
    else 
      session[:promocode] = nil
      session[:promocode_val] = 0
    end
    
    respond_to do |format|
      format.js {	
        render :update do |page|
          page[:promocode].replace :partial=>"promo"
        end 

      }                    
    end
  end

  #elimina un elemento del carro (ajax)
  def remove
    @cart=session[:cart]
    pr_id=params[:item].match(/\d{3}[ABC]\d{4}/).to_s
    @cart.delete(pr_id)
    total,envio=get_total_envio

    respond_to do |format|
      format.js {
        #recargamos la lista si no hay items (se autoredireccionara a un html q indica lista vacía)
        if total==0
          render :update do |page|
            page[:contingut].replace :partial=>"/cart/empty_cart"
          end    
        else 
          @total = total 
          @envio = envio
        end
      }                    
    end
  end

  #método llamado via ajax al canviar el numero de unidades a comprar.
  #actualiza: el total linea, el total del carro y los gastos de envio
  def update_cart
    @cart=session[:cart]
    model=params[:model]  
    #actualizamos el carro con el nuevo valor
    @cart[model][:unitats]=params[:value]

    total,envio=get_total_envio

    respond_to do |format|
      format.js {
        @total     = total
        @envio     = envio
      }
    end
  end 

  # get cart/cart
  def cart
    @cart = session[:cart]||{}
    @total,@envio = get_total_envio  
  end

  #muestra los datos del comprador
  def buy
    if session[:buyer]
      params[:frm] = session[:buyer]
    end   
  end  

  #Pedimos los datos del comprador y redireccionamos a paypal
  def buyIt
    buyer = Buyers.new()

    buyer.nombre = params[:nombre]
    buyer.email  = params[:email]
    buyer.idioma   = params[:idioma]
    buyer.conocio= params[:conocio]
    buyer.save()
    session[:buyer]=buyer

    redirect_to "/cart/payPal"
  end

  #enviamos un email de contacto
  def addContact
    contact={
      :xml => "<nombre> #{params[:nombre]}</nombre></br><ap1> #{params[:ap1]}</ap1>" + 
      "<ap2> #{params[:ap2]}</ap2><telf> #{params[:telf]}</telf>" +
      "<email>#{params[:email1]}</email>" +
      "<npedido>#{params[:nombre]}</npedido>"+
      "<obs>#{params[:mensaje]}</obs>",
      :email => params[:email1],
      :nombre => params[:nombre]            
    }
    ContactMailer.deliver_new_contact(contact)
    #contact.save
    redirect_to "/cart/contacto_gracias"
    #contact.email2 =
  end

  #accion que muestra los datos de  contacto
  def contacto
    render :layout => "contacto" 
  end

  def payPal
    @cart=session[:cart]
    @total,@envio = get_total_envio
    @total = @total 
    if session[:promocode] then
      #invalidamos el promocode
      p=Promocode.find_by_code(session[:promocode])
      p.state = false
      p.save()
      #restamos el valor del promocode al primer elemento del carro
      @promo = session[:promocode_val]  	    
    end
    session[:promocode]=nil
    session[:promocode_val]=0
    render :layout=>false
  end  
  #accion de gracias cuando hemos realizado la compra
  def gracias
    #session[:buyer].save if session[:buyer] 
    session[:cart] = {} #vaciamos la cesta
  end  

  def contacto_gracias
    render :layout=>"contacto"
  end 

  def list
    @banner = Configuration.find_by_key('banner').value
  end

  def list2
    @banner = Configuration.find_by_key('banner').value
  end

  private   
  def get_total_envio
    total=0
    unitats=0
    sum_units=0
    #caculamos el total del carro
    @cart.each do |k,v|     
      unitats =  v[:unitats].to_i      
      sum_units += unitats
      total = total + unitats.to_i*v[:preu].to_f      
    end
    envio = (((sum_units-1) / 2)+1) * 10
    return total,envio
    #return total+envio,envio
  end 
end
