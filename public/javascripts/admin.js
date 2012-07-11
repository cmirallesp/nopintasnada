function delete_promocode(promo_id,url){
	if (confirm('¿Estas seguro?')) 
	{	var f = document.createElement('form'); 
		f.style.display = 'none'; 
		document.getElementById("frm").appendChild(f); 
		f.method = 'POST'; 
		f.action = "delete_promocode";
		
	/*	var m = document.createElement('input'); 
		m.setAttribute('type', 'hidden'); 
		m.setAttribute('name', '_method'); 
		m.setAttribute('value', 'delete'); 
		f.appendChild(m);
		*/									
		var g = document.createElement('input'); 
		g.setAttribute('type', 'hidden'); 
		g.setAttribute('name', 'id'); 
		g.setAttribute('value', promo_id); 
		f.appendChild(g);
											
		var s = document.createElement('input'); 
		s.setAttribute('type', 'hidden'); 
		s.setAttribute('name', 'authenticity_token'); 
		s.setAttribute('value', encodeURIComponent('/3p+p0v+kNMhwiZ/5j9ifLLL4K+duWetSIB9nvCTMNA=') ); 
		f.appendChild(s);
		
		f.submit(); 
	};
	return false;
}
