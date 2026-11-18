= Introduction to gtkmm
== What is gtkmm?
gtkmm is the windowing library for gnome, one of the window managers available on linux (and other systems, if you desire).  The current version is gtkmm-4.0 .  It is a C++ native library and is widely used.  This library has been around a long time, so there is a lot of info on the web; of which 95% of it is old.  Keep this in mind.

== Installation
debian(and derivatives)

% sudo apt install libgtkmm-4.0-dev pkg-config


== Problem Areas
- windows
- WSL
- Linux distributions in transition from X to Wayland
== Documentation Sources
- https://gtkmm.gnome.org/en/index.html
- on the USB image used for assessments
== Event Driven
gui programming uses a different programming paradigm.  It is 'event driven'.  Code is executed only in response to an event that occurs.  

A majority of events come from the user; however events can come from the network (a packet has arrived) or the operating system (a timer has expired)

The responsiveness and overall latency of the program are important non-functional requirements of gui programs.  (that many times are ignored by the implementers)

CpE students will encounter many of the concepts and solutions seen in gui programs later on as they deal with embedded programming topics.

== Tutorials / Examples
The example code is derived from / shamelessly stolen from the gtkmm documentation and the tutorial.  Why?  The examples are very well done.


#pagebreak()
== Main Window
Here is probably the simplest gtkmm program.

```C
#include <gtkmm.h>

class MyWindow : public Gtk::Window
{
public:
  MyWindow();
};

MyWindow::MyWindow()
{
  set_title("Basic application");
  set_default_size(200, 200);
}

int main(int argc, char* argv[])
{
  auto app = Gtk::Application::create("org.gtkmm.examples.base");

  return app->make_window_and_run<MyWindow>(argc, argv);
}
``` 
To look at:
- the return in main.  app->make_window_and_run<MyWindow>(argc,argv) returns when it is desired for the program to exit.
- use of "otto" to determine the type of a variable.  (gtkmm has some long typenames, this is a significant help in writing the code)
- handling of command line arguments (argv and argc)
- extensive use of inheritance



#pagebreak()
Let's try to compile it using our usual commands in the bash shell.


#image("image.png")

The header file is there, but it is not found without giving the compiler some hints.

pkg-config is a unix program that can help solve this problem, perhaps in a rather elegant way.

#image("image1.png")

Things to notice:
- running pkg-config in a bash sub shell
- -- cflags
- -- libs
- name of the package

pkg-config works with many libraries, providing flags, path to the include files, and path to libraries.

(run pkg-config directly and see the output)

== issues
Sometimes the libraries and include file in gtkmm will have upper and lower case letters in the file names, that do not match the actual names in the file system.  (windows and macOS both are case insensitive)


#pagebreak()

Run it:
% ./base

#image("image2.png")

#pagebreak()
== Widgets
gtkmm program consists of windows, that contain widgets.  A widget is a gui object, like a button or a text box (there are many, many kinds)

 There are containers that hold widgets, like notebooks or frames.  A very popular container is a box().

 For this course, we will use C++ code to place widgets on the window.  There is a runtime feature to gtkmm that uses xml files to place widgets at runtime.  The extra complexity is very useful when developing complex gui programs.
 == strings

 gtkmm program use Glib::ustring instead of std::string.  They are identical most of the time.  Note this restriction only applies to strings based to a gtkmm function; the rest of your program can use std::string .

 #pagebreak()
 = Hello World

 Important things to notice in the code:
 - button callback
 - set_child() 
 - lambda

 #pagebreak()
 = The gtkmm widget tree
 
#image("image3.png")

https://gnome.pages.gitlab.gnome.org/gtkmm/classGtk_1_1Widget.html

= Put Some Buttons in a box
The file is buttons_more.cpp
Specific Items to look at:
- headers used (specific ones, not the 'everything header')
- adding a button
- changing the orientation of the box.

Play with it:
- change orientation with a button press.
- change the function to a lambda
- add a label

Does this work?  (should it?)
```C
    m_box.append(m_another_button);
    Gtk::Label l("i am a text label");
    m_box.append(l);
    set_child(m_box);
```
 
How about this one? 
```C
    m_button.signal_clicked().connect(
        sigc::mem_fun(*this, &ButtonWindow::on_button_clicked));

    m_button.signal_clicked().connect([](){std::cout << "hello" << std::endl;});
```

= Text Boxes
```C
#include <gtkmm.h>
#include <iostream>

class MyWindow : public Gtk::Window {
public:
    MyWindow() {
        set_title("Entry Example");
        set_default_size(300, 100);

        m_entry.set_placeholder_text("Enter your name...");
        m_entry.set_max_length(50);
        
        // Trigger an action when the user presses Enter
        m_entry.signal_activate().connect([this]() {
            std::cout << "Entered: " << m_entry.get_text() << std::endl;
        });

        set_child(m_entry);
    }

private:
    Gtk::Entry m_entry;
};
```
#pagebreak()
There are many different widgets.  The header file is your friend.
= More gtk widgets
- text box
- text box with scrollbar
- text entry box
- check boxes
- radio boxes
- scale
- listview
- column view



#pagebreak()
= gtk timers
The event driven nature is a blessing and a curse.
All processing has to happen based upon user input. But, what do
you do if that is not enough?

== Timer Mechanics

== Introduction to Threads

== 
#pagebreak()
= Memory Management
== Old School
== use objects and the stack
== managed pointers
```C
auto pButton = Gtk::make_managed<Gtk::Button>("Test");
box.append(*pButton); // Container deletes pButton later automatically
```

= Summary on gtk


