/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.dermimage.api.impl;

import org.openmrs.api.impl.BaseOpenmrsService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.dermimage.api.DermimageService;
import org.openmrs.module.dermimage.api.db.DermimageDAO;

/**
 * It is a default implementation of {@link DermimageService}.
 */
public class DermimageServiceImpl extends BaseOpenmrsService implements DermimageService {
	
	protected final Log log = LogFactory.getLog(this.getClass());
	
	private DermimageDAO dao;
	
	/**
     * @param dao the dao to set
     */
    public void setDao(DermimageDAO dao) {
	    this.dao = dao;
    }
    
    /**
     * @return the dao
     */
    public DermimageDAO getDao() {
	    return dao;
    }
}