package com.lazy.offline.model;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

public class RoleAccess implements Serializable{



	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RBACRoleAccess [rolename=" + roleName + ", accessurl="
				+ accessurl + "]";
	}

	/**
	 * 
	 */
	private String roleName;
	
	
	private int roleId;

	
	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	/**
	 * @return the rolename
	 */
	public String getRoleName() {
		return roleName;
	}

	/**
	 * @param rolename the rolename to set
	 */
	public void setRolename(String roleName) {
		this.roleName = roleName;
	}

	/**
	 * @return the accessurl
	 */
	public String getAccessurl() {
		return accessurl;
	}

	/**
	 * @param accessurl the accessurl to set
	 */
	public void setAccessurl(String accessurl) {
		this.accessurl = accessurl;
	}

	private String accessurl;
	
	
	public boolean isvalidRole(){
		return StringUtils.isNotBlank(getRoleName()) && NumberUtils.isNumber(getRoleId()+"");
	}
}
