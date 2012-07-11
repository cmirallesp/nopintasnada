function initialIma(){
var i=Math.floor(Math.random()*3)+1;
 document.getElementById('ima').src="images/portada0"+i+".jpg";
}
/*devuelve el nombre de la imagen principal*/
function getImaName(){
  return document.getElementById('foto_A').name;
}

function getModel(){
 return getImaName().match(/^\d{3}/); 
}

function getColor(){
 return getImaName().match(/[ABC]/); 
}

function getCordill(){
  return getImaName().replace(/^(\d{3}[ABC])/,"");
}
/**
 * Recalcula el total de la linea, el subtotal y los gastos de envio..
 * Hace una peticion ajax para actualizar els carrito del servidor
 */
function setUnitats(id){
  var p='pu_'+id
  /*alert(p+"-"+$(p.innerHTML))
  */
  new Ajax.Request('/cart/update_cart', 
  { asynchronous:true, 
    evalScripts:true, 
    parameters:'model='+id
              +'&value='+$(id).value
              +'&preu_unit='+$(p).innerHTML                            
   });  
}

/**
 * canvia las 4 imagenes de las bambas en funcion de la marca, el color y el cordon via ajax
 */
function changeImas(model,color,cordill)
{
  new Ajax.Request('/cart/update_ima', 
  { asynchronous:true, 
    evalScripts:true, 
    parameters:'model='+model
              +'&color='+color
              +'&cordill='+cordill
}); 
/*,
		onComplete: function(transport){
$('ifrmFcbk').src="http://www.facebook.com/plugins/like.php?href=www.nopintasnada.com/cart/edit/"+getModel()+getColor()+getCordill();
   }*/
   
  return false;
}

/**
 * elimina un item del carro
 */
function removeFromCart(item){
 new Ajax.Request('/cart/remove', 
  { asynchronous:true, 
    evalScripts:true, 
    parameters:'item='+item              
   }); 
   
  return false;
} 
  
/**
 * añade al carro el elemento actual 
 */
function addToCart()
{ 
  if ($("sel_color").value=="0"){
    alert("Selecciona el color de tu zapatilla");
    return false;
  }

  
  if ($("sel_talla").value=="0"){
    alert("Selecciona tu talla");
    return false;
  }
  
  
  if ($("sel_cordo").value=="0"){
    alert("Selecciona tu cordón");
    return false;
  }
  
  var f=$("frm")
  $("color").value    = getColor();
  $("id").value       = getModel();
  $("cordill").value  = getCordill();
  $("talla").value    = talla;
  $("authenticity_token").value    = $("fat").value   ;
   
  f.submit( );
  
  return false;
}

function swatFoto( id, imagen )
{
    document.getElementById( id ).src = imagen;
}

/**
 * canvia la imagen segun la talla 
 */
function marcaTalla( id )
{  document.getElementById('35').src = '/images/t35.gif';
   document.getElementById('36').src = '/images/t36.gif';
   document.getElementById('37').src = '/images/t37.gif';
   document.getElementById('38').src = '/images/t38.gif';
   document.getElementById('39').src = '/images/t39.gif';
   document.getElementById('40').src = '/images/t40.gif';   
   document.getElementById('41').src = '/images/t41.gif';
   document.getElementById('42').src = '/images/t42.gif';
   document.getElementById('43').src = '/images/t43.gif';
   document.getElementById('44').src = '/images/t44.gif';
   document.getElementById('45').src = '/images/t45.gif';
   document.getElementById('46').src = '/images/t46.gif';
   
   document.getElementById( id ).src = '/images/t' + id + 'x.gif';
   $("sel_talla").value="1";
	 talla=id;
}

/**
 * canvia la imagen del cordon
 */
function marcaCordo( id )
{
	
   document.getElementById('01').src = '/images/01.jpg';
   document.getElementById('02').src = '/images/02.jpg';
   document.getElementById('03').src = '/images/03.jpg';
   document.getElementById('04').src = '/images/04.jpg';
   document.getElementById('05').src = '/images/05.jpg';
   document.getElementById('06').src = '/images/06.jpg';
   document.getElementById('07').src = '/images/07.jpg';
   document.getElementById('08').src = '/images/08.jpg';
   document.getElementById('09').src = '/images/09.jpg'; 
   
   document.getElementById( id ).src = '/images/' + id + 'x.jpg';
   $("sel_cordo").value="1";
   changeImas(getModel(),getColor(),id);
}

function marcaColorCordo(){
	marcaCordo(getCordill());
	marcaColor(getModel(),getColor());
	return;
}
/*
 * canvia la imagen segun el color de la bamba (num:model de la bamba, lletra: color a marcar)
*/

function marcaColor( num, lletra )
{
	
   document.getElementById('A').src = '/images/' + num + 'A.jpg';
   document.getElementById('B').src = '/images/' + num + 'B.jpg';
   document.getElementById('C').src = '/images/' + num + 'C.jpg';
   
   document.getElementById( lletra ).src = '/images/' + num + lletra + 'x.jpg';
   
   changeImas(getModel(),lletra,getCordill());	
   $("sel_color").value="1";
}

function addContact(){
  if (!$("privacidad").checked)
    alert("Debes confirmar los terminos legales");  
  else if (!$("nombre").value.match(/\S/))
    alert ("Indicanos tu nombre, por favor.");
   else if (!$("email1").value.match(/\b[A-Z0-9a-z._%+-]+@[A-Z0-9a-z-]+\.[A-Za-z]{2,4}\b/))
    alert ("Indicanos tu email, por favor.");
  else if ($("email1").value!=$("email2").value)
    alert("El email no coincide");
  else{
    $("frm").submit();
  }
  return false;
}
/**
 * vamos a la pagina de compra (pedimos datos de contacto)
 */
function gotoBuy(){
  window.location="/cart/buy";
  return false;  
}

/**
 * compramos: post de los datos 
 */
function toBuy()
{ 
  if (!$("privacidad").checked)
    alert("Debes confirmar los terminos legales");
  else if (!$("nombre").value.match(/\S/))
    alert ("Indicanos tu nombre, por favor.");
  else if (!$("email").value.match(/\b[A-Z0-9a-z._%+-]+@[A-Z0-9a-z-]+\.[A-Za-z]{2,4}\b/))
    alert ("Indicanos tu email, por favor.");
  else{
    $("aut").value=$("fat").value;
    $("frm").submit();
  }
  
  return false;
}


/**
 * metodo que lleva al listado de bambas
 */
function gotoList(){
  window.location="/cart/list2";
  return false;  
}


/**
 * actualiza el valor del promocode
 */
function update_promo(promo){
 new Ajax.Request('/cart/get_promocode', 
  { asynchronous:true, 
    evalScripts:true, 
    parameters:'id='+promo
   }); 
   
  return false;
} 
