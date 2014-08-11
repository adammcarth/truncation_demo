A demo for a smart truncation script I created. [http://smart-trunction.herokuapp.com](http://smart-trunction.herokuapp.com)

Visit the tutorial here: [Smart Truncation Techniques For Difficult Web Layouts](http://adammcarthur.net/truncation-techniques/).

```ruby
# Intelligent string truncation function
# written in Ruby.
def truncate(string, words)
  # Define the maximum number of characters that can be used before
  # standard truncation is applied (prevents long words from ruinning HTML).
  max_chars = 6 * words
  words_array = string.split(" ") # splits each word into an array ["like", "this"]
  index = words - 1 # array indexes start at 0, so let's take one number off the words amount.
  truncated = words_array[0..index].join(" ")

  if truncated.length > max_chars
    # Use standard truncation (set amount of characters)
    truncated = string.slice(0, max_chars) + "..."
  elsif truncated == string
    # `truncated` and the original string are identical, so don't include "..."
    truncated = string
  else
    # If everything's checked out, we'll be using worded truncation. This simply adds
    # "..." to the worded truncation variable.
    truncated = truncated + "..."
  end

  # Output the results
  return truncated
end
```
