package org.openmrs.module.dermimage.fragment.controller;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.api.PatientService;
import org.openmrs.ui.framework.fragment.FragmentConfiguration;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.web.test.BaseModuleWebContextSensitiveTest;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * Created by beapen on 25/05/16.
 */
public class DermimageFragmentControllerTest extends BaseModuleWebContextSensitiveTest {
    @Autowired
    private PatientService patientService;

    @Before
    public void setUp() throws Exception {

    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void shouldReturnModelAttributes() throws Exception {

        DermimageFragmentController fragmentController =
                (DermimageFragmentController) applicationContext.getBean("dermimageFragmentController");
        PatientService patientService =
                (PatientService) applicationContext.getBean("patientService");
        FragmentModel mav = new FragmentModel();
        FragmentConfiguration config =  new FragmentConfiguration();
        config.addAttribute("patientId",2);  //2 is a test patient
        fragmentController.controller(config, patientService, mav);
        assertTrue(mav.containsKey("patient"));
        assertTrue(mav.containsKey("folder"));
        assertTrue(mav.containsKey("listOfFiles"));
        assertTrue(mav.containsKey("numberOfFiles"));
        assertNotNull(mav.getAttribute("patient"));

    }

}