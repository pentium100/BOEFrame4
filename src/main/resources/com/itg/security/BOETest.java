package com.itg.security;

import com.businessobjects.rebean.wi.DocumentInstance;
import com.businessobjects.rebean.wi.ReportEngine;
import com.businessobjects.rebean.wi.ReportEngines;
import com.crystaldecisions.sdk.exception.SDKException;
import com.crystaldecisions.sdk.framework.CrystalEnterprise;
import com.crystaldecisions.sdk.framework.IEnterpriseSession;
import com.crystaldecisions.sdk.occa.infostore.IInfoObject;
import com.crystaldecisions.sdk.occa.infostore.IInfoObjects;
import com.crystaldecisions.sdk.occa.infostore.IInfoStore;
import com.businessobjects.rebean.wi.Prompts;


public class BOETest {

	/**
	 * @param args
	 * @throws SDKException
	 */
	public static void main(String[] args) throws SDKException {
		// TODO Auto-generated method stub

		Prompts result; 
		String reportId = "your reportId"; 
		IEnterpriseSession enterpriseSession;
		enterpriseSession = CrystalEnterprise.getSessionMgr().logon("test",
				"test", "bo4.itg.net:6400", "secSAPR3");

		IInfoStore boInfoStore = (IInfoStore) enterpriseSession
				.getService("InfoStore");

		// IReportSourceFactory reportSourceFactory = (IReportSourceFactory)
		// enterpriseSession.getService("", "PSReportFactory");

		// Build query to retrieve the InfoObjects for Web Intelligence
		// document
		String query = "SELECT * FROM CI_INFOOBJECTS WHERE "
				+ "  SI_INSTANCE=0 AND SI_CUID='" + reportId + "'";

		// Execute the query
		IInfoObjects boInfoObjects = (IInfoObjects) boInfoStore.query(query);

		// Retrieve the first InfoObject instance of the Web Intelligence
		// document
		IInfoObject infoObject = (IInfoObject) boInfoObjects.get(0);

		// IReportSource reportSource =
		// reportSourceFactory.openReportSource(infoObject.getCUID(),
		// java.util.Locale.CHINESE);

		ReportEngines boReportEngines = (ReportEngines) enterpriseSession
				.getService("ReportEngines");

		// Retrieve the Report Engine for Web Intelligence documents

		ReportEngine boReportEngine = boReportEngines
				.getService(ReportEngines.ReportEngineType.WI_REPORT_ENGINE);

		// Retrieve the document instance for the Web Intelligence document
		DocumentInstance boDocumentInstance = boReportEngine
				.openDocument(infoObject.getID());

		// Refresh the document instance (if required)
		boDocumentInstance.refresh();

		result = boDocumentInstance.getPrompts();

	}

}
