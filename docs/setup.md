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

* jQuery.post requires returnFormat: 'json' 
* alt+enter on classname to create test in IntelliJ

## Creating a test folder
* copy path of the controller directory
* create new folder under src change main to test.
* remove path before main.
* File -> Project structure -> java folder as test src 
* alt+enter on classname to create Test
* add extends BaseModuleWebContextSensitiveTest 
* ADD to webModuleApplicationContext.xml

```
<bean id="dermimageFragmentController"
		  class="org.openmrs.module.dermimage.fragment.controller.DermimageFragmentController"/>
		  
```
		  
* Use text cases PatientId 2

## How to create a servlet
* create a folder servlet under omod/src/java at same level as page, fragment, web and extension.
* Add servlet defenition to <config class="xml"></config>

```
<servlet>
        <servlet-name>ImageServlet</servlet-name>
        <servlet-class>${project.parent.groupId}.${project.parent.artifactId}.servlet.ImageServlet</servlet-class>
    </servlet>
```
Access servlet as: src="../../moduleServlet/dermimage/ImageServlet

## Steps in releasing a module while using gitflow
* Finish Feature  (Now in develop)
* mvn release:branch -DbranchName=feature/featureBranch
* mvn release:clean
* Start release
* Finish release
* Push to repository
