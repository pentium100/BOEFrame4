<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="js/ext-3.0.0/resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="js/ext-3.0.0/examples/shared/examples.css" />
    
    
    <style type="text/css">
    html, body {
        font:normal 12px verdana;
        margin:0;
        padding:0;
        border:0 none;
        overflow:hidden;
        height:100%;
    }
    p {
        margin:5px;
    }
    .settings {
        background-image:url(js/ext-3.0.0/examples/shared/icons/fam/folder_wrench.png);
    }
    .nav {
        background-image:url(js/ext-3.0.0/examples/shared/icons/fam/folder_go.png);
    }
    </style>

    
    <!-- LIBS -->
    <script type="text/javascript" src="js/ext-3.0.0/adapter/ext/ext-base.js"></script>
    <!-- ENDLIBS -->

    <script type="text/javascript" src="js/ext-3.0.0/ext-all.js"></script>

    <!-- EXAMPLES -->
    <script type="text/javascript" src="js/ext-3.0.0/examples/shared/examples.js"></script>
    <script type="text/javascript" src="js/ext-3.0.0/examples/ux/miframe.js"></script>
    

<script type="text/javascript">

Ext.chart.Chart.CHART_URL = 'js/ext-3.0.0/resources/charts.swf';   
Ext.BLANK_IMAGE_URL = 'js/ext-3.0.0/resources/images/default/s.gif';   
Ext.onReady(function() {   
    var container = Ext.getBody();   
    var h = 150;   
    var cols = 10, rows = 15;   
  
    function createCells(row, col) {   
        var ret = new Array(row);   
        for (var i = 0; i < row; i++)   
            ret[i] = new Array(col);   
        return ret;   
    }   
    function genDatas(rows, cols) {   
        var year = 1990;   
        var arr = [];   
        var r = [''];   
        for (var j = 1; j <= cols; j++)   
            r.push('dep' + j);   
        arr.push(r);   
        for (var i = 0; i < rows; i++) {   
            var r = [year++];   
            for (var j = 0; j < cols; j++)   
                r.push(Rnd.getNumber(10000, 100000));   
            arr.push(r);   
        }   
        return arr;   
    }   
  
    var datas = genDatas(rows, cols);   
    var fs = [], cs = [];   
    var hs = datas[0];   
    for (var i = 0; i < hs.length; i++) {   
        fs.push('field' + i);   
        cs.push({   
            header : 'FIELD' + i,   
            dataIndex : 'field' + i   
        });   
    }   
    var editStore = new Ext.data.SimpleStore({   
        fields : fs,   
        data : datas,   
  
        _listenChange : function(fn) {   
            this.on({   
                datachanged : fn,   
                add : fn,   
                remove : fn,   
                update : fn,   
                clear : fn,   
                load : fn,   
                scope : this  
            });   
        },   
        createYSum : function() {   
            var st = new Ext.data.SimpleStore({   
                fields : ['cat', 'data'],   
                data : this.getYSumData()   
            });   
            this._listenChange(function() {   
                st.loadData(this.getYSumData())   
            });   
            return st;   
        },   
  
        getYSumData : function() {   
            var ds = createCells(this.fields.items.length - 1, 2);   
            var datas = this.getCellDatas();   
            for (var j = 1, l = datas[0].length; j < l; j++)   
                ds[j - 1][0] = datas[0][j];   
            for (var i = 1, il = datas.length; i < il; i++)   
                for (var j = 1, jl = datas[0].length; j < jl; j++)   
                    ds[j - 1][1] = (ds[j - 1][1] || 0) + datas[i][j];   
            return ds;   
        },   
  
        createYInject : function() {   
            var _super = this;   
            var st = new Ext.data.SimpleStore({   
                fields : ['cat', 'data'],   
                data : this.getYInjectData(0),   
                loadIndex : function(idx) {   
                    this.loadData(_super.getYInjectData(idx));   
                }   
            });   
            this._listenChange(function() {   
                st.loadIndex(0);   
            });   
            return st;   
        },   
  
        getYInjectData : function(idx) {   
            var datas = this.getCellDatas();   
            var ds = createCells(datas.length - 1, 2);   
            for (var j = 1, l = datas.length; j < l; j++) {   
                ds[j - 1][0] = datas[j][0];   
                ds[j - 1][1] = datas[j][idx + 1];   
            }   
            return ds;   
        },   
  
        getCellDatas : function() {   
            var ds = createCells(this.data.length, this.fields.length);   
            for (var i = 0, il = this.data.length; i < il; i++) {   
                var r = this.getAt(i);   
                for (var j = 0, jl = this.fields.length; j < jl; j++)   
                    ds[i][j] = r.get(this.fields.items[j].name);   
            }   
            return ds;   
        },   
  
        createXSum : function() {   
            var st = new Ext.data.SimpleStore({   
                fields : ['cat', 'data'],   
                data : this.getXSumData()   
            });   
            this._listenChange(function() {   
                st.loadData(this.getXSumData())   
            });   
            return st;   
        },   
  
        getXSumData : function() {   
            var ds = createCells(this.data.items.length - 1, 2);   
            var datas = this.getCellDatas();   
            for (var i = 1, l = datas.length; i < l; i++) {   
                ds[i - 1][0] = datas[i][0];   
                for (var j = 1, jl = datas[0].length; j < jl; j++)   
                    ds[i - 1][1] = (ds[i - 1][1] || 0) + datas[i][j];   
            }   
  
            return ds;   
        },   
  
        createXInject : function() {   
            var _super = this;   
            var st = new Ext.data.SimpleStore({   
                fields : ['cat', 'data'],   
                data : this.getXInjectData(0),   
                loadIndex : function(idx) {   
                    this.loadData(_super.getXInjectData(idx));   
                }   
            });   
            this._listenChange(function() {   
                st.loadIndex(0);   
            })   
            return st;   
        },   
  
        getXInjectData : function(idx) {   
            var datas = this.getCellDatas();   
            var ds = createCells(datas[0].length - 1, 2);   
            for (var i = 1, l = datas[0].length; i < l; i++) {   
                ds[i - 1][0] = datas[0][i];   
                ds[i - 1][1] = datas[idx + 1][i];   
            }   
            return ds;   
        }   
    });   
  
    var xsumStore = editStore.createXSum();   
    var ysumStore = editStore.createYSum();   
    var xinjStore = editStore.createXInject();   
    var yinjStore = editStore.createYInject();   
  
    grid = new Ext.grid.EditorGridPanel({   
        hideHeaders : true,   
        store : editStore,   
        clicksToEdit : 1,   
        columns : cs,   
        height : 200,   
        renderTo : container,   
        bbar : [{   
            text : 'reload data',   
            handler : function() {   
                editStore.loadData(genDatas(rows, cols))   
            }   
        }]   
    });   
    grid.getColumnModel().isCellEditable = function(col, row) {   
        return col != 0;   
    }   
    grid.getColumnModel().getCellEditor = function(col, row) {   
        if (col + row == 0)   
            return null;   
        else if (col == 0 || row == 0)   
            return this.txtEditor = (this.txtEditor || new Ext.grid.GridEditor(new Ext.form.TextField()));   
        else  
            return this.numEidtor = (this.numEditor || new Ext.grid.GridEditor(new Ext.form.NumberField()));   
    }   
  
    new Ext.Panel({   
        title : 'x-axis',   
        renderTo : container,   
        layout : 'table',   
        layoutConfig : {   
            columns : 5,   
            tableAttrs : {   
                style : 'width:100%;'  
            }   
        },   
        items : [{   
            items : {   
                xtype : 'piechart',   
                height : h,   
                store : xsumStore,   
                categoryField : 'cat',   
                dataField : 'data',
                chartStyle: {   
                	legend : {
                  		display : "top"
                	}
                }, 
                listeners : {   
                    itemclick : function(o) {   
                        xinjStore.loadIndex(o.index);   
                    }   
                }   
            }   
        }, {   
            items : {   
                xtype : 'columnchart',   
                height : h,   
                store : xinjStore,   
                title : 'aaaaaaaaaaaaaa',   
                yField : 'data',   
                style : {   
                    xAxis : {   
                        labelRotation : -90  
                    }   
                },   
                yAxis : new Ext.chart.NumericAxis({   
                    labelRenderer : Ext.util.Format.numberRenderer('0,0'),   
                    title : 'DATA'  
                }),   
                xAxis : new Ext.chart.CategoryAxis({   
                    title : 'Value'  
                }),   
                series : [{   
                    type : 'line',   
                    displayName : 'abcd',   
                    xField : 'cat'  
                }, {   
                    type : 'column',   
                    xField : 'cat'  
                }]   
            }   
        }, {   
            items : {   
                xtype : 'piechart',   
                height : h,   
                store : xinjStore,   
                categoryField : 'cat',   
                dataField : 'data'  
            }   
        }/*, {  
        items : {  
        xtype : 'linechart',  
        height : h,  
        store : xinjStore,  
        xField : 'cat',  
        yField : 'data',  
        yAxis : new Ext.chart.NumericAxis({  
        labelRenderer : Ext.util.Format.numberRenderer('0,0')  
        })  
        }  
        }, {  
        items : {  
        xtype : 'columnchart',  
        height : h,  
        store : xinjStore,  
        xField : 'cat',  
        yField : 'data',  
        yAxis : new Ext.chart.NumericAxis({  
        labelRenderer : Ext.util.Format.numberRenderer('0,0')  
        })  
        }  
        }*/]   
    });   
  
    new Ext.Panel({   
        title : 'y-axis',   
        renderTo : container,   
        layout : 'table',   
        layoutConfig : {   
            columns : 5,   
            tableAttrs : {   
                style : 'width:100%;'  
            }   
        },   
        items : [{   
            items : {   
                xtype : 'piechart',   
                height : h,   
                store : ysumStore,   
                categoryField : 'cat',   
                dataField : 'data',   
                style : {   
                    //                  padding : 100,   
                    legend : {   
                        display : 'right'  
                    }   
                },   
                listeners : {   
                    itemclick : function(o) {   
                        yinjStore.loadIndex(o.index);   
                    }   
                }   
            }   
        }, {   
            items : {   
                xtype : 'piechart',   
                height : h,   
                store : yinjStore,   
                categoryField : 'cat',   
                dataField : 'data'  
            }   
        }, {   
            items : {   
                xtype : 'linechart',   
                height : h,   
                store : yinjStore,   
                xField : 'cat',   
                yField : 'data'  
            }   
        }, {   
            items : {   
                xtype : 'columnchart',   
                height : h,   
                store : yinjStore,   
                xField : 'cat',   
                yField : 'data'  
            }   
        }]   
    })   
  
})   
  
var Rnd = {   
    /**  
     * 获取随机整数,范围是 start <= 返回值 < end  
     *   
     * @param start, Number: 返回值大于等于start  
     * @param end, Number: 返回值小于end  
     */  
    getNumber : function(start, end) {   
        start = start || 0, end = end || 10;   
        return Math.floor(start + (end - start) * Math.random());   
    },   
  
    /** Hex字符集合 0123456789ABCDEF */  
    charHex : "0123456789ABCDEF",   
    /** 大写字母集合 */  
    charUpper : "ABCDEFGHIJKLMNOPQRSTUVWXYZ",   
    /** 大写字母和数字集合 */  
    charUpperAndNumber : "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",   
    /** 小写字母集合 */  
    charLower : "abcdefghijklmnopqrstuvwxyz",   
    /** 数字集合 */  
    charNumber : "0123456789",   
    /** 大小写字母和数字集合 */  
    charAll : "01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",   
  
    /**  
     * 获取随机字符串   
     *   
     * @param size, Int: 字符串长度,默认为16  
     * @param seeds, String: 产生随机字母的来源字符串,默认为charAll  
     * @see Rnd.charAll  
     */  
    getString : function(size, seeds) {   
        seeds = seeds || this.charAll;   
        size = size || 16;   
        var len = seeds.length;   
        var arr = new Array(size);   
        for (var i = 0; i < size; i++)   
            arr[i] = seeds.charAt(this.getNumber(0, len));   
  
        return arr.join("");   
    }   
}  

</script>


</head>


<body>
</body>
</html>