---
title: Building your own Box Part
files: []
editable: true
layout: 2-panels-tree

---
Building your own Codio Box Part is easy and you get the huge benefit that in any Codio project, you can simply type the following command to install an entire component in seconds.

```bash
parts install my_new_box_part
```

#Using this Codio Guide
This Guide explains how to develop and publish your own Box Parts. You can navigate between sections in one of two ways

- using the Table of Contents (opened and closed using the Hamburger icon in the header bar)
- using the navigation buttons in the bottom right of this window.
---
title: Development Process Overview
files: []
editable: false
layout: ""

---
A Box Part is simply a snippet of Ruby code. You do not have to be a Ruby Ninja to write a Box Part although it will obviously make it a little bit easier.

You will have already forked the Box Parts repo on GitHub and loaded it into Codio. The following steps describe the general development process

#Preparation
1. Create a new branch (Git is already fully installed) for your new Part.
1. Create a new ruby package file in `lib/autoparts/packages`. You may want to look at the existing ones as examples.

#Coding the package
1. Define the compilation process. If you are downloading a 64-bit binary from the source, then this is not required.
1. Define the Installation process. This copies files from the extracted archive (`~/.parts/tmp/package_name_version)` to its destination (`~/.parts/packages/package_name/version)`
1. Define an optional post installation process. This allows you to perform additional operations once the package is fully installed, such as sample database, default config files, special folder creation etc.
1. Define service `start`, `stop` and `running` methods. If your package runs as a service, then you will need to define these methods in order to start or stop the service.
1. Define message `tips` method. Allows you to define the message output to the terminal window once the installation process is successfully completed.
1. Define post `uninstall` and `purge` methods. Codio will remove your installed files automatically but the `post_uninstall` and `purge` methods allow you to control the removal process.

#Testing
Now your package file is completed, you should test it and ensure that all relevant Box Parts commands are working (install, uninstall, start, stop, purge, status). You should also ensure that your installed package runs as expected.

#Publishing
At this point, your new Box Part will only work on this Codio project and will not be findable in any other project.

In order to publish it, you will need to push the repo back to GitHub and send us a [pull request](https://help.github.com/articles/creating-a-pull-request).

#Codio Steps
Once your new Box Part has been checked and approved by Codio. We perform these checks as it us important to us that the quality of the Box Parts library is maintained at a high level and to examine them for potential security issues. Once approved,

1. We will compile your Box Part
1. We upload the binary to the Codio Box Parts binary store.
1. Merge your changes, at which point it will be available for all Codio users.

We do the above steps in order to avoid your Box Part needing to be compiled each time it is installed. This will significantly speed up the installation process.



---
title: Dev setup script
files: []
editable: false
layout: ""

---
Box Parts is installed on every Codio Box by default and is installed in the `~/.parts` folder. In order to run Box Parts from the `workspace` folder, which we have just loaded from your forked repo, we need to reconfigure the system slightly.

> **[CLICK HERE]()** to run the reconfiguration script. You only need to do this once.

If you want to see the script, [click here](open_file dev-setup.sh)

---
title: Class definition
files:
  - path: docs/example-part.rb
    action: open
    ref: module Autoparts
    lineCount: 3
editable: true
layout: ""

---
Look at the code in the left panel. The first three lines need to be present in all Parts files. 

```ruby
class MySQL < Package
```

The class definition is the first important line for you to edit. In the example code, `MySQL` is the class name you define. You should choose a name that is unique across all packages.

The package name should use Ruby conventions (CamelCase). This essentially means that the first letter of each word within your class name should be upper case.



---
title: "Descriptions & Version"
files:
  - path: docs/example-part.rb
    action: open
    ref: "name 'mysql'"
    lineCount: 7
editable: false
layout: ""

---
The following class properties are required by your Box Part 

#name
Please note the following aspects of the name

- it must match the file name of your package
- it is the Box Parts package name `parts install packagename`
- it must be unique across all packages 


#version
The version of the component that you are installing

#description
A brief description of the Box Part. Make it just long enought to be meaningful when displayed in the parts listing.

#category
A constant that associates this Box Part with a component category. [Click here](open_file lib/autoparts/category.rb) to view the `lib/autoparts/category.rb` file where these constants are defined.
---
title: Source
files:
  - path: docs/example-part.rb
    action: open
    ref: source_url
    lineCount: 10
editable: false
layout: ""

---
This is where you specify the remote location of the component you want to install. It can be a binary or source code.

- `source_url` - the url of the component
- `source_sha1` '06e1d856cfb1f98844ef92af47d4f4f7036ef294'
- `source_filetype` - should be `tar.gz` or `zip`

#Understanding the process
When you run `parts install package_name` Codio checks whether the component (version specific) exists in the Codio binary store. If it exists, then it will be downloaded and installed (in the `~/.parts/packages/package_name/version`) without executing the Compilation or Installation steps (described in upcoming sections).

Your package will only be present in the binary store once we have approved your Pull request, as described in the 'Development Process Overview' section, and then uploaded your compiled binary to the Codio binary store.

During the development of your new Box Parts package, it will not be present in the Codio binary store and so `parts install package_name` will first run the Compilation step followed by the Installation step. 


#Selecting a fixed version
It is advisable to specify a fixed version of a component rather than the latest build. If you select a latest build, the file will get updated and as such the SHA1 hash will change and your installation will fail.

Some components will provide a directory structure where specific versions are clearly listed. Other components may be available as Git `tags`, in which case you would select the tag in GitHub or any other platform and then look for the Download URL.

#SHA1 hash
If the component does not list the SHA1 hash for you then you will need to manually download the component and calculate the hash yourself.

You can do this as follows from the command line.

```bash
cd ~
mkdir tmp
cd tmp
wget component_url
sha1sum downloaded_filename
```

You will then be shown the SHA1 value, which you can copy and paste into your file.


---
title: Dependencies
files:
  - path: docs/example-part.rb
    action: open
    ref: depends_on
    lineCount: 1
editable: false
layout: ""

---
If your Box Part requires other Box Parts to be installed before your Part is installed then you specify it here.

- `depends_on` followed by a space delimited list of Box Parts

If you need to refer to this dependency in any of your package methods (most likely the compilation step) then you may find the following helper useful 

```ruby
get_dependency("dependent_package_name").prefix_path
```

This will only work if the dependent package is defined with `depends_on`.
---
title: Figuring out the directory name
files:
  - path: docs/example-part.rb
    action: open
    ref: "Dir.chdir('mysql-5.6.13')"
    lineCount: 1
editable: false
layout: ""

---
Before the compilation step, your source is downloaded from the specified URL and unpacked to a temporary location. That location will be the current working directory for the `compilation` and `installation` methods.

You may want to specify the directory name of the unpacked component. You will find code like this in a typical Parts package method

```bash
Dir.chdir('mysql-5.6.13') do
```

To figure out what the correct directory name is, the easiest thing to do is to download the component, then unpack it and review the folder structure.

```bash
cd ~
mkdir tmp
cd tmp
wget component_url
tar -zxvf component.tar.gz
ls -al
```


---
title: Methods
files: []
editable: false
layout: ""

---
Box Parts provides several helper methods to let you reference paths, names, versions etc.

If you want to see all methods, please [click here](open_file lib/autoparts/package.rb).

When you install a package, your files will end up in the following folder structure

~/.parts/packages/package_name/version

#Package Methods
It is worth you being aware of the following methods

- **user** : the Codio user name
- **name_with_version** : package_name-version
- **extracted_archive_path** : path to the temporary folder where the downloaded archive was extracted
- **prefix_path** : destination folder for the installed package
- **etc_path** : the path to your `etc` folder
- **bin_path** :
- **sbin_path** :
- **include_path** :
- **lib_path** :
- **libexec_path** : 
- **share_path** :

#Global Path Methods
You can also reference Box Parts system paths that are not a part of your package to store user related data. Anything placed in these paths will not be removed automatically when you run `parts uninstall`.

- **Path.bin**
- **Path.etc**
- **Path.lib**
- **Path.tmp**
- **Path.var**

To see all available Paths, [click here](open_file lib/autoparts/path.rb)

    
---
title: Compilation
files:
  - path: docs/example-part.rb
    action: open
    ref: def compile
    lineCount: 22
editable: false
layout: ""

---
Compilation is only required if your source contains source code rather than a binary package.

Once you have submitted a Pull Request and it has been accepted, then Codio will manually compile your source and upload a binary to the Codio binary store. This means that `parts install` will not run the compilation (or installation) steps, greatly speeding up the experience for the end user.

While you are the development phase, `parts install` will run the `compile` method in your `.rb` package definition file.

This step contains one or more `execute` statements that are responsible for compiling the component, should compilation be necessary.



---
title: Installation
files:
  - path: docs/example-part.rb
    action: open
    ref: def install
    lineCount: 9
editable: false
layout: ""

---
The installation step follows the compilation step, if there was one. This consists of one or more shell commands that perform the final installation step into `prefix_path`.

---
title: Post Installation tasks
files:
  - path: docs/example-part.rb
    action: open
    ref: def post_install
    lineCount: 14
editable: false
layout: ""

---
The Post Installation step is called once the full installation is completed and carries out tasks such as installing a default database or modifying configuration files.

#Where to put your config files
Once your installation is complete, you should

- Configuration files should be placed in `Path.etc` (e.g. `~/.parts/etc`) or `Path.etc + name` (e.g. `~/.parts/etc/postgresql`).
- Data files (e.g. database files) should be placed in `Path.var + name` (e.g. `~/.parts/var/postgresql`).
- Log files should be placed in `Path.var + 'log' + "#{name}.log"` (e.g. `~/.parts/var/log/postgresql.log`)
---
title: Exporting environment variables
files:
  - path: docs/example-part.rb
    action: open
    ref: def required_env
    lineCount: 5
editable: false
layout: ""

---
You can define environment variables as shown on the left.
---
title: "Services - start, stop & running"
files:
  - path: docs/example-part.rb
    action: open
    ref: def start
    lineCount: 13
editable: false
layout: ""

---
If your Part runs as a service, you will need to implement `start`, `stop` and `running` methods so your Part can be started and stopped from the command line using 

```bash
parts start part_name
parts stop part_name
```

`running` is provided so the `parts status` command can check the status of your service.



---
title: Post installation message
files:
  - path: docs/example-part.rb
    action: open
    ref: def tips
    lineCount: 12
editable: false
layout: ""

---
If you want to display a message in the terminal window once your component has completed the installation then you can do so here.


---
title: "Uninstalling & Purging"
files:
  - path: docs/example-part.rb
    action: open
    ref: def purge
    lineCount: 3
editable: false
layout: ""

---
Box Parts allows a part to be uninstalled using `parts uninstall part_name` or `parts purge part_name`.

#Uninstall
The uninstallation is handled automatically by Box Parts and removes the entire package folder. 

It will not remove any data outside the package folder. If you want to perform custom actions, define them in the `post_uninstall` method.

#Purge
The purge process allows you to remove any user data that is not removed by `parts uninstall`. 
