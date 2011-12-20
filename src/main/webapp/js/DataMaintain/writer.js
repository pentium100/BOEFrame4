/*!
 * Ext JS Library 3.0+
 * Copyright(c) 2006-2009 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
// Application instance for showing user-feedback messages.
var App = new Ext.App({});
Ext.data.Record.PREFIX = '';
// Create HttpProxy instance.  Notice new configuration parameter "api" here instead of load.  However, you can still use
// the "url" paramater -- All CRUD requests will be directed to your single url instead.
var proxy = new Ext.data.HttpProxy({
	url: p_restful_url
});

// Typical JsonReader.  Notice additional meta-data params for defining the core attributes of your json-response
var reader = new Ext.data.JsonReader({
    totalProperty: 'total',
    successProperty: 'success',
    idProperty: 'id',
    root: p_dataRoot
	}, p_recordType    
);

// The new DataWriter component.
var writer = new Ext.data.JsonWriter({
    encode: false
    ,writeAllFields: true
});

// Typical Store collecting the Proxy, Reader and Writer together.
var store = new Ext.data.Store({
    id: 'reportMemoStore',
    proxy: proxy,
    reader: reader,
    restful: true, 
    writer: writer,  // <-- plug a DataWriter into the store just as you would a Reader
    autoSave: true,  // <-- false would delay executing create, update, destroy requests until specifically told to do so with some [save] buton.
    listeners: {
        write : function(store, action, result, res, rs) {
	        if(rs.id==0){return;}
            App.setAlert(res.success, res.message); // <-- show user-feedback for all write actions
        },
        exception : function(proxy, type, action, options, res, arg) {
            if (type === 'remote') {
                Ext.Msg.show({
                    title: 'REMOTE EXCEPTION',
                    msg: res.message,
                    icon: Ext.MessageBox.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        },
        load : function(store, r, options ){
        	debugger;
        	
        	if(r.length==2){
        		
        		for (i=0;i<r.length;i++){
        			  if(r[i].id==0){store.removeAt(i);}
        		}
        		
        	}
        	
        }
    }
});


// A new generic text field
var textField =  new Ext.form.TextField();
var dateField =  new Ext.form.TextField();

// Let's pretend we rendered our grid-columns with meta-data from our ORM framework.
var userColumns =  p_columns;





// load the store immeditately
store.load({params:{start:0, limit:25}});


Ext.onReady(function() {
    Ext.QuickTips.init();

    // create user.Form instance (@see UserForm.js)
    var userForm = new App.user.Form({
        
        listeners: {
            create : function(fpanel, data) {   // <-- custom "create" event defined in App.user.Form class
                var rec = new userGrid.store.recordType(data);
                userGrid.store.insert(0, rec);
            },
            resize : function(t, adjWidth, adjHeight,  rawWidth, rawHeight ) {
            	
            	t.doLayout();
             
            }
        }
    });

    // create user.Grid instance (@see UserGrid.js)
    var userGrid = new App.user.Grid({
        
        store: store,
        columns : userColumns,
        listeners: {
            rowclick: function(g, index, ev) {
                var rec = g.store.getAt(index);
                userForm.loadRecord(rec);
                userForm.getForm().items.get(userForm.getForm().items.length-1).focus();
            },
            destroy : function() {
                userForm.getForm().reset();
            }
        }
    });
    
    var viewport = new Ext.Viewport({
        layout: 'border',
        defaults:{
                 split:true
                },
		items: [
		// create instance immediately
			
			userGrid
			,{
			 
			region : 'center',
			layout : 'fit', 
			items:[userForm]
			}
		], 
		renderTo: 'client'
    });
         

    
    
    
    
});
