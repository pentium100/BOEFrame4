<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.io.*,com.businessobjects.rebean.wi.*"%>
<%
// *****************************************************************************
// Display an image of a given thin client document
// *****************************************************************************

	// WARNING: Do not reorganize the first and last lines

	// Remove response headers added by servlet
	response.reset();
	response.setDateHeader("expires", 0);
	response.setContentType("image/gif");

	// Retrieve parameters
	String strEntry = request.getParameter("entry");
	String strImageName = request.getParameter("ImageName");

	if (strEntry == null)
		throw new Exception("Token value is not supplied");

	if (strImageName == null)
		throw new Exception("Image name not supplied");

	// Retrieve the correct ReportEngine from the storage token
	ReportEngines reportEngines = (ReportEngines) session.getAttribute("ReportEngines");		
	ReportEngine reportEngine = reportEngines.getServiceFromStorageToken(strEntry);
	
	// Retrieve the document using its storage token
	DocumentInstance document = reportEngine.getDocumentFromStorageToken(strEntry);
	
	Image objImage = document.getImage(strImageName);
	byte[] abyBinaryContent = objImage.getBinaryContent();

	ServletOutputStream objServletOutputStream = response.getOutputStream();
	response.setContentLength(abyBinaryContent.length);
	objServletOutputStream.write(abyBinaryContent);
	objServletOutputStream.flush();
	objServletOutputStream.close();

// *****************************************************************************
%>