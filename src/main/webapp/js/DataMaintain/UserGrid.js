/*!
 * Ext JS Library 3.0+
 * Copyright(c) 2006-2009 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.ns('App', 'App.user');
/**
 * App.user.Grid
 * A typical EditorGridPanel extension.
 */
App.user.Grid = Ext.extend(Ext.grid.EditorGridPanel, {
    //renderTo: 'user-grid',
	region:'north',
    iconCls: 'silk-grid',
    frame: true,
    title: p_title,
    height: 300,
    //width: 500,
    //style: 'margin-top: 10px',

    initComponent : function() {

        // typical viewConfig
        this.viewConfig = {
            forceFit: true
        };

        // relay the Store's CRUD events into this grid so these events can be conveniently listened-to in our application-code.
        this.relayEvents(this.store, ['destroy', 'save', 'update']);

        // build toolbars and buttons.
        this.tbar = this.buildTopToolbar();
        //this.bbar = this.buildBottomToolbar();
        this.bbar = this.buildPaggingToolbar();
        //this.buttons = this.buildUI();

        // super
        App.user.Grid.superclass.initComponent.call(this);
    },

    
    /**
     * buildPaggingToolbar
     */
    
    
    buildPaggingToolbar: function(){
    	
    	var pagging = new Ext.PagingToolbar({
            pageSize: 25,
            store: store,
            displayInfo: true,
            displayMsg: '显示记录 {0} - {1} of {2}',
            emptyMsg: "无记录"
        });
    	
    	return pagging;
    	
    	
    },
    
    /**
     * buildTopToolbar
     */
    buildTopToolbar : function() {
        return [{
            text: '新增',
            iconCls: 'silk-add',
            handler: this.onAdd,
            scope: this
        }, '-', {
            text: '删除',
            iconCls: 'silk-delete',
            handler: this.onDelete,
            scope: this
        }, '-'];
    },

    /**
     * buildBottomToolbar
     */
    buildBottomToolbar : function() {
        return ['<b>@cfg:</b>', '-', {
            text: 'autoSave',
            enableToggle: true,
            pressed: true,
            tooltip: 'When enabled, Store will execute Ajax requests as soon as a Record becomes dirty.',
            toggleHandler: function(btn, pressed) {
                this.store.autoSave = pressed;
            },
            scope: this
        }, '-', {
            text: 'batch',
            enableToggle: false,
            pressed: false,
            tooltip: 'When enabled, Store will batch all records for each type of CRUD verb into a single Ajax request.',
            toggleHandler: function(btn, pressed) {
                this.store.batch = pressed;
            },
            scope: this
        }, '-', {
            text: 'writeAllFields',
            enableToggle: true,
            tooltip: 'When enabled, Writer will write *all* fields to the server -- not just those that changed.',
            toggleHandler: function(btn, pressed) {
                store.writer.writeAllFields = pressed;
            },
            scope: this
        }, '-'];
    },

    /**
     * buildUI
     */
    buildUI : function() {
        return [{
            text: 'Save',
            iconCls: 'icon-save',
            handler: this.onSave,
            scope: this
        }];
    },

    /**
     * onSave
     */
    onSave : function(btn, ev) {
        this.store.save();
    },

    /**
     * onAdd
     */
    onAdd : function(btn, ev) {

        var store = this.store;
        orec = new store.recordType();            
        orec.data = {};            
        orec.fields.each(function(field) {                
        	orec.data[field.name] = field.defaultValue;            
        	});            
        orec.data.newRecord = true;            
        orec.commit();
        store.insert(0, orec);
        this.fireEvent('rowclick', this, 0);

        //this.store.insert(0, orec);
    },

    /**
     * onDelete
     */
    onDelete : function(btn, ev) {
        var index = this.getSelectionModel().getSelectedCell();
        if (!index) {
            return false;
        }
        var rec = this.store.getAt(index[0]);
        this.store.remove(rec);
    }
});
