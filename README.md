# state_restoration_bits

## Steps to make this work

- Android = Go to developer options, find "don't keep activities toggle", turn that on.
- Clone the code
- Run the application
- Scroll down a little
- Minimise the application (do not kill it yourself)
- Open the app again
- You will see the app starting from the beginning now
- After the application starts over, it will automatically scroll you to the position where you left
- For iOS, first follow the steps at the [official documentation](https://master-api.flutter.dev/flutter/services/RestorationManager-class.html) under iOS heading.
- There is a text field also which can be tested for restoration
- Just tap on search and fill the text field and repeat from step 5.