# This project is no longer maintained and should not be used in production.

This repository is kept on github just for historical reasons. This project was the migration from PHP4 to PHP5 of the Akelos Framework.

Introduction.
---------------------------------------

The Akelos Framework is an open-source port of Ruby on Rails to the
PHP programming language.

The main goal of the Akelos Framework its to help programmers to build
multilingual database-backed web applications according to the
Model-View-Control pattern. It lets you write less code by favoring
conventions over configuration.

You can find more information at the Akelos Framework website at
http://www.akelos.org


The tutorial
---------------------------------------
Perhaps the easiest way to lear about Akelos is to get your hands on the tutorials you can find on the docs folder.


Installing Akelos
---------------------------------------
In most cases, the easiest way to install Akelos is to unpack the Akelos tar.gz/zip file.

NOTE: If you want to keep up with cutting-edge changes to Akelos, you'll want to clone the ["Akelos source code"](http://github.com/akelos/akelos/tree/master) from github. This is not recommended as an option for beginners, though.

### Creating the Blog Application

Open a terminal, navigate to the folder where you uncompressed Akelos and type:

    $ ./akelos /path/to/your/new/site

This will create an Akelos application.

TIP: You can see all of the switches that the Akelos application builder accepts by running **./akelos -h**.

After you create the blog application, switch to its folder to continue work directly in that application:

    $ cd /path/to/your/new/site

Now create the database configuration file by running:

    $ ./script/configure 

Alternatively you can manually edit _config/DEFAULT-config.php_ and save it as _config/config.php_

In any case, Akelos will create a folder with the name of your new _site_ at the specified path. Here's a basic rundown on the function of each folder that Akelos creates in a new application by default:

* **README.textile** - This is a brief instruction manual for your application. Use it to tell others what your application does, how to set it up, and so on.
* **makefile.php** - This file contains batch jobs that can be run from the terminal.
* **app/** - Contains the controllers, models, and views for your application. You'll focus on this folder for the remainder of this guide.
* **config/** - Configure your application's runtime rules, routes, database, and more.
* **doc/** - In-depth documentation for your application.
* **lib/** - Extended modules for your application
* **log/** - Application log files.
* **makelos** - Makelos is a general-purpose command-runner that Akelos uses for many things. You can see the list of available makelos commands in your application by running +./makelos -T+.
* **public/** - The only folder seen to the world as-is.  This is where your images, javascript, stylesheets (CSS), and other static files go.
* **scripts/** - Script runners provided by Akelos to do recurring tasks, such as code generation, plugin installation, and starting the console or the web server.
* **test/** - Unit tests, fixtures, and other test apparatus. These are covered in "Testing Akelos Applications":testing.html 
* **tmp/** - Temporary files
* **vendor/** - A place for third-party code. In a typical Akelos application, this includes Akelos source code (if you install it into your project) and plugins containing additional prepackaged functionality.

### Link the public folder to your webroot

Once you are done with the initial setup, you'll need to make available the folder **./public** to your webserver with a command like:

    $ ln -s  /path/to/your/new/site/public /usr/htdocs/akelos_application

Then just point your browser to that url and follow the installation steps.

### Configuring a Database

Just about every Akelos application will interact with a database. The database to use is specified in a configuration file **config/database.yml**.

NOTE: In case the file has not been created by **./script/configure** (or the web setup) you can do this step manually by copying **config/DEFAULT-database.yml** as **config/database.yml**

If you open this file in a new Akelos application, you'll see the database configuration created by ./script/configure. The file contains sections for three different environments in which Akelos can run by default:

* The **development** environment is used on your development computer as you interact manually with the application
* The **test** environment is used to run automated tests
* The **production** environment is used when you deploy your application for the world to use.


Accessing the Command Line interface
---------------------------------------
In order to access the command line interface run

    ./script/console

Then you can run any PHP code interactively.

Example:

	>>> generate

	// Will show a list of available generators

	>>> test app/models/post.php

	// Will run the unit tests for the framework the Post model

You can also use the commands generate, migrate, setup ... by calling directly

     ./script/generate


### Generating a controller

One of the traditional places to start with a new language is by getting some text up on screen quickly. To do that in Akelos, you need to create at minimum a controller and a view. Fortunately, you can do that in a single command. Enter this command in your terminal:

    $ ./makelos generate controller home index

TIP: If you're on Windows, or your PHP is set up in some non-standard fashion, you may need to explicitly pass Akelos **makelos** commands to PHP: **php makelos generate controller home index**.

Akelos will create several files for you, including _app/views/home/index.html.tpl_. This is the template that will be used to display the results of the _index_ action (method) in the _home_ controller. Open this file in your text editor and edit it to contains the following code:

```html
<h1>Home#index</h1>
<p>Find me in app/views/home/index.html.tpl</p>
```


Differences from Ruby on Rails.
---------------------------------------
I've tried to adhere as much as I could to the original interfaces, but some
general changes apply:

- PHP doesn't have name spaces so on the controller you must access to
$this->params, $this->ModelName, $this->Request, $this->Response

- Templates are ended in .tpl (there is only one render on the framework, but
more can be added)

- Views work using PHP, but some like file functions, static method calls,
object instantiation.... will be disallowed for helping in keeping in the
view just presentation logic. If you need extra logic for your views you can
always create a helper "./app/helpers" so your views will be easier to
maintain.

- Helpers are made available automatically for your views under the naming
convention $name_helper were "name" is the name of the desired helper.

    $url_helper->url_for(array('action'=>'add'));

- All the methods (but helpers) use PEAR like naming conventions so instead of
AkActionController::url_for() you need to call AkActionController::urlFor()

- Helpers are located at /lib/AkActionView/helpers (it's worth having a look
at them)

- In order to expose data from your controllers to the views, you'll simply
need to assign them as attributes of the controller that is handling the
action so:

    class PostController extends ApplicationController
    {
          function index()
          {
               $this->message = 'Hello World';
          }
    }

Will expose  into ./app/views/post/index.tpl $message variable so you can use
it like:

    <?php echo $message; ?>

or the same using SinTags

    {message}


i18n and l10n the Akelos way
---------------------------------------

Locale files are located at:

    ./config/locales/  # Akelos Framework locales
    ./app/locales/NAMESPACE/ # Your application locales where NAMESPACE is
     replaced by your model/controller/view name

In order to change the language of your application can prefix your request
with the locale name so:

    http://example.com/es/post/add # will load ./config/locales/es.php
and
    http://example.com/en/post/add # will load ./config/locales/en.php


All the functions for writing multilingual code rely on the Ak::t() method.
Based on the Ak::t() function you can find:

    $PostController->t() # controller
    $Post->t() # model
    $text_helper->translate() # for the view
    _{ hello world }  # for the view (SinTags)

All these four will save new locales onto their corresponding namespace in
the example above "./app/locales/post/en.php"

If you want to use your own namespace for storing locales you can do it like:

    translate('Hello world', null, 'shared_posts');

In this case it will store it at "./app/locales/shared_posts/en.php"


Deal with Compound Messages

As you can see the Framework has been designed with l10n and i18n in mind. One
nice and flexible feature common to all these functions but the sintags one is
the ability to add compounded messages, you might already realized this but
here is a small example:

Ak::t('Hello %title %last_name,',
array('%title'=>$title,'%last_name'=>$last_name,'%first_name'=>$first_name));

    Ak::t('Today is %date', array('%date'=>Ak::getDate()));
    // You can use Ak::t or any of its derived methods

The SinTags way to deal with compounded messages is

    _{Today is %date}
    // which will be converted to
    // <?=$text_helper->translate('Today is %date', array('%date'=>$date));?>
    // note that $date is selected by replacing the % from the needle

Internationalizing Models.

You can have multilingual database columns by adding the locale prefix plus
and underscore to the column name. This way when you do

    $Article->get('title')

you'll get the information on the "en_title" column if "en" is your current
locale.

The same way you can set posted attributes like

    $_POST = array('title'=>array('en'=>'Tech details',
     'es'=>'Detalles técnicos'));
    $Article->setAttributes($_POST);

and the attributes will be mapped to their corresponding columns.

In order to make this work you need to add to your config/config.php

    define('AK_ACTIVE_RECORD_DEFAULT_LOCALES', 'en,es');


In order to convert between charsets you can use Ak::recode() and
Ak::utf8('My  ISO Text', 'ISO-8859-1').




Autocompletion on bash prompts
--------------------------------

You can add bash autocompletion support to Makelos

First you'll need to have installed bash-completion

    Mac OS: sudo port install bash-completion
    Debian: apt-get install bash-completion

Add to the very bottom of your bash profile (Nice post by
Todd Werth http://blog.infinitered.com/entries/show/4 on
the subject)

    Mac OS ~/.profile:


    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi

    Debian ~/.bashrc:


    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi


Create the file

    Mac OS: /opt/local/etc/bash_completion.d/makelos
    Debian: /etc/bash_completion.d/makelos

with the following code

    _makelos()
    {
       local cur colonprefixes arguments
       local -a makelos_cmd
       cvsroots=( $CVSROOT )
       
       COMPREPLY=()
       cur=${COMP_WORDS[COMP_CWORD]}
       # Work-around bash_completion issue where bash
       # interprets a colon
       # as a separator.
       # Work-around borrowed from the darcs/Maven2
       # work-around for the same issue.
       colonprefixes=${cur%"${cur##*:}"}
       arguments=("${COMP_WORDS[@]:1}")
       if [ -f makelos ]
       then 
         makelos_cmd="./makelos"
       else
         makelos_cmd="makelos"
       fi
       COMPREPLY=( $(compgen -W '$($makelos_cmd makelos:autocomplete \
       ${arguments[@]})'  -- $cur))
       local i=${#COMPREPLY[*]}
       while [ $((--i)) -ge 0 ]; do
          COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
       done
       return 0
    } &&
    
    complete -o bashdefault -o default -F _makelos ./makelos 2>/dev/null \
    || complete -o default -F _makelos ./makelos
    
    complete -o bashdefault -o default -F _makelos makelos 2>/dev/null \
    || complete -o default -F _makelos makelos



cd to your app dir in a new prompt and enjoy makelos autocompletion.
