package com.iot.chartdrawing;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;

public class HelloWorld extends HttpServlet {
	private String msg;

	public void init() throws ServletException {
		msg = "Hello World by Brian !";

	}

	public void doGet(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		rep.setContentType("text/html");

		// Actual logic goes here.
		String userName = req.getParameter("userName");
		String chartName = req.getParameter("chartName");
		PrintWriter out = rep.getWriter();
		out.println("<h1>" + msg + userName + " ; " + chartName + "</h1>");
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		doGet(req,rep);
	}
}

