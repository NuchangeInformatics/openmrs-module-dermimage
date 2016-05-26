package org.openmrs.module.dermimage.fragment.controller;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentConfiguration;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.util.OpenmrsUtil;
import org.springframework.web.bind.annotation.RequestParam;
import sun.misc.BASE64Decoder;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;


/**
 * Created by beapen on 28/12/15.
 *
 * Ref: https://github.com/openmrs/openmrs-module-orderentryui/blob/master/omod/src/main/java/org/openmrs/module/orderentryui/fragment/controller/patientdashboard/ActiveDrugOrdersFragmentController.java
 */
public class DermimageFragmentController {


    public void controller(FragmentConfiguration config,
                           @SpringBean("patientService") PatientService patientService,
                           FragmentModel model) throws Exception {
        // unfortunately in OpenMRS 2.1 the coreapps patient page only gives us a patientId for this extension point
        // (not a patient) but I assume we'll fix this to pass patient, so I'll code defensively
        Patient patient;
        config.require("patient|patientId");
        Object pt = config.getAttribute("patient");
        if (pt == null) {
            patient = patientService.getPatient((Integer) config.getAttribute("patientId"));
        } else {
            // in case we are passed a PatientDomainWrapper (but this module doesn't know about emrapi)
            patient = (Patient) (pt instanceof Patient ? pt : PropertyUtils.getProperty(pt, "patient"));
        }

        File imgDir = new File(OpenmrsUtil.getApplicationDataDirectory() + "/patient_images/" +
                patient.getPatientId().toString().trim() + "/");

        if (!imgDir.exists()) {
            FileUtils.forceMkdir(imgDir);
        }
        ArrayList<String> fileNames = new ArrayList<String>(Arrays.asList(imgDir.list()));
        model.addAttribute("patient", patient);
        model.addAttribute("folder", imgDir);
        model.addAttribute("listOfFiles", fileNames);
        model.addAttribute("numberOfFiles", fileNames.size());

     }


    /**
     *
     * @param patientId as String
     * @param type as String
     * @param image as String
     * @return Object with Message: Added
     * @should return object with the message added
     */

    public Object saveWebcam(@RequestParam("patientId") String patientId,
                             @RequestParam("type") String type,
                             @RequestParam("image") String image) {


        if (image != null) {

            try {
                BASE64Decoder decoder = new BASE64Decoder();
                byte[] decodedBytes = decoder.decodeBuffer(image);
                File imgDir = new File(OpenmrsUtil.getApplicationDataDirectory() + "/patient_images/"+patientId+"/");
                if (!imgDir.exists()) {
                    FileUtils.forceMkdir(imgDir);
                }
                String date = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
                FileOutputStream fos = new FileOutputStream(imgDir + "/"
                        + date + ".png");
                fos.write(decodedBytes);
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }



        }

        SimpleObject o = SimpleObject.create("message","Image created!");

        return o;
    }

    /**
     *
     * @param filePath as String
     * @param fileName as String
     * @return Object with Message: Added
     * @should return object with the message added
     */

    public Object postImage(@RequestParam(value = "filePath", required=true) String filePath,
                           @RequestParam(value = "fileName", required=true) String fileName) {

        //Ref: http://stackoverflow.com/questions/10391170/serialize-image-to-a-string
        File image = new File(filePath, fileName);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ObjectOutputStream oos = null;
        try {
            oos = new ObjectOutputStream(baos);
            oos.writeObject(image);
        } catch (IOException e) {
            e.printStackTrace();
        }
        byte[] theBytes = baos.toByteArray();
        StringBuffer buf = new StringBuffer();
        for (byte b : theBytes) {
            buf.append((char) b); // cast to char, then append
        }
        String imgString = buf.toString();

        SimpleObject o = SimpleObject.create("image",imgString);

        return o;
    }

}
