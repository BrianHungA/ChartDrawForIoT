package com.iot.chartdrawing.action;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.FileUtil;
import org.apache.hadoop.fs.Path;

import com.iot.entity.SpectrumAndGps;

public class ChartInfoAction {
	private String userName;
	private String chartNames;
	private String chartUrl;
	private List<SpectrumAndGps> groupData;
	
	public String execute(){
		try {
			System.out.println("userName = " + userName + " ; chartName = " + chartNames);
			System.out.println(System.getProperty("user.dir"));

			File myFile = new File("D:/My Documents/Desktop/min_shen_2.csv");		
			FileReader fileReader = new FileReader(myFile);
			BufferedReader reader = new BufferedReader(fileReader);
			
			String line = null;
			groupData = new ArrayList<SpectrumAndGps>();
			while((line = reader.readLine()) != null){
				String[] ss = line.split(",");
				SpectrumAndGps data = new SpectrumAndGps();
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
				groupData.add(data);
			}
			System.out.println("dataSum = " + groupData.size());
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
	
	public String URLdir(){
		
		Configuration conf = new Configuration();
		try {
			FileSystem hdfs = FileSystem.get(new URI("hdfs://nna:8020"),conf);
			FileStatus[] fileStatus = hdfs.listStatus(new Path("hdfs://nna/user/" + userName));
			Path[] paths = FileUtil.stat2Paths(fileStatus);
			for(Path path : paths){
				System.out.println("URL = " + path);
				
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
		
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
}
