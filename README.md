# atym_flutter_app

A simple demo app where user can check a couple of functionalities.  
Is composed by a single page with **BottomNavigationBar** where you can interact with 2 **BottomNavigationBarItems**.

The first item comes pressed by default, where user can play with a simple counter app, increasing,   
decreasing and resetting the counter. The business logic is separated form UI and BloC pattern is used for that.  
Each time user preses a button, cubit event is emitted and UI refreshes.

The second item will take the user to the super heroes list. The real endpoint is consumed, processed using repository pattern  
and displayed the same way as counter, using BloC pattern. The UI itself has different states, **Loading, Error and Data State**.

**Loading state** will appear when data is being fetched from the endpoint.   
**Error state** will trigger only when something fails during the endpoint consumption, like 404 exception of Offline state.   
**Data state** will render a list of super heroes composed by default **ListTiles**, with cached network image for leading avatar and simple text for title/subtitle and trailing. When user tapes on some of this items, a card dialog will appear with super hero image on top and statistics on the bottom. There you can observe the power/intelligence/strength/speed/combat/durability of this hero and also the shadow of the avatar which will change the color according the hero's statistics. The following formula is used:

if(0 <= this && this < 20) return red color;  
if(20 <= this && this < 40) return orange color;  
if(40 <= this && this < 60) return yellow color;  
if(60 <= this && this < 80) return blue color;  
if(80 <= this) return green color;

If the card is tapped back, the dialog will dismiss using animation.

# EXTRAS

The app is wrapped with **connectivity listener**, so once the connection is lost, the **animated dialog** will appear indicating that you do not have the network connection. This dialog will remain visible until the connection will not turn back. When this happens, the dialog will be updated with new one, indicating that you are online. Will disappear after 2 seconds.

Also the app supports **localizations**. On the app bar, user can see the **translation** icon so if he taps on it, a **bottom dialog** will appear indicating that you can switch to the new locale. Only **English** and **Spanish** are currently supported.

App uses **dart code metrics** with useful rules. Check the **analysis_options.yaml** for more info.

The app is consistent, so if you try to get the heroes list being offline, it will give you the **Offline Error State**.  
Once the connection is back, app will try to **refresh the content automatically**. Also, if we already have the data, it will not be fetched back.

# TESTS

All the app is tested with **Unit** and **Widget Tests**.
App was built/compiled and executed in the real **Android Google Pixel XL** device.

# EXAMPLES

### Testing counter

### Testing connectivity

### Testing heroes list
