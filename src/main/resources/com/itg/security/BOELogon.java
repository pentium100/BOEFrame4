package com.itg.security;

import com.crystaldecisions.sdk.exception.SDKException;
import com.crystaldecisions.sdk.framework.CrystalEnterprise;
import com.crystaldecisions.sdk.framework.IEnterpriseSession;
import com.crystaldecisions.sdk.occa.infostore.IInfoObjects;
import com.crystaldecisions.sdk.occa.infostore.IInfoStore;

public class BOELogon {
	

	private String userName;
	private String password;
	private String cMSName;
	private String authentication;
	private IEnterpriseSession es;

	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCMSName() {
		return cMSName;
	}

	public void setCMSName(String name) {
		cMSName = name;
	}

	public String getAuthentication() {
		return authentication;
	}

	public void setAuthentication(String authentication) {
		this.authentication = authentication;
	}
	
	public IEnterpriseSession logon() throws SDKException
	{
		return CrystalEnterprise.getSessionMgr().logon(userName, password, cMSName, authentication);
		
	}


	public IEnterpriseSession getEs() throws SDKException {
		if (this.es == null){
			this.es = logon();
		}else{
			
			try{
				IInfoStore boInfoStore = (IInfoStore) this.es.getService("InfoStore");
				
				String query = "SELECT * FROM CI_INFOOBJECTS WHERE "
					+ "  SI_INSTANCE=0 AND SI_CUID='qqqqq'";

			// Execute the query
			IInfoObjects boInfoObjects = (IInfoObjects) boInfoStore
					.query(query);
			}
			catch(Exception e){
				this.es = logon();
			}
			
		}
		return this.es;

	}
	
	
	
    
	
	



}
