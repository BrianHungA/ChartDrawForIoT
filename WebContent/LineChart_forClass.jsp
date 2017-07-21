<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<script src="js/Chart.js"></script>
<script src="js/jquery-3.1.1.js"></script>
<style>
    .box{width:60%; float:left;}
    .zone{width:100%; height:100%;}
</style>
<script>
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Analysis Result</title>
</head>
<body>
<%@ taglib prefix="s" uri="/struts-tags"%>
	<div>
    	<canvas id="canvasLineChart" class="zone"></canvas>
	</div>	
	
	
	<script>
		var X_Time = <s:property value="json_X_Time_Axis" default="[]" escapeHtml="false" />;
		var Y_Vibrate = <s:property value="json_Y_Vibrate_axis" default="[]" escapeHtml="false"/>;
		var gps_X = <s:property value="json_gps_X" default="[]" escapeHtml="false"/>;
		var gps_Y = <s:property value="json_gps_Y" default="[]" escapeHtml="false"/>;
		var carSpeed = <s:property value="json_speed" default="[]" escapeHtml="false"/>;
		console.log("carSpeed = " + Math.min(carSpeed));
		var outputTarget = 200;
		var line_color = "#003377";
		var line_point_color = "#003C9D";
		
		
/* Data */
		var VibrateData = 
		{
			labels : X_Time,
			datasets : [
 					{
						type : 'line',
						label : 'Vibrate',
						fill : false,

							borderColor : "#444444", // line
						backgroundColor : "#444444",
						borderWidth : 2,
						tension : 0,

						pointBorderColor : "#666666", // point
						pointBackgroundColor : "#666666",
						pointRadius : 3,
						pointBorderWidth : 1,
						pointStyle : 'triangle',

						pointHoverRadius : 5, // hover 
						pointHoverBorderColor : "#666666",
						pointHoverBackgroundColor : "#666666",
						pointHoverBorderWidth : 3, 

						data : Y_Vibrate,
						yAxisID : 'y-axis-1'
					}, 
					{
						type : 'line',
						label : 'Speed',
						fill : false,

							borderColor : "#00FFFF", // line
						backgroundColor : "#00FFFF",
						borderWidth : 2,
						pointRadius : 0,
						tension : 0,
						data : carSpeed,
						yAxisID : 'y-axis-2'


						}]
		};
     	var horizonalLinePlugin = {
    		afterDraw: function(chartInstance) {
    		    var yScale = chartInstance.scales["y-axis-1"];
    		    var canvas = chartInstance.chart;
    		    var ctx = canvas.ctx;
    		    var index;
    		    var line;
    		    var style;

    		    if (chartInstance.options.horizontalLine) {
    		      for (index = 0; index < chartInstance.options.horizontalLine.length; index++) {
    		        line = chartInstance.options.horizontalLine[index];

    		        for(var j=0;j<line.y.length;j++){
	    		        if (!line.style[j]) {
	    		          style = "rgba(169,169,169, .6)";
	    		        } else {
	    		          style = line.style[j];
	    		        }
						
						console.log("line.y.length = " + line.y.length + ";line.y[j] = " + line.y[j]);
	    		        if (line.y[j]) {
	    		        	console.log("2");
	    		          yValue = yScale.getPixelForValue(line.y[j]);
	    		        } else {
	    		        	console.log("3");
	    		          yValue = 0;
	    		        }
	    		        console.log("4");
	
	    		        ctx.lineWidth = 3;
	
	    		        if (yValue) {
	    		        	console.log("5");
	    		          ctx.beginPath();
	    		          ctx.moveTo(0, yValue);
	    		          ctx.lineTo(canvas.width, yValue);
	    		          ctx.strokeStyle = style;
	    		          ctx.stroke();
	    		        }
	    		        console.log("6");
	    		        if (line.text) {
	    		        	console.log("7");
	    		          ctx.fillStyle = style;
	    		          ctx.fillText(line.text, 0, yValue + ctx.lineWidth);
	    		        }
	    		        console.log("8");
					}
					console.log("9");
    		      }
    		      return;
    		    };
    		  }
    		};
    		Chart.pluginService.register(horizonalLinePlugin);
 
/* Option */
		var VibrateOption = {
				title: {
					display: true,
					text: "Fail Trend Chart",
					fontSize: 16
				},
				elements : {
					line : {
						fill : false
					}
				},
				tooltips: {
			        mode: 'index',
			        intersect: true
			    },
	            "horizontalLine": [{
	        		y: ["200", "-200","400","-400"],
	        		style: ["#66DD00","#66DD00","#A21D21" , "#A21D21",]
	        		/* text: "target" */
	            }],
				scales : {
					xAxes : [ {
						display : true,
						gridLines : {
							/* display : true,
							lineWidth: 2 */
							/* color: "black",
							zeroLineColor: "black" */
						},
						scaleLabel: {
							display: true,
							labelString: "Time Period"
			            },
			            ticks: {
			            	autoSkip: true,
/* 			            	fontSize: 8,
			            	maxRotation: 90,
			            	minRotation: 90 */
			            }
					} ],
					yAxes : [  {
						type : "linear",
						display : true,
						position : "left",
						id : "y-axis-1",
						ticks : {
							/* min: 0, */
							userCallback: function(value, index, values) {
								return value.toString();
							}
						},
						gridLines : {
							display : true
						},
						scaleLabel: {
							display: true,
							labelString: "Vibrate"
			            }
					}, {
						type : "linear",
						display : true,
						position : "right",
						id : "y-axis-2",
						ticks : {
							min: 0,
							userCallback: function(value, index, values) {
								return value.toString();
							}
						},
						gridLines : {
							display : true
						},
						scaleLabel: {
							display: true,
							labelString: "Speed"
			            }
					}]
				}
			};

/* Horizontal Line */

/* Draw Chart */
			var VibrateChartDraw = {
					type : 'line',
					data : VibrateData,
					options : VibrateOption
				};

			var ctxVibrate = document.getElementById("canvasLineChart").getContext("2d");
			var myFailTrendchart = new Chart(ctxVibrate, VibrateChartDraw);
				
		
		
	</script>
</body>
</html>