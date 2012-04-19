package com.itg.web.ctl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestMapping;

import com.itg.dao.IMenuItemDAO;
import com.itg.dao.IRolesDAO;
import com.itg.dao.IUserRolesDAO;
import com.itg.dao.UserRole;

import com.itg.dao.MenuItem;

@Controller
public class MenuController {
	private String viewName;

	private IMenuItemDAO menuItemDAO;

	private IUserRolesDAO userRolesDAO;

	public IUserRolesDAO getUserRolesDAO() {
		return userRolesDAO;
	}

	public void setUserRolesDAO(IUserRolesDAO userRolesDAO) {
		this.userRolesDAO = userRolesDAO;
	}

	private IRolesDAO rolesDAO;

	public IRolesDAO getRolesDAO() {
		return rolesDAO;
	}

	public void setRolesDAO(IRolesDAO rolesDAO) {
		this.rolesDAO = rolesDAO;
	}

	// 在ascweb-servlet.xml里配置的,该属性已经被注入userDAOProxy接口了

	public IMenuItemDAO getMenuItemDAO() {

		return menuItemDAO;

	}

	public void setMenuItemDAO(IMenuItemDAO menuItemDAO) {

		this.menuItemDAO = menuItemDAO;

	}

	public String getViewName() {

		return viewName;

	}

	public void setViewName(String viewName) {

		this.viewName = viewName;

	}

	// 注解其url映射

	@SuppressWarnings("unchecked")
	@RequestMapping("/getMenu.do")
	public String index(ModelMap map, HttpServletRequest request,
			HttpServletResponse response) {

		// map是用来设置View层数据的
		MenuItem parent = menuItemDAO.selectMenuItemByID(Integer
				.parseInt(request.getParameter("node")));

		List<MenuItem> l = menuItemDAO.selectMenuItem(parent);

		ArrayList al = new ArrayList();
		String userName = request.getUserPrincipal().getName();
		// Logger logger = Logger.getLogger(this.getClass().toString());
		// logger.info("User Principal: " +
		// request.getUserPrincipal().getName());

		Pattern pp = Pattern.compile("CN=(\\w+)");

		Matcher matcher = pp.matcher(userName);

		List<UserRole> urs = userRolesDAO.findRolesByID(userName);

		List<String> authValue = new ArrayList<String>();
		List<String> roles = new ArrayList<String>();

		for (int i = 0; i < urs.size(); i++) {
			roles.add(urs.get(i).getRole());

		}

		for (int i = 0; i < l.size(); i++) {

			authValue.clear();
			authValue.add(String.valueOf(l.get(i).getID()));

			if (l.get(i).isLeaf()) {

				List<String> menuList = rolesDAO.findAuthValue(roles, "MENUS",
						authValue);

				if (menuList.size() == 0) {
					continue;
				}
			}

			Map m = new HashMap();

			m.put("text", l.get(i).getMenuText());
			m.put("leaf", l.get(i).isLeaf());
			m.put("images", l.get(i).getImages());

			if (l.get(i).isLeaf()) {
				m.put("cls", "file");
			} else {
				m.put("cls", "folder");
			}

			m.put("id", l.get(i).getID());
			m.put("reportId", l.get(i).getReportId());
			m.put("queryString", l.get(i).getQueryString());
			al.add(m);

		}

		JSONArray json = JSONArray.fromObject(al);
		map.put("menuList", json);

		return this.viewName; // 该属性被注入值hello了,就是渲染视图hello.jsp

	}

}
