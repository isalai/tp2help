<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="tp1.css">
<link rel="stylesheet" type="text/css" href="tp1.css">
<title>TP2</title>
</head>
<body>

<%!
	public static final int NB_ROWS = 15;

	public static final double TAUX_TPS = 5;
	public static final double TAUX_TVQ = 9.975;
	public static final String QUÉBEC = "Québec";
	public static final String CANADA = "Canada";
%>

<%
    if (request == null || request.getParameter("donneesFacturation") == null) {
    	%>

		<form method='POST' enctype='multipart/form-data'>
	    	Numéro première facture : <input type='text' name='noPremiereFacture' />
	    	<br>Date de facturation : <input type='text' name='dateFacture' />
	    	<br>Données facturation : <input type='file' name='donneesFacturation' />
	    	<br><input type='submit' value='Produire factures' />
   		</form>
   		<%
    	
    } else {
%>



<table>
	<tr>
		<td class='logo'><img height='40px' src='at.png' /><td>
		<td class='adresse-co'>Technologies AT
			<br>3000 Ch. Côte-Ste-Catherine
			<br>Montréal (Québec) Canada
			<br>H3T 3A7
		</td>
		<td class='no-facture'>FACTURE 1234
			<br>25 septembre 2017
		</td>
	</tr>
</table>

<table>
<tr>
	<th class='titre-adresse-cl'>FACTURÉ À</th>
	<th class='titre-adresse-cl'>LIVRÉ À</th>
</tr>
	<tr>
		<td class='adresse-cl'>
			<%
			out.print(request.getParameter("FactNomClient"));
		    out.print("<br>"+request.getParameter("FactAdresse"));
		    out.print("<br>"+request.getParameter("FactVille")+" ("+request.getParameter("FactProvince")+") "+request.getParameter("FactPays"));
		    out.print("<br>"+request.getParameter("FactCodePostal"));
		    %>
	    </td>
		<td class='adresse-cl'>
			<%
			out.print(request.getParameter("LivrNomClient"));
		    out.print("<br>"+request.getParameter("LivrAdresse"));
		    out.print("<br>"+request.getParameter("LivrVille")+" ("+request.getParameter("LivrProvince")+") "+request.getParameter("LivrPays"));
		    out.print("<br>"+request.getParameter("LivrCodePostal"));
		    %>
	    </td>
	</tr>
</table>

<table class='details'>
	<tr class='gris'>
		<th class='qte blanc'>Qté</th>
		<th class='desc blanc'>Description</th>
		<th class='prix blanc'>Prix Unit.</th>
		<th class='total blanc'>Total</th>
	</tr>
	
<%
	int quantité = Integer.parseInt(request.getParameter("quantite"));
	double prixUnitaire = Double.parseDouble(request.getParameter("prixUnitaire"));
	
	String paysClient = request.getParameter("pays");
	String provinceClient = request.getParameter("province");
	
	double prixAvantTaxes = quantité * prixUnitaire;

	double tps= 0;
	double tvq = 0;
	if (CANADA.equals(paysClient)) {
		tps = Math.ceil(prixAvantTaxes * TAUX_TPS) / 100;
		if (QUÉBEC.equals(provinceClient)) {
			tvq = Math.ceil(prixAvantTaxes * TAUX_TVQ) / 100;
		}
	}
	double prixAprèsTaxes = prixAvantTaxes + tps + tvq;

	for (int iRow=0;iRow < NB_ROWS;iRow++) {
    	%>
   	<tr class='gris'>
   		<%
   		if (iRow == 0) {
			out.print("<td class='droite qte'>"+String.valueOf(quantité)+"</td>");
			out.print("<td class='desc'>"+request.getParameter("produit")+"</td>");
			out.print("<td class='droite prix'>"+String.valueOf(prixUnitaire)+"</td>");
			out.print("<td class='droite total'>"+String.valueOf(prixAvantTaxes)+"</td>");
   		} else {
			out.print("<td class='droite qte'>&nbsp;</td>");
			out.print("<td class='desc'>&nbsp;</td>");
			out.print("<td class='droite prix'>&nbsp;</td>");
			out.print("<td class='droite total'>&nbsp;</td>");
   		}
   		%>
    </tr>
		<%
	}
%>

	<tr>
		<td colspan='3' class='droite final'>Sous-Total</td>
		<td class='droite total'>
			<%
			out.print(String.valueOf(prixAvantTaxes));
			%>
		</td>
	</tr>
	<tr>
		<td colspan='3' class='droite final'>TPS/TVH</td>
		<td class='droite total'>
			<%
			out.print(String.valueOf(tps));
			%>
		</td>
	</tr>
	<tr>
		<td colspan='3' class='droite final'>TVP</td>
		<td class='droite total'>
			<%
			out.print(String.valueOf(tvq));
			%>
		</td>
	</tr>
	<tr>
		<th colspan='3' class='droite final'>Total</th>
		<th class='droite total'>
			<%
			out.print(String.valueOf(prixAprèsTaxes));
			%>
		</th>
	</tr>
</table>
<p>Payable 30 jours</p>
<p>
	Numéro TPS/TVH : 12345678910
	<br>Numéro TVP : 12345678910
</p>
<%
	} %>

</body>
</html>