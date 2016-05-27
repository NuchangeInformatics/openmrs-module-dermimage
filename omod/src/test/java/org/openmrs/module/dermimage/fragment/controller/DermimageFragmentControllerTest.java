package org.openmrs.module.dermimage.fragment.controller;

import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.api.PatientService;
import org.openmrs.ui.framework.fragment.FragmentConfiguration;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.util.OpenmrsUtil;
import org.openmrs.web.test.BaseModuleWebContextSensitiveTest;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;

import static org.junit.Assert.*;

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

    @Test
    public void shouldDeleteFile() throws Exception {
        String sep = File.separator;
        String patientId = "2";
        String file = "test.png";
        String path = OpenmrsUtil.getApplicationDataDirectory()
                + sep +"patient_images"+sep+patientId+sep+file;
        //System.out.println(path);
        File imgDir = new File(OpenmrsUtil.getApplicationDataDirectory()
                + sep +"patient_images"+sep+patientId+sep+file);
        if (!imgDir.exists()) {
            FileUtils.forceMkdir(imgDir);
        }
        DermimageFragmentController fragmentController =
                (DermimageFragmentController) applicationContext.getBean("dermimageFragmentController");
        Object data = fragmentController.deleteImage(patientId,file);
        String message = data.toString();
        String success = "{message="+ DermimageFragmentController.MESSAGE_SUCCESS +"}";
        //System.out.println(message);
        assertNotNull(data);
        assertEquals("File deletion Error.", success, message);
    }

}