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
	var outputTarget = 200;
	alert("out = " + outputTarget);

    var BarData = {
    	    labels: ["January", "February", "March", "April", "May", "June", "July"],
    	    datasets: [
    	        {
    	            label: "My First dataset",
    	            backgroundColor: [
    	                'rgba(255, 99, 132, 0.2)',
    	                'rgba(54, 162, 235, 0.2)',
    	                'rgba(255, 206, 86, 0.2)',
    	                'rgba(75, 192, 192, 0.2)',
    	                'rgba(153, 102, 255, 0.2)',
    	                'rgba(255, 159, 64, 0.2)'
    	            ],
    	            borderColor: [
    	                'rgba(255,99,132,1)',
    	                'rgba(54, 162, 235, 1)',
    	                'rgba(255, 206, 86, 1)',
    	                'rgba(75, 192, 192, 1)',
    	                'rgba(153, 102, 255, 1)',
    	                'rgba(255, 159, 64, 1)'
    	            ],
    	            borderWidth: 1,
    	            data: [65, 59, 80, 81, 56, 55, 40],
    	        }
    	    ]
    	};
    var optionsAxis = {
            "horizontalLine": [{
        		y: outputTarget,
        		style: "#A21D21"
        		/* text: "target" */
            }],
            scales: {
                xAxes: [{
                    //type: 'linear',
                    type:'time',
                    position: 'bottom'

                    
                }]
            },
            tooltips:{
    			mode: 'nearest',
    			intersect: true,
    			
                },
 
        };
    $(function(){

        // Line Chart
    	//var ctx_Line = document.getElementById("charterLine").getContext("2d");
    	//var myLine = new Chart(ctx_Line,{type:'line',data:lineAxis,options:optionsAxis});
		
    	// Bar Chart
    	var ctx_Bar = document.getElementById("charterBar").getContext("2d");
    	var myBar =new Chart(ctx_Bar, {
    	    type: "bar",
    	    data: BarData,
    	    options: {
    	    	title: {
    	    	      display: true,
    	    	      text: 'Chart.js Draw Line On Chart'
    	    	    },
                    horizontalLine: [{
                		y: outputTarget,
                		style: "#A21D21"
                		/* text: "target" */
                    }],
    	        scales: {
    	            xAxes: [{
    	                stacked: true
    	            }],
    	            yAxes: [{
    	                stacked: true
    	            }]
    	        }

    	    }
    	});
    	var horizonalLinePlugin = {
    			afterDraw: function(chartInstance) {
    		    var yScale = chartInstance.scales["y-axis-0"];
    		    var canvas = chartInstance.chart;
    		    var ctx = canvas.ctx;
    		    var index;
    		    var line;
    		    var style;

    		    if (chartInstance.options.horizontalLine) {
    		      for (index = 0; index < chartInstance.options.horizontalLine.length; index++) {
    		        line = chartInstance.options.horizontalLine[index];

    		        if (!line.style) {
    		          style = "rgba(169,169,169, .6)";
    		        } else {
    		          style = line.style;
    		        }

    		        if (line.y) {
    		          yValue = yScale.getPixelForValue(line.y);
    		        } else {
    		          yValue = 0;
    		        }

    		        ctx.lineWidth = 3;

    		        if (yValue) {
    		          ctx.beginPath();
    		          ctx.moveTo(0, yValue);
    		          ctx.lineTo(canvas.width, yValue);
    		          ctx.strokeStyle = style;
    		          ctx.stroke();
    		        }

    		        if (line.text) {
    		          ctx.fillStyle = style;
    		          ctx.fillText(line.text, 0, yValue + ctx.lineWidth);
    		        }
    		      }
    		      return;
    		    };
    		  }
    		};
    		Chart.pluginService.register(horizonalLinePlugin);

    	//index.jsp TEST
     	alert("123");
    	<% 
    		String reqUserName = request.getParameter("userName");
    		String reqChartName = request.getParameter("chartNames");
    	%>
    	alert("456");
    	var userName1 = "<%=reqUserName%>";
    	var chartName1 = "<%=reqChartName%>";
    	alert("userName = " + userName1 + ";ChartName = " + chartName1);
     	//  ============CSSSSSSV TEST==============
		var dataLabel = [];
		var dataPoints = [];
//		var urlcsv  = "Data/gpssensor.csv";
//		var urlcsv1 = "Data/daja.csv";
		var urlcsv_mingshen_2 = "Data/min_shen_2.csv";
//		var urlcc = "D:/My Documents/Desktop/min_shen_2.csv"
//		var urlcsv0 = "Data/dataPoints.csv"
//		var urlcsvGit = "https://raw.githubusercontent.com/BrianHungA/ChartDraw/master/WebContent/Data/daja.csv";
        $.ajax({
			url:urlcsv_mingshen_2,
			dataType:"text",
			success: function(data) {
				
				var csvLines = [];
	            var points = [];

	            csvLines = data.split(/\n+/);
	            alert("AA:csvLines[1] = " + csvLines[1] + "csvLines.length = " + csvLines.length);
	            //��j���ʪ��I�A����Show�X��
/*   	            for (var i = 0; i < csvLines.length; i++){
		                if (csvLines[i].length > 0) {
		                    points = csvLines[i].split(",");
		                    if(Math.abs(points[4])>=200){
			                    dataPoints.push({ 
			                        x: points[0],
			                        y: parseFloat(points[4]),
			                        //r: 5 		
			                    });
		                    }
			                    
		                }
	            };
 */  				
 				var points1 = [];
				var points2 = [];
				var MaxValue = -500;
				var minValue = 500;
				var iii = 0;
				var jjj = 0;
				var kkk = 0;
				var dataColumn = 4;
//Start
 				for(var i = 0; i <csvLines.length; i++){
					if(csvLines[i].length > 0 && csvLines[i+1].length > 0){
						points1 = csvLines[i].split(",");
						points2 = csvLines[i+1].split(",");
						var dateTime1 = points1[0].replace(/-/g,"/").substring(0,points1[0].indexOf("."));
						var dateTime2 = points2[0].replace(/-/g,"/").substring(0,points2[0].indexOf("."));
						/* console.log("dateTime1 = " + dateTime1) */
						if(dateTime1 == dateTime2){
							if(parseFloat(points1[dataColumn])>=MaxValue){
								MaxValue = points1[dataColumn];
							}else if(parseFloat(points1[dataColumn])<=minValue){
								minValue = points1[dataColumn];
								};
							jjj++;
						}else{
							dataPoints.push({ 
		                        x: points1[0].substring(0,points1[0].indexOf(".")),
		                        y: parseFloat(MaxValue),
							});
							dataPoints.push({ 
		                        x: points1[0].substring(0,points1[0].indexOf(".")),
		                        y: parseFloat(minValue),
							}); 
							kkk++;
							MaxValue = -500;
							minValue = 500;
							}
						}
						
					};
//End
  				alert("dataPointsYYY = " + dataPoints[2] + ";iii = " + iii+ ";jjj = " + jjj +";kkk = " + kkk);
				var DataPlotPoint = {
						datasets: [{
				            //label: 'Scatter Dataset',
				            data: dataPoints
				        }]
						};
	            var ctx_CSVLine = document.getElementById("charterCSVLine").getContext("2d");
	            var CSVChart = new Chart(ctx_CSVLine, {
	    		    type:"line",
	    		    data: DataPlotPoint,
	    		    options :optionsAxis
	    		      });
			}
        });
    });
    	</script>

<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Analysis Result</title>
</head>
<body>

	<div class="box">
    	<canvas id="charterBar" class="zone"></canvas>
	</div>
	<br>
	<div>
    	<canvas id="charterCSVLine" class="zone"></canvas>
	</div>
</body>
</html>
