<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/Chart.js"></script>
<script src="js/jquery-3.1.1.js"></script>
<script src="js/"></script>
<style>
    .box{width:60%; float:left;}
    .zone{width:100%; height:100%;}
</style>
<script>

	
	// TESTTTTTTT
	var lineAxis = {
	        datasets: [{
	            label: 'Scatter Dataset',
	            data: [{x: -10,y: 0}, 
		               {x: 0,y: 10}, 
		               {x: 10,y: 5}]
	        }]
	    };
    var optionsAxis = {
        scales: {
            xAxes: [{
                //type: 'linear',
                type:'time',
                position: 'bottom'

                
            }]
        },
        tooltips:{
			mode: 'index',
			intersect: true
            }
    };


    // TESTTTTTT END
    var lineChartData = {
    	    labels : ["January","February","March","April","May","June","July"],
    	    datasets : [
    	      {
    	        fillColor : "rgba(220,220,220,0.5)",
    	        strokeColor : "rgba(220,220,220,1)",
    	        pointColor : "rgba(220,220,220,1)",
    	        pointStrokeColor : "#fff",
    	        data : [65,59,90,81,56,55,40]
    	      },
    	      {
    	        fillColor : "rgba(151,187,205,0.5)",
    	        strokeColor : "rgba(151,187,205,1)",
    	        pointColor : "rgba(151,187,205,1)",
    	        pointStrokeColor : "#fff",
    	        data : [28,48,40,19,96,27,100]
    	      }
    	    ]     
    	  };
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

    	
    	//  ============CSSSSSSV TEST==============
		var dataLabel = [];
		var dataPoints = [];
		var urlcsv  = "Data/gpssensor.csv";
		var urlcsv1 = "Data/daja.csv";
		var urlcsv0 = "Data/dataPoints.csv"
        $.ajax({
			url:urlcsv1,
			dataType:"text",
			success: function(data) {
				
				var csvLines = [];
	            var points = [];

	            csvLines = data.split(/\n+/);
	            alert("AA:csvLines[1] = " + csvLines[1,0] + "csvLines.length = " + csvLines.length);
	            for (var i = 0; i < csvLines.length; i++){
	            	//for (var i = 0; i < 3000; i++){
		                if (csvLines[i].length > 0) {
		                    points = csvLines[i].split(",");
		                    if(Math.abs(points[3])>=200){
			                    dataPoints.push({ 
			                        x: points[0],
			                        y: parseFloat(points[3]),
			                        r: 5 		
			                    });
		                    }
			                    
		                }
	            };
				alert("dataPointsYYY = " + dataPoints[2]);
				var DataPlotPoint = {
						datasets: [{
				            //label: 'Scatter Dataset',
				            data: dataPoints
				        }]
						};
	            var ctx_CSVLine = document.getElementById("charterCSVLine").getContext("2d");
	            var CSVChart = new Chart(ctx_CSVLine, {
	    		    type:"bubble",
	    		    data: DataPlotPoint,
	    		    options :optionsAxis
	    		      });
			},
        });
        alert("OUTERCTX!")
        /* 		var tt = getDataPointsFromCSV(csvData);
		alert("tt = " + tt); */
    	


    	// ==========CSSSSSSV END===================
    	
    });
    	</script>

<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
	<div class="box">
    	<canvas id="charterLine" class="zone"></canvas>
	</div>
	<div class="box">
    	<canvas id="charterBar" class="zone"></canvas>
	</div>
	<br>
	<div>
    	<canvas id="charterCSVLine" class="zone"></canvas>
	</div>
</body>
</html>