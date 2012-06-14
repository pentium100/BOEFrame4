package com.itg.util;

import java.util.Comparator;
import java.util.Map;

import com.itg.dao.MenuItem;

public class MenuItemComparator implements Comparator<Map> {

	public int compare(Map o1, Map o2) {

		return ((String) o1.get("text")).compareTo((String) o2.get("text"));

	}

}
