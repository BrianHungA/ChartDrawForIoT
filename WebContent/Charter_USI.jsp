<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/Chart.js"></script>
<script src="js/jquery-3.1.1.js"></script>
<style>
    .box{width:30%; float:left;}
    .zone{width:100%; height:100%;}
</style>
<script>
    var doughnutData = [
    {
        value: 300,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Red"
    }
];
    var linesData = {
    	    labels: ["王大毛", "孫小毛", "曾甲仙", "胡蘭德", "吳美麗", "陳扁扁", "馬久久"],
    	    datasets: [
    	        {
    	            label: "本週業績表",
    	            fillColor: "rgba(220,220,220,0.5)",
    	            strokeColor: "rgba(220,220,220,0.8)",
    	            highlightFill: "rgba(220,220,220,0.75)",
    	            highlightStroke: "rgba(220,220,220,1)",
    	            data: [65, 59, 80, 81, 56, 55, 40]
    	        }
    	    ]
    	};
	
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
        /*scales: {
            xAxes: [{
                type: 'linear',
                position: 'bottom'
            }]
        */}
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

		
<script>
$(document).ready(function(){
	//alert("urlname = " + urlname);
    // Line Chart
	var ctx_Line = document.getElementById("charterLine").getContext("2d");
	var myLine = new Chart(ctx_Line,{type:'line',data:lineAxis,options:optionsAxis});

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
	alert("abc");
	
	
	//var urlget = request.getParameter("urlurl");
	//alert("urlget = " + urlget);
	var dataLabel = [];
	var dataPoints = [];
/* 		var urlgoogle = "https://drive.google.com/uc?export=download&id=0Bwa6YKGEjsimdkpGV0toWFJIWnM"; */
/* 
	var csvvv = $.get("https://raw.githubusercontent.com/g0v/potluckmap/gh-pages/data/shop-clothes.csv");
	alert("csvvv = " + csvvv);
*/
	/* var csvLL = csvvv.split(/\n+/);
    alert("csvLL[1] = " + csvLL[1,0]); */

    var urlcsv = "https://raw.githubusercontent.com/BrianHungA/ChartDraw/master/WebContent/Data/gpssensor.csv";
	var urlnew = "Data/dajaf.csv"
     $.ajax({
    	 url: urlnew,
		dataType:"text",
		success: function(data) {
			alert("data = "+ data);
			var csvLines = [];
            var points = [];
            csvLines = data.split(/\n+/);
            alert("csvLines[1] = " + csvLines[1,0]);
            for (var i = 0; i < csvLines.length; i++){
                if (csvLines[i].length > 0) {
                    points = csvLines[i].split(",");
                    dataPoints.push({ 
                        x: parseFloat(points[0]), 
                        y: parseFloat(points[3]) 		
                    });
                }
            };
			alert("dataPointsYYY = " + dataPoints);
			var DataPlotPoint = {
					datasets: [{
			            label: 'Scatter Dataset',
			            data: dataPoints
			        }]
					};
            var ctx_CSVLine = document.getElementById("charterCSVLine").getContext("2d");
            var CSVChart = new Chart(ctx_CSVLine, {
    		    type:"line",
    		    data: DataPlotPoint,
    		    options : optionsAxis
    		      });
		
    
   
		alert("OUTERCTX!");
    /* 		var tt = getDataPointsFromCSV(csvData);
	alert("tt = " + tt); */
	


	// ==========CSSSSSSV END===================

	// jQuery Test Loading files
	

	

	// jQuewry ENDDDD==============================
		}});
      });
</script>
</body>
</html>