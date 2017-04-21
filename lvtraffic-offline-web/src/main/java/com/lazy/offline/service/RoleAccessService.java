package com.lazy.offline.service;

import com.lazy.offline.model.RoleAccess;

public interface RoleAccessService {
	
	public boolean hasAccess(RoleAccess ra);

}
