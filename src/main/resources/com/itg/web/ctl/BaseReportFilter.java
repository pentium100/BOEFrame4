package com.itg.web.ctl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.*;
import net.sf.json.xml.XMLSerializer;

import net.sf.json.JSONArray;

import com.itg.dao.IRolesDAO;
import com.itg.dao.IUserRolesDAO;
import com.itg.dao.Role;
import com.itg.dao.UserRole;
import com.itg.web.ctl.SAPConnect;
import com.sap.mw.jco.JCO;

public class BaseReportFilter implements IReportFilter {
    private IRolesDAO roleDAO;
    public IRolesDAO getRoleDAO() {
		return roleDAO;
	}

	public void setRoleDAO(IRolesDAO roleDAO) {
		this.roleDAO = roleDAO;
	}

	private IUserRolesDAO userRoleDAO;
    
    private String masterName;
    private String tableName;
    private String tableIdField;
    private String authObject;
    
    public String getAuthObject() {
		return authObject;
	}

	public void setAuthObject(String authObject) {
		this.authObject = authObject;
	}

	public String getTableIdField() {
		return tableIdField;
	}

	public void setTableIdField(String tableIdField) {
		this.tableIdField = tableIdField;
	}

	private String label;
    public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getIdField() {
		return idField;
	}

	public void setIdField(String idField) {
		this.idField = idField;
	}

	public String getTextField() {
		return textField;
	}

	public void setTextField(String textField) {
		this.textField = textField;
	}

	private String idField;
    private String textField;

	public IUserRolesDAO getUserRoleDAO() {
		return userRoleDAO;
	}

	public void setUserRoleDAO(IUserRolesDAO userRoleDAO) {
		this.userRoleDAO = userRoleDAO;
	}

	public List<String> checkAuth(String userName, String authObject,
			List<String> authValues) {
		// TODO Auto-generated method stub
		List<UserRole> l = getUserRoleDAO().findRolesByID(userName);
		List<String> l2 = new ArrayList();
		
		for(int i=0;i<l.size();i++){
			l2.add(l.get(i).getRole());
		}
		return getRoleDAO().findAuthValue(l2, authObject, authValues);

	}
	
	

	private String renderNorFilter(String userName, String prompt,  String componentName, String xtype,  
			String componentID, String defaultValue, boolean allowBlank) {
		
		
		String result  = "  {columnWidth:.25, layout:'form', items:[{";
		result += " fieldLabel:'"+prompt.replaceFirst("lsS|lsM", "")+"'";
		result += " ,name:'"+componentName+"'";	
		result += " ,id:'"+componentID+"'";
		result += " ,xtype:'"+xtype+"'" ;
		result += ",allowBlank:"+allowBlank;
		if(!defaultValue.equals("")){
			result += " ,value:"+defaultValue+"";
		}
		
		result += "}]}";
		
		
		return result; 
		
		
		
	}
	
	private String getXmlData(){
		
		String xmlData = "";
		JCO.Client destination = null;
		try {
			destination = SAPConnect.getConnection();
			//destination = SAPConnect.getConn();
			
			
	        JCO.Function function = SAPConnect.createFunction("ZRFCMAINDATA_COMM", destination);
	        if(function == null)
	            throw new RuntimeException("ZRFCMAINDATA_COMM not found in SAP.");

	        function.getImportParameterList().setValue("X", "ISALL");
	        
	        if (getTableIdField()!=null){
	        	function.getImportParameterList().setValue("<TX><TABNAME>"+getTableName()+"</TABNAME><FIELDNAME>"+getTableIdField()+"</FIELDNAME></TX>", "PARAXML");
	        }else
	        {
	        	function.getImportParameterList().setValue("<TX><TABNAME>"+getTableName()+"</TABNAME><FIELDNAME>"+getIdField()+"</FIELDNAME></TX>", "PARAXML");
	        }
	        
	        System.out.println(" Echo: " + "<TX><TABNAME>"+getTableName()+"</TABNAME><FIELDNAME>"+getIdField()+"</FIELDNAME></TX>");
	        destination.execute(function);
	        
	        System.out.println("STFC_CONNECTION finished:");
	        System.out.println(" Echo: " + function.getExportParameterList().getString("OUTPUT"));
	        System.out.println();
	        xmlData = function.getExportParameterList().getString("OUTPUT");

			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			if (destination!=null){
				JCO.releaseClient(destination);
			}
		}
		
		
		
		
		
		
		return xmlData;
		
		
	}
	
	

	public String renderFilter(String userName, String prompt, String componentName, 
			String componentID, String defaultValue, boolean isMulti, boolean allowBlank) {
		// TODO Auto-generated method stub
		
		
		if ((prompt.equals(""))&&(getLabel()!=null&&!getLabel().equals(""))){
			prompt = getLabel();
		}
		
		if (   getMasterName().equals("datefield")
			||	getMasterName().equals("textfield")
			||	getMasterName().equals("numberfield")
			)
		{
			return renderNorFilter(userName, prompt, componentName, getMasterName(), 
					componentID, defaultValue, allowBlank); 
				
		}
		else{	
		String ds ;
		XMLSerializer xmls = new XMLSerializer();
		String xmlData = getXmlData();
		JSON masterData = null;
		
		if(!xmlData.equals("")){
			masterData = xmls.read(xmlData);
		}
		
		//JSONObject jsonObject = JSONObject.fromObject(masterData.toString());;
		
        if (getAuthObject()!=null){
    		JSONArray a = JSONArray.fromObject(masterData.toString());
    		JSONArray a2 = new JSONArray();
    		
    		System.out.println(a);
    		List<String> authValue = new ArrayList();
    		
    		
    		
    		for(int i=0;i<a.size();i++){
    			
    			authValue.add(a.getJSONObject(i).get(getIdField()).toString());	
    		}
    		
    		//System.out.println(jsonObject);
    		
    		List<String> authed = checkAuth(userName, getAuthObject(), authValue);
    		
    		for(int i = 0; i<a.size(); i++){
    			if (authed.indexOf(a.getJSONObject(i).get(getIdField()))>=0){
    			   a2.add(a.get(i))	;
    			}
    			
    		}
    		
            masterData = a2;
        	
        }
        
		ds = "	 new Ext.data.Store({";
		if (masterData!=null){
			ds += "data: "+masterData+", ";
		}
		
		ds += "reader:  new Ext.data.JsonReader({";
		//ds += "         record: 'item'";
		ds += "             id: '"+getIdField()+"'";
		ds += "                 }, ";
		ds += "         new Ext.data.Record.create([{name: 'id',type:'string', mapping:'"+getIdField()+"'},";
		ds += "         {name:'text', mapping: '"+getTextField()+"',type:'string'}]) "; 
		ds += "        ) ";
		ds += "})";
		
		if(isMulti){
			//this.checkAuth(userName, compcode, authValues)
			return this.genMultiSelect(userName, prompt, componentName,  componentID, defaultValue, ds, allowBlank);
		}else
		{
			return this.genSingleSelect(userName, prompt,  componentName, componentID, defaultValue, ds, allowBlank );
		}
		
		}
		
		
	}

	private String genMultiSelect(String userName, String prompt, String componentName, 
			String componentID, String defaultValue, String DS, boolean allowBlank) {
		// TODO Auto-generated method stub

		String result  = "  {columnWidth:.4, layout:'form', items:[";
		result += "new Ext.ux.Andrie.Select({";
		result += "	fieldLabel:'"+prompt.replaceAll("[lsM|lsS]", "")+"'";
		result += ",name:'"+ componentName +"'";
		result += ",id:'"+componentID+"'";
		result += ",multiSelect:true";
		result += ",forceSelection:true";
		result += ",allowBlank:"+allowBlank;
		result += ",separator:"+allowBlank;
		if ((getAuthObject()!=null)&&(!getAuthObject().equals(""))){
			result += ",hasAuth:true";	
		}
		
		result += ",minLength:0";
		result += ",store: " + DS;
		result += ",valueField:'id'";
		result += ",displayField:'text'";
		result += ",triggerAction:'all'";
		result += ",mode:'local'";
		result += "})]}";
		return result;
		
		//String result  = "  {columnWidth:.4, layout:'form', items:[";
		//result += "new Ext.ux.Andrie.Select({";
		//result += "	fieldLabel:'"+prompt+"'";
		//result += "	fieldLabel:'"+prompt.replaceAll("[lsM|lsS]", "")+"'";
		//result += ",name:'"+prompt+"'";
		//result += ",multiSelect:true";
		//result += ",minLength:0";
		//result += ",store: " + DS;
		//result += ",valueField:'id'";
		//result += ",displayField:'text'";
		//result += ",triggerAction:'all'";
		//result += ",mode:'local'";
		//result += "})]}";
		//return result;
		

	}


	private String genRemoteLoadMultiSelect(String userName, String prompt, String componentName, 
			String componentID, String defaultValue, String DS) {
		// TODO Auto-generated method stub
		return null;
	}

	private String genRemoteLoadSingleSelect(String userName, String prompt,
			String componentID, String defaultValue, String DS) {
		// TODO Auto-generated method stub
		return null;
	}

	public String genSingleSelect(String userName, String prompt, String componentName, 
			String componentID, String defaultValue, String DS,  boolean allowBlank) {
		// TODO Auto-generated method stub
		String result  = "  {columnWidth:.4, layout:'form', items:[";
		result += "new Ext.ux.Andrie.Select({";
		result += "	fieldLabel:'"+prompt.replaceAll("[lsM|lsS]", "")+"'";
		result += ",name:'"+ componentName+"'";
		result += ",id:'"+componentID+"'";
		result += ",multiSelect:false";
		result += ",forceSelection:true";
		
		//result += ",allowBlank:"+allowBlank;
		result += ",allowBlank: "+allowBlank;		
																																																
		if ((getAuthObject()!=null)&&(!getAuthObject().equals(""))){
			result += ",hasAuth:true";	
		}
		
		result += ",minLength:0";
		result += ",store: " + DS;
		result += ",valueField:'id'";
		result += ",displayField:'text'";
		result += ",triggerAction:'all'";
		result += ",mode:'local'";
		result += "})]}";
		return result;

	}



}
