package com.iot.chartdrawing.action;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.FileUtil;
import org.apache.hadoop.fs.Path;

import com.google.gson.Gson;
import com.iot.entity.SpectrumAndGps;

public class ChartInfoAction {
	private String userName;
	private String chartNames;
	private String chartUrl;

	private List<SpectrumAndGps> groupData = new ArrayList<SpectrumAndGps>();
	private List<String> X_Time_Axis = new ArrayList<String>();
	private List<String> Y_Vibrate_axis = new ArrayList<String>();
	private List<String> gps_X = new ArrayList<String>();
	private List<String> gps_Y = new ArrayList<String>();
	private List<String> speed = new ArrayList<String>();
	


	private String json_X_Time_Axis;
	private String json_Y_Vibrate_axis;
	private String json_gps_X;
	private String json_gps_Y;
	private String json_speed;
	
	
	Gson gson = new Gson();
	
	public String execute(){
		try {
			System.out.println("userName = " + userName + " ; chartName = " + chartNames);
			System.out.println(System.getProperty("user.dir"));

			File myFile = new File("D:/My Documents/Desktop/min_shen_2.csv");		
			FileReader fileReader = new FileReader(myFile);
			BufferedReader reader = new BufferedReader(fileReader);
			
			String line = null;
			String X_temp = null;
			String X_now = null;
			String Y_Vibrate_temp = null;
			String Y_Vibrate_now = null;
			String gps_X_temp = null;
			String gps_Y_temp = null;
			String speed_temp = null;
			
			while((line = reader.readLine()) != null){
				String[] rowData = line.split(",");
				if(X_Time_Axis.size()>0){
					X_now = rowData[0].substring(0,rowData[0].indexOf("."));
					Y_Vibrate_now = rowData[4];
					
					if(X_temp.equals(X_now)){
						
						if(Math.abs(Float.parseFloat(Y_Vibrate_now))>Math.abs(Float.parseFloat(Y_Vibrate_temp))){							
							Y_Vibrate_temp = Y_Vibrate_now;
							gps_X_temp = rowData[6];
							gps_Y_temp = rowData[7];
							speed_temp = rowData[8];
						}
						
					}else{
						X_Time_Axis.add(X_temp);
						Y_Vibrate_axis.add(Y_Vibrate_temp);
						gps_X.add(gps_X_temp);
						gps_Y.add(gps_Y_temp);
						speed.add(speed_temp);
						X_temp = X_now;
						Y_Vibrate_temp = "0";

					}
					
				}else{
					X_now = rowData[0].substring(0,rowData[0].indexOf("."));
					Y_Vibrate_now = rowData[4];
					
					X_Time_Axis.add(X_now);
					Y_Vibrate_axis.add(Y_Vibrate_now);
					gps_X.add(rowData[6]);
					gps_Y.add(rowData[7]);
					speed.add(rowData[8]);
					
					X_temp = X_now;
					Y_Vibrate_temp = Y_Vibrate_now;
					gps_X_temp = rowData[6];
					gps_Y_temp = rowData[7];
					speed_temp = rowData[8];
					
				}
/*				if(Float.parseFloat(rowData[4])>100){
				X_Time_Axis.add(rowData[0]);
				Y_Vibrate_axis.add(rowData[4]);
				gps_X.add(rowData[6]);
				gps_Y.add(rowData[7]);
				speed.add(rowData[8]);
				
				}*//*else{
					X_Time_Axis.add(rowData[0]);
					Y_Vibrate_axis.add("100");
					gps_X.add(rowData[6]);
					gps_Y.add(rowData[7]);
					speed.add(rowData[8]);
				}*/
				
				
/*				SpectrumAndGps data = new SpectrumAndGps();
				data.setTime(ss[0]);
				data.setTimestamp(ss[1]);
				data.setAbs_X(ss[2]);
				data.setAbs_Y(ss[3]);
				data.setAbs_Z(ss[4]);
				data.setAbs_XYZ(ss[5]);
				data.setGps_x(ss[6]);
				data.setGps_y(ss[7]);
				data.setSpeed(Float.parseFloat(ss[8]));
				data.setLevel(Float.parseFloat(ss[9]));	
				groupData.add(data);*/
			}
			System.out.println("dataSum = " + X_Time_Axis.size());
			setJson_X_Time_Axis(gson.toJson(X_Time_Axis));
			setJson_Y_Vibrate_axis(gson.toJson(Y_Vibrate_axis));
			setJson_gps_X(gson.toJson(gps_X));
			setJson_gps_Y(gson.toJson(gps_Y));
			setJson_speed(gson.toJson(speed));
			System.out.println("json_X_Time_Axis = " + json_X_Time_Axis.length());
			System.out.println("setJson_speed _ MAX = " + Collections.max(speed));
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		//chartUrl = 
		
		return "success";
	}

	public String getChartUrl() {
		return chartUrl;
	}

	public void setChartUrl(String chartUrl) {
		this.chartUrl = chartUrl;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getChartNames() {
		return chartNames;
	}

	public void setChartNames(String chartNames) {
		this.chartNames = chartNames;
	}
	
	public List<SpectrumAndGps> getGroupData() {
		return groupData;
	}

	public void setGroupData(List<SpectrumAndGps> groupData) {
		this.groupData = groupData;
	}

	public List<String> getX_Time_Axis() {
		return X_Time_Axis;
	}

	public void setX_Time_Axis(List<String> x_Time_Axis) {
		X_Time_Axis = x_Time_Axis;
	}

	public List<String> getY_Vibrate_axis() {
		return Y_Vibrate_axis;
	}

	public void setY_Vibrate_axis(List<String> y_Vibrate_axis) {
		Y_Vibrate_axis = y_Vibrate_axis;
	}

	public List<String> getGps_X() {
		return gps_X;
	}

	public void setGps_X(List<String> gps_X) {
		this.gps_X = gps_X;
	}

	public List<String> getGps_Y() {
		return gps_Y;
	}

	public void setGps_Y(List<String> gps_Y) {
		this.gps_Y = gps_Y;
	}

	public List<String> getSpeed() {
		return speed;
	}

	public void setSpeed(List<String> speed) {
		this.speed = speed;
	}
	
	public String getJson_X_Time_Axis() {
		return json_X_Time_Axis;
	}

	public void setJson_X_Time_Axis(String json_X_Time_Axis) {
		this.json_X_Time_Axis = json_X_Time_Axis;
	}

	public String getJson_Y_Vibrate_axis() {
		return json_Y_Vibrate_axis;
	}

	public void setJson_Y_Vibrate_axis(String json_Y_Vibrate_axis) {
		this.json_Y_Vibrate_axis = json_Y_Vibrate_axis;
	}

	public String getJson_gps_X() {
		return json_gps_X;
	}

	public void setJson_gps_X(String json_gps_X) {
		this.json_gps_X = json_gps_X;
	}

	public String getJson_gps_Y() {
		return json_gps_Y;
	}

	public void setJson_gps_Y(String json_gps_Y) {
		this.json_gps_Y = json_gps_Y;
	}

	public String getJson_speed() {
		return json_speed;
	}

	public void setJson_speed(String json_speed) {
		this.json_speed = json_speed;
	}



}
