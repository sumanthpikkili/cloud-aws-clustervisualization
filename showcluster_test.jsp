<!--  
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course Number: CSE 6339 (Cloud Computing)
Assignment 5: Visualizing Clustering
 -->

<!doctype html>
<html>
<head>

<!--  Internal Style Sheet  -->

<style>
body {
	margin: 1px;
}

.h, .v {
	stroke-dasharray: 5 5;
	stroke-width: 1;
	stroke-opacity: .5;
}

.axis path, .axis line {
	fill: none;
	stroke: black;
	shape-rendering: crispEdges;
}

.axis text {
	font-family: sans-serif;
	font-size: 12px;
}
</style>


<title>Cluster Visualization</title>
<script src="http://d3js.org/d3.v3.min.js">
	
</script>
<script
	src="https://raw.githubusercontent.com/joewalnes/smoothie/master/smoothie.js">
	
</script>
<body>
	<canvas id="mycanvas" width="400" height="100"></canvas>
	<div>
		<script>
			var width = 500, height = 500, margin = 50;
			//Get the number of clusters
			var clustnumb =
		<%=request.getAttribute("k")%>
			//Declaring color array to color each cluster
			var colors = [ "green", "red", "blue", "orange", "yellow",
					"violet", "black" ]

			//Defining the Scalable Vector Graphics
			var svg = d3.select("body").append("svg").attr("width", width)
					.attr("height", height);
			var x = d3.scale.linear().domain([ 80, 150 ]).range(
					[ margin, width - margin ]);
			var y = d3.scale.linear().domain([ 130, 400 ]).range(
					[ height - margin, margin ]);

			var xAxis = d3.svg.axis().scale(x).orient("bottom");

			var yAxis = d3.svg.axis().scale(y).orient("left");

			//Appending the x-axis and y-axis to SVG

			svg.append("text") // text label for the x axis
			.attr("x", 225).attr("y", 490).style("text-anchor", "bottom").text(
					"Average Temperature");

			svg.append("g").attr("class", "axis").attr("transform",
					"translate(0," + (height - margin) + ")").text("avgtemp")
					.call(xAxis);

			svg.append("text").attr("transform", "rotate(-90)").attr("y", -200) //text label for the y axis
			.attr("x", -225).attr("dy", "1em").style("text-anchor", "middle")
					.text("Avg Precipitation");

			svg.append("g").attr("class", "axis").attr("transform",
					"translate(" + margin + ",0)").call(yAxis);

			//Fetching the json data
			var D3data =
		<%=request.getAttribute("clusterjson")%>
			var canvas = d3.select("body").append("svg").attr("width", width)
					.attr("height", height);

			//Plotting the cluster points on the graph
			svg.selectAll("circle").data(D3data).enter().append("circle").attr(
					"cx", function(d) {
						return x(+d.mag);
					}).attr("cy", function(d) {
				return y(+d.precp);
			}).attr("r", 4).attr("y", function(d, i) {
				return i * 5;
			}).attr("fill", function(d) {
				return colors[d.clusternum];
			})
		</script>
	</div>

	<div>
		<script>
			//Smoothie Chart for a random set of numbers
			var smoothie = new SmoothieChart();
			smoothie.streamTo(document.getElementById("mycanvas"));
			var line1 = new TimeSeries();
			var line2 = new TimeSeries();

			setInterval(function() {

				var now = new Date().getTime();
				line1.append(now, Math.random());
				line2.append(now, Math.random());

			}, 1000);

			var smoothie = new SmoothieChart({
				grid : {
					strokeStyle : 'rgb(125, 0, 0)',
					fillStyle : 'rgb(60, 0, 0)',
					lineWidth : 1,
					millisPerLine : 250,
					verticalSections : 6,
				},
				labels : {
					fillStyle : 'rgb(60, 0, 0)'
				}
			});
			smoothie.addTimeSeries(line1, {
				strokeStyle : 'rgb(0, 255, 0)',
				fillStyle : 'rgba(0, 255, 0, 0.4)',
				lineWidth : 3
			});
			smoothie.addTimeSeries(line2, {
				strokeStyle : 'rgb(255, 0, 255)',
				fillStyle : 'rgba(255, 0, 255, 0.3)',
				lineWidth : 3
			});
			smoothie
					.streamTo(document.getElementById("mycanvas"), 1000 /*delay*/);
		</script>

	</div>

</body>
</html>