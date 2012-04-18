<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
<head>
<title>厦门国贸集团股份有限公司 管理驾驶舱</title>
<link rel="stylesheet" type="text/css"
	href="js/ext-3.0.0/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css"
	href="js/ext-3.0.0/examples/shared/examples.css" />
<link rel="stylesheet" type="text/css"
	href="js/ext-3.0.0/examples/ux/css/animated-dataview.css" />


<style type="text/css">
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
}

p {
	margin: 5px;
}

.settings {
	background-image:
		url(js/ext-3.0.0/examples/shared/icons/fam/folder_wrench.png);
}

.add16 {
	background-image:
		url(images/report.png) !important;
}
.nav {
	background-image:
		url(js/ext-3.0.0/examples/shared/icons/fam/folder_go.png);
}


#north,#south {
	border: 0 none;
	background: #1E4176 url(img/hd-bg.gif) repeat-x 0 0;
	padding-top: 3px;
	padding-left: 3px;
}

#north .api-title {
	font: normal 16px tahoma, arial, sans-serif;
	color: white;
	margin: 5px;
}
</style>




<!-- LIBS -->
<script type="text/javascript"
	src="js/ext-3.0.0/adapter/ext/ext-base.js"></script>
<!-- ENDLIBS -->

<script type="text/javascript" src="js/ext-3.0.0/ext-all-debug.js"></script>

<!-- EXAMPLES -->
<script type="text/javascript"
	src="js/ext-3.0.0/examples/shared/examples.js"></script>
<script type="text/javascript" src="js/ext-3.0.0/examples/ux/miframe.js"></script>




<script type="text/javascript">


	Ext
			.onReady(function() {
			
				

				// NOTE: This is an example showing simple state management. During development,
				// it is generally best to disable state management as dynamically-generated ids
				// can change across page loads, leading to unpredictable results.  The developer
				// should ensure that stable state ids are set for stateful components in real apps.
				Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

				//Ext.ux.IFrameComponent = Ext.extend(Ext.BoxComponent, {
				//  onRender : function(ct, position){
				//    this.el = ct.createChild({tag: 'iframe', id: 'iframe-'+ this.id, frameBorder: 0, src: this.url});
				//}
				//		});
				
				
				
		
				
/*				
				var Tree = Ext.tree;

				var tree = new Tree.TreePanel(
						{
							useArrows : true,
							autoScroll : true,
							animate : true,
							enableDD : true,
							containerScroll : true,
							border : false,
							// auto create TreeLoader
							dataUrl : 'getMenu.do',

							root : {
								nodeType : 'async',
								text : '管理驾驶舱',
								draggable : false,
								id : '0',
								cls : 'folder'
							},

							listeners : {
								click : function(n) {
									if (!n.leaf) {
										return;
									}
									window
											.open(
													"queryReport.do?menuId="
															+ n.id,
													n.id,
													"left=0,top=0,width="
															+ (screen.width - 10)
															+ ",height="
															+ (screen.height - 70)
															+ ",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes");

									//panel = centerPanel.add({
									//	            xtype: 'iframepanel',
									//id: 'tabOpusForum'+n.id,
									//				title: n.text,
									//				defaultSrc: "queryReport.do?menuId="+n.id,
									//				loadMask: true,
									//				autoScroll:true,
									//				closable:true
									//frameConfig: { autoCreate:{ id:'opusForum'}}

									//title:,
									//closable: 
									//autoScroll: true,
									//items:[new Ext.ux.IFrameComponent({ id: "menu"+n.id, url: "queryReport.do?menuId="+n.id }) ]
									// 				});
									centerPanel.doLayout();
									//centerPanel.activate(panel);

									//centerPanel.items.add(reportPanel);
									//Ext.Msg.alert('Navigation Tree Click', 'You clicked: "' + n.attributes.text + '"');            
								}
							}
						});

				tree.getRootNode().expand();
				


				var item1 = new Ext.Panel({
						title: 'Accordion Item 1',
						//html: '&lt;empty panel&gt;',
						layout: {
							type:'vbox',
							padding:'5',
							align:'center'
						},
						defaults:{margins:'0 0 5 0'},
						items:[
						   
						]
						
					});
					
*/
					
				    var store = new Ext.data.JsonStore({
				                 url: 'getMenu.do',
					
					         fields:[{name:'id',mapping:'id'},
							 {name:'text',mapping:'text'},
   							 {name: 'reportId', mapping:'reportId'}, 
							 {name: 'queryString',mapping:'queryString'},
							 {name: 'images',mapping:'images'}]		
					        
					
					});
					
				 store.load({params: {node: 900}});
				 var dataview = new Ext.DataView({
					store: store,
					
					tpl  : new Ext.XTemplate(
						'<ul>',
						'<tpl for=".">',
						'<li class="phone">',
						'<img width="200" height="130" src="{images}" />',
								'<strong>{text}</strong>',
						'<span></span>',
						'</li>',
						'</tpl>',
						'</ul>'
						),
        
					//plugins : [
					//	new Ext.ux.DataViewTransition({
					//	duration  : 550,
					//	idProperty: 'id'
					//	})
					//],
					id: 'phones',
        
					itemSelector: 'li.phone',
					overClass   : 'phone-hover',
					singleSelect: true,
					multiSelect : false,
					autoScroll  : true,
					listeners:{
					   dblclick: function( dataview, index, node, e ){
						
						var n = store.getAt(index);
					   
					   　　window
											.open(
													"queryReport.do?menuId="
															+ n.id,
													n.id,
													"left=0,top=0,width="
															+ (screen.width - 10)
															+ ",height="
															+ (screen.height - 70)
															+ ",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes");
　
					   }
					
					}
				});	
    	
				
	/*
							
				Ext.Ajax.request({
					url: 'getMenu.do',
					params: { node: 900 },
					success: function(response, opts) {	
						var o = Ext.decode(response.responseText);
						for(var i=0;i<o.length;i++){
						   var button1 = new Ext.Button({
					                 //text: '<div style="position:absolute;margin-left:-51px;margin-top:-8px;text-align:center;width:140">'+o[i].text+'</div>',
							 text: o[i].text,
						         Cls: 'add16',
                                                         iconAlign: 'top',
							 width: 140,
							 height: 180
							 //,border:false
							 ,scale: 'large'
					
						   });
						   
						   
						      
						      
						   item1.add(button1);

						   
						}
						item1.doLayout();

					},
					
					failure: function(response, opts) {
						console.log('server-side failure with status code ' + response.status);
					}
				});
*/

				var viewport = new Ext.Viewport({
					layout : 'border',
					items : [
					// create instance immediately
					new Ext.BoxComponent({
						region : 'north',
						height : 32, // give north and south regions a height
						frame : true,
						autoEl : {
							tag : 'div',
							html : '<p>厦门国贸集团股份有限公司  管理驾驶舱</p>'
							
						},
						
						style: {
							font: 'normal 16px tahoma, arial, sans-serif;',
							color: 'white',
							margin: '5px',
						    border:'0 none',
						    
						    background:'#1E4176'
						    
							
						}
					
					}), 
					/*!
					{
						region : 'west',
						id : 'west-panel', // see Ext.getCmp() below
						title : '菜单区',
						split : true,
						width : 200,
						minSize : 175,
						maxSize : 400,
						collapsible : true,
						margins : '0 0 0 5',
						//layout : 'fit',
						//items : [ tree]
						layout:'accordion',
						items: [item1]

						

					},
					*/
					// in this instance the TabPanel is not wrapped by another panel
					// since no title is needed, this Panel is added directly
					// as a Container
					
					centerPanel = new Ext.Panel({
						region : 'center', // a center region is ALWAYS required for border layout
						deferredRender : false,
						activeTab : 0, // first tab initially active
						items : [
						    dataview

						]
					}) 
					
					
					]
				});
				
				

				// get a reference to the HTML element with id "hideit" and add a click listener to it 
				//Ext.get("hideit").on('click', function(){
				// get a reference to the Panel that was created with id = 'west-panel' 
				//    var w = Ext.getCmp('west-panel');
				// expand or collapse that Panel based on its collapsed property state
				//    w.collapsed ? w.expand() : w.collapse();
				//});
			});
</script>
</head>
<body>
	<!-- use class="x-hide-display" to prevent a brief flicker of the content -->
	<div id="center2" class="x-hide-display">
		<a id="hideit" href="#">Toggle the west region</a>
		<p>My closable attribute is set to false so you can't close me.
			The other center panels can be closed.</p>
		<p>The center panel automatically grows to fit the remaining space
			in the container that isn't taken up by the border regions.</p>
		<hr>
		<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed
			metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut
			nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac,
			lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero
			lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In
			pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus
			a, fringilla vel, urna. Aliquam commodo ullamcorper erat. Nullam vel
			justo in neque porttitor laoreet. Aenean lacus dui, consequat eu,
			adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non,
			ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt
			diam nec urna. Curabitur velit. Quisque dolor magna, ornare sed,
			elementum porta, luctus in, leo.</p>
		<p>Donec quis dui. Sed imperdiet. Nunc consequat, est eu
			sollicitudin gravida, mauris ligula lacinia mauris, eu porta dui nisl
			in velit. Nam congue, odio id auctor nonummy, augue lectus euismod
			nunc, in tristique turpis dolor sed urna. Donec sit amet quam eget
			diam fermentum pharetra. Integer tincidunt arcu ut purus. Cum sociis
			natoque penatibus et magnis dis parturient montes, nascetur ridiculus
			mus. Nulla blandit malesuada odio. Nam augue. Aenean molestie sapien
			in mi. Suspendisse tincidunt. Pellentesque tempus dui vitae sapien.
			Donec aliquam ipsum sit amet pede. Sed scelerisque mi a erat.
			Curabitur rutrum ullamcorper risus. Maecenas et lorem ut felis dictum
			viverra. Fusce sem. Donec pharetra nibh sit amet sapien.</p>
		<p>Aenean ut orci sed ligula consectetuer pretium. Aliquam odio.
			Nam pellentesque enim. Nam tincidunt condimentum nisi. Maecenas
			convallis luctus ligula. Donec accumsan ornare risus. Vestibulum id
			magna a nunc posuere laoreet. Integer iaculis leo vitae nibh. Nam
			vulputate, mauris vitae luctus pharetra, pede neque bibendum tellus,
			facilisis commodo diam nisi eget lacus. Duis consectetuer pulvinar
			nisi. Cras interdum ultricies sem. Nullam tristique. Suspendisse
			elementum purus eu nisl. Nulla facilisi. Phasellus ultricies
			ullamcorper lorem. Sed euismod ante vitae lacus. Nam nunc leo, congue
			vehicula, luctus ac, tempus non, ante. Morbi suscipit purus a nulla.
			Sed eu diam.</p>
		<p>Vestibulum ante ipsum primis in faucibus orci luctus et
			ultrices posuere cubilia Curae; Cras imperdiet felis id velit. Ut non
			quam at sem dictum ullamcorper. Vestibulum pharetra purus sed pede.
			Aliquam ultrices, nunc in varius mattis, felis justo pretium magna,
			eget laoreet justo eros id eros. Aliquam elementum diam fringilla
			nulla. Praesent laoreet sapien vel metus. Cras tempus, sapien
			condimentum dictum dapibus, lorem augue fringilla orci, ut tincidunt
			eros nisi eget turpis. Nullam nunc nunc, eleifend et, dictum et,
			pharetra a, neque. Ut feugiat. Aliquam erat volutpat. Donec pretium
			odio nec felis. Phasellus sagittis lacus eget sapien. Donec est.
			Vestibulum ante ipsum primis in faucibus orci luctus et ultrices
			posuere cubilia Curae;</p>
		<p>Vestibulum semper. Nullam non odio. Aliquam quam. Mauris eu
			lectus non nunc auctor ullamcorper. Sed tincidunt molestie enim.
			Phasellus lobortis justo sit amet quam. Duis nulla erat, varius a,
			cursus in, tempor sollicitudin, mauris. Aliquam mi velit,
			consectetuer mattis, consequat tristique, pulvinar ac, nisl. Aliquam
			mattis vehicula elit. Proin quis leo sed tellus scelerisque molestie.
			Quisque luctus. Integer mattis. Donec id augue sed leo aliquam
			egestas. Quisque in sem. Donec dictum enim in dolor. Praesent non
			erat. Nulla ultrices vestibulum quam.</p>
		<p>Duis hendrerit, est vel lobortis sagittis, tortor erat
			scelerisque tortor, sed pellentesque sem enim id metus. Maecenas at
			pede. Nulla velit libero, dictum at, mattis quis, sagittis vel, ante.
			Phasellus faucibus rutrum dui. Cras mauris elit, bibendum at, feugiat
			non, porta id, neque. Nulla et felis nec odio mollis vehicula. Donec
			elementum tincidunt mauris. Duis vel dui. Fusce iaculis enim ac
			nulla. In risus.</p>
		<p>Donec gravida. Donec et enim. Morbi sollicitudin, lacus a
			facilisis pulvinar, odio turpis dapibus elit, in tincidunt turpis
			felis nec libero. Nam vestibulum tempus ipsum. In hac habitasse
			platea dictumst. Nulla facilisi. Donec semper ligula. Donec commodo
			tortor in quam. Etiam massa. Ut tempus ligula eget tellus. Curabitur
			id velit ut velit varius commodo. Vestibulum ante ipsum primis in
			faucibus orci luctus et ultrices posuere cubilia Curae; Nulla
			facilisi. Fusce ornare pellentesque libero. Nunc rhoncus. Suspendisse
			potenti. Ut consequat, leo eu accumsan vehicula, justo sem lobortis
			elit, ac sollicitudin ipsum neque nec ante.</p>
		<p>Aliquam elementum mauris id sem. Vivamus varius, est ut nonummy
			consectetuer, nulla quam bibendum velit, ac gravida nisi felis sit
			amet urna. Aliquam nec risus. Maecenas lacinia purus ut velit.
			Vestibulum ante ipsum primis in faucibus orci luctus et ultrices
			posuere cubilia Curae; Suspendisse sit amet dui vitae lacus fermentum
			sodales. Donec varius dapibus nisl. Praesent at velit id risus
			convallis bibendum. Aliquam felis nibh, rutrum nec, blandit non,
			mattis sit amet, magna. Lorem ipsum dolor sit amet, consectetuer
			adipiscing elit. Pellentesque habitant morbi tristique senectus et
			netus et malesuada fames ac turpis egestas. Etiam varius dignissim
			nibh. Quisque id orci ac ante hendrerit molestie. Aliquam malesuada
			enim non neque.</p>
	</div>
	<div id="center1" class="x-hide-display">
		<p>
			<b>Done reading me? Close me by clicking the X in the top right
				corner.</b>
		</p>
		<p>Vestibulum semper. Nullam non odio. Aliquam quam. Mauris eu
			lectus non nunc auctor ullamcorper. Sed tincidunt molestie enim.
			Phasellus lobortis justo sit amet quam. Duis nulla erat, varius a,
			cursus in, tempor sollicitudin, mauris. Aliquam mi velit,
			consectetuer mattis, consequat tristique, pulvinar ac, nisl. Aliquam
			mattis vehicula elit. Proin quis leo sed tellus scelerisque molestie.
			Quisque luctus. Integer mattis. Donec id augue sed leo aliquam
			egestas. Quisque in sem. Donec dictum enim in dolor. Praesent non
			erat. Nulla ultrices vestibulum quam.</p>
		<p>Duis hendrerit, est vel lobortis sagittis, tortor erat
			scelerisque tortor, sed pellentesque sem enim id metus. Maecenas at
			pede. Nulla velit libero, dictum at, mattis quis, sagittis vel, ante.
			Phasellus faucibus rutrum dui. Cras mauris elit, bibendum at, feugiat
			non, porta id, neque. Nulla et felis nec odio mollis vehicula. Donec
			elementum tincidunt mauris. Duis vel dui. Fusce iaculis enim ac
			nulla. In risus.</p>
		<p>Donec gravida. Donec et enim. Morbi sollicitudin, lacus a
			facilisis pulvinar, odio turpis dapibus elit, in tincidunt turpis
			felis nec libero. Nam vestibulum tempus ipsum. In hac habitasse
			platea dictumst. Nulla facilisi. Donec semper ligula. Donec commodo
			tortor in quam. Etiam massa. Ut tempus ligula eget tellus. Curabitur
			id velit ut velit varius commodo. Vestibulum ante ipsum primis in
			faucibus orci luctus et ultrices posuere cubilia Curae; Nulla
			facilisi. Fusce ornare pellentesque libero. Nunc rhoncus. Suspendisse
			potenti. Ut consequat, leo eu accumsan vehicula, justo sem lobortis
			elit, ac sollicitudin ipsum neque nec ante.</p>
		<p>Aliquam elementum mauris id sem. Vivamus varius, est ut nonummy
			consectetuer, nulla quam bibendum velit, ac gravida nisi felis sit
			amet urna. Aliquam nec risus. Maecenas lacinia purus ut velit.
			Vestibulum ante ipsum primis in faucibus orci luctus et ultrices
			posuere cubilia Curae; Suspendisse sit amet dui vitae lacus fermentum
			sodales. Donec varius dapibus nisl. Praesent at velit id risus
			convallis bibendum. Aliquam felis nibh, rutrum nec, blandit non,
			mattis sit amet, magna. Lorem ipsum dolor sit amet, consectetuer
			adipiscing elit. Pellentesque habitant morbi tristique senectus et
			netus et malesuada fames ac turpis egestas. Etiam varius dignissim
			nibh. Quisque id orci ac ante hendrerit molestie. Aliquam malesuada
			enim non neque.</p>
	</div>
</body>
</html>