= Timers and Threads
#pagebreak()
= gtk timers
The event driven nature is a blessing and a curse.
All processing has to happen based upon user input. But, what do
you do if that is not enough?

== Idle Functions
on linux, use 'top' to see how busy the system is.

```C
#include <gtkmm.h>
#include <iostream>

class ExampleWindow : public Gtk::Window 
{
	int count;
public:
  ExampleWindow() 
  {
	count = 0;
       	m_conn = Glib::signal_idle().connect(sigc::mem_fun(*this, &ExampleWindow::on_idle));
  }

  ~ExampleWindow() 
  {
    	m_conn.disconnect();
  }

private:
  bool on_idle() 
  {
	std::cout << count << std::endl;
	count++;
	return true;
  }

  sigc::connection m_conn;
};


int main(int argc, char* argv[])
{
  auto app = Gtk::Application::create("org.gtkmm.example");

  //Shows the window and returns when it is closed.
  return app->make_window_and_run<ExampleWindow>(argc, argv);
}
```
#pagebreak()
== Timer Mechanics
A timer causes a callback at a specific time.  It can be once or go on forever. The callback continues until the function
returns a false.

-Lambda
```C

    m_timer = Glib::signal_timeout().connect([this]() -> bool 
		    {
      			std::cout << "Tick: " << ++m_count << '\n';
      			return m_count < 5; // Stops automatically after 5 ticks
    }, 1000);
```

-Function in the same class
```C

  bool tick()
  {
	  std::cout << "it is a tick" << std::endl;
	  return true;
  }


  m_timer = Glib::signal_timeout().connect(sigc::mem_fun(*this, &MyWindow::tick), 1000);
  ```

  -Standalone function
```C
bool TICK()
{
	std::cout << "TICK " << std::endl;
	return true;
}




    m_timer = Glib::signal_timeout().connect(sigc::ptr_fun(&TICK), 1000);
```


For a one-shot timer, use connect_once.
```C
    Glib::signal_timeout().connect_once([]() {
      std::cout << "2 seconds elapsed!\n";
    }, 2000);
```

Note these callbacks are thread safe when used with gtkmm gui elements.


== Introduction to Threads
- Multi Processing
- Multi Threading
- Multi Processing

Two or more concurrent 'threads of control'


https://cplusplus.com/reference/thread/thread/




communicating between threads with globals is a bad idea.

Operating System primitives are useful.  std::nutex is the easiest place to start.



== 
#pagebreak()
= Memory Management
== Old School
Everything you create, you must delete.
RAII is a good rule.
Can get complex with copying objects.
Tradeoff of deep and shallow pointers.

== use objects and the stack
Put everything on the stack. (minimise use of pointers to access data)
Design your code so the stack clean up is all you need.
Nice in theory, works for some systems, hard most of the time

== managed pointers
C++ managed pointers.

```C
auto pButton = Gtk::make_managed<Gtk::Button>("Test");
box.append(*pButton); // Container deletes pButton later automatically
```


