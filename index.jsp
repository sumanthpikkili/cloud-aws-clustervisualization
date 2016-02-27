<!--  
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course Number: CSE 6339 (Cloud Computing)
Assignment 5: Visualizing Clustering
 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Internal Style Sheet  -->

<style>
.myButton {
	-moz-box-shadow: inset 0px 1px 0px 0px #97c4fe;
	-webkit-box-shadow: inset 0px 1px 0px 0px #97c4fe;
	box-shadow: inset 0px 1px 0px 0px #97c4fe;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #3d94f6
		), color-stop(1, #1e62d0));
	background: -moz-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
	background: -webkit-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
	background: -o-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
	background: -ms-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
	background: linear-gradient(to bottom, #3d94f6 5%, #1e62d0 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3d94f6',
		endColorstr='#1e62d0', GradientType=0);
	background-color: #3d94f6;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	border: 1px solid #337fed;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 4px 15px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #1570cd;
}

.myButton:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1e62d0
		), color-stop(1, #3d94f6));
	background: -moz-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
	background: -webkit-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
	background: -o-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
	background: -ms-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
	background: linear-gradient(to bottom, #1e62d0 5%, #3d94f6 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#1e62d0',
		endColorstr='#3d94f6', GradientType=0);
	background-color: #1e62d0;
}

.myButton:active {
	position: relative;
	top: 1px;
}
</style>


<title>Home Page</title>
</head>
<body background="back.jpg">
	<font color="white">
		<h1 align="center">Cluster Visualization</h1>
	</font>

	<!-- Form redirects to servlet which creates the clusters using k-means algorithm  -->

	<form id="form1" method="POST" action="wekacluster"
		enctype="multipart/form-data">
		<font color="white">
			<table ALIGN="CENTER">
				<tr>
					<td>File Upload
						(CSV)&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						<input type="file" id="fileupload" name="fileupload" accept=".csv"
						align="center" />
					</td>
				</tr>

				<tr>
					<td>Enter the number of clusters &nbsp&nbsp&nbsp <input
						type="text" name="clusters" id="k" />
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td align="center"><input type="submit" value="Show Clusters"
						align="center" class="myButton" /></td>
				</tr>
			</table>
		</font>
	</form>


</body>
</html>