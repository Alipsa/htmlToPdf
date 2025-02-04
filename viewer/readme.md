# Journo Viewer

The Journo Viewer is a javafx application simplifying the workflow of creating Freemarker Templates that are rendered into a PDF using Journo. 

## Installing and Running journo via maven
A simple way to run Journo, provided you have maven and java >= 21 installed, is to do the following
- download the journoViewer.xml from [github](https://github.com/Alipsa/journo/releases)
- put the journoViewer.xml file in a directory of choice
- open a command prompt in that directory and execute `mvn -f journoViewer.xml javafx:run`

This way you do not need to install a jdk with javafx included, any java jdk version 21 or above will work.

## Installing the zipped release package
Zipped releases are available on [github](https://github.com/Alipsa/journo/releases)
Note: prior to version 0.6.3 the journo viewer was packaged into 3 different zip files,
one for each platform, but from version 0.6.3 all platform have been combined into a single 
zip file. You need to have a JDK with Javafx included, such as the [Bellsoft full distribution](https://bell-sw.com/pages/downloads/#jdk-21-lts) to run the Journo GUI this way. 

### Mac
1. Downloaded the release (journo-viewer.zip) and unzip it
2. Move the unzipped `journo.app` to your applications folder
3. The first time you run it you must right-click and choose `open` to establish it
as a trusted application

### Linux
1. Downloaded the release (journo-viewer.zip)
2. Move the unzipped `journo.app` folder to a location of choice
3. Run the `journo.app/createLauncher.sh` script to create a launcher (shortcut)

### Windows
1. Downloaded the release (journo-viewer.zip)
2. Move the unzipped `journo.app` folder to a location of choice
3. Run the `journo.app\createShortcut.ps1` script to create a shortcut

## Groovy code to generate data
Using groovy scripts makes it easy to create mock data to provide input data to Freemarker.
Groovy is almost 100% compatible with Java syntax but adds some nice things such as:

- include dependencies using @Grab
- shortened syntax for creating lists and maps
- shorthand syntax for accessing ans assigning values to lists and maps

The last line (the return value) of the Groovy script must be a Map<String, Object>. Each variable in the freemarker template (e.g. ${myVar}) corresponds to a key in the Map and will be replaced wing the Map value for that key.

Here is a simple example:

assuming a ftl with the following content:
```injectedfreemarker
<html>
<body>
<h1>Hello</h1>
<p>Nice to see you ${name}!</p>
Your phone number is
<#if isValidNumber>
    valid
<#else>
    not valid
</#if>

<p>There you go, nice huh?</p>
</body>
</html>
```

You can populate the two variable used with the following groovy script:
```groovy
@Grab('com.googlecode.libphonenumber:libphonenumber:8.13.29')
import com.google.i18n.phonenumbers.PhoneNumberUtil

PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.getInstance()
def number = phoneNumberUtil.parseAndKeepRawInput('070-1232345', "SE")

// Using the groovy shorthand syntax to create a LinkedHashMAp<String, Object>
[
  name: 'Per',
  isValidNumber: phoneNumberUtil.isPossibleNumber(number)
]
```

# Building the journo viewer
Journo uses maven. The prerequisites for building are
1. A JDK version 21 or later
2. Maven version 3.8.4 or later installed

Then it's just a matter of `mvn install`!