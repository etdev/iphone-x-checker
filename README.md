# iPhone X Stock Checker
Check if the iPhone X is available in Tokyo Apple stores

### Docs

Please see [my blog post](https://etdev.me/taking-the-guesswork-out-of-iphone-x-purchasing-with-ruby-922d720863f6) introducing the project for more information.

### Usage
```
bundle install

ADDRESS="your_email@something.com" \
PASSWORD="your_email_password" \
NAME="Your Name" \
ruby iphone_x_checker.rb
```

To change the product being searched:
* Change the `URL` in `fetcher.rb` by replacing `location` with your zip code, and `MQAY2J/A` with the part number for your product.
* Change the `STORE_NAMES` and `MODEL_NUMBER` in `response.rb` (you'll need to check the JSON being returned when you try the stock checker in a browser to get this information)
