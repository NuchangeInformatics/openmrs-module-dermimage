## Module dependencies

[Module dependency wiki page](https://wiki.openmrs.org/display/docs/Module+Dependencies)
[Refer Ebola example](https://github.com/openmrs/openmrs-module-ebolaexample)    

```
main pom.xml
<dependency>
            <groupId>org.openmrs.module</groupId>
            <artifactId>uicommons-omod</artifactId>
</dependency>

        <dependency>
            <groupId>org.openmrs.module</groupId>
            <artifactId>uiframework-api</artifactId>
        </dependency>

<properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <openMRSVersion>1.10.3</openMRSVersion>
        <openmrsTestutilsVersion>1.5</openmrsTestutilsVersion>
        <appuiVersion>1.3</appuiVersion>
        <webservices.restVersion>2.12</webservices.restVersion>
    </properties>
    
    omod pom and api pom
    
    config.xml
    
    
        <require_modules>
            <require_module version="${uiframeworkVersion}">
                org.openmrs.module.uiframework
            </require_module>
            <require_module version="${appuiVersion}">
                org.openmrs.module.appui
            </require_module>
            <require_module version="${coreappsVersion}">
                org.openmrs.module.coreapps
            </require_module>
            <require_module version="${htmlformentryVersion}">
                org.openmrs.module.htmlformentry
            </require_module>
        </require_modules>
    
```
 
## jetty Form upload size limitation

put jetty-web.xml in openmrs/server/tmp/webapp/WEB-INF/jetty-web.xml with
```
<Configure class="org.eclipse.jetty.webapp.WebAppContext">
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Max Form Size                                                   -->
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <Set name="maxFormContentSize">300000</Set>
</Configure>
```

## Important

jQuery.post requires returnFormat: 'json' 