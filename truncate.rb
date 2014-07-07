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



##############################################################################################


require "rubygems"
require "sinatra"
require "erubis"
require "bundler"


get "/" do
  erb :index
end

get "/process_truncation" do
  truncated = truncate(params[:string], params[:num_words].to_i)
  "#{truncated}"
end

__END__

@@ index
<html>
  <head>
    <title>Smart Truncation</title>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script tpye="text/javascript">
      /*!
        instance.js v1.0.1: A lightweight javascript library to model data on the client side
        before sending it off to the server.
        Created by @adammcarth under the MIT license
      */
      function ensureArray(a){var b=[];return"string"==typeof a?b.concat(a):a}var Instance=function(a){this.attributes={},a.defaults&&(this.defaults=a.defaults,this.attributes=Object.create(this.defaults)),this.name=a.name,this.url=a.url,this.method=a.method,this.headers=a.headers,this.success=a.success,this.error=a.error,this.fields=[],this.elements=[],this.removeQueue=[]};Array.prototype.removeByValue=function(a){for(var b=0;b<this.length;b++)if(this[b]==a){this.splice(b,1);break}},Instance.prototype.add=function(a){Object.keys(a).forEach(function(b){this.attributes[b]=a[b]},this)},Instance.prototype.addField=function(a){a=ensureArray(a),this.fields=this.fields.concat(a)},Instance.prototype.addElement=function(a){a=ensureArray(a),this.elements=this.elements.concat(a)},Instance.prototype.get=function(a){var b,c;return this.fields.forEach(function(a){b=document.getElementsByName(a)[0],this.attributes[a]=void 0===b||""===b.value?void 0:b.value},this),this.elements.forEach(function(a){c=document.getElementById(a),this.attributes[a]=null===c||""===c.innerHTML?void 0:c.innerHTML},this),this.removeQueue.forEach(function(a){delete this.attributes[a],this.fields.removeByValue(a),this.elements.removeByValue(a)},this),this.removeQueue=[],a?this.attributes[a]:this.attributes},Instance.prototype.remove=function(a){a=ensureArray(a),this.removeQueue=this.removeQueue.concat(a)},Instance.prototype.reset=function(){this.attributes={},this.defaults&&(this.attributes=this.defaults)},Instance.prototype.clear=function(){this.attributes={}},Instance.prototype.send=function(a,b){var c=this,d=new XMLHttpRequest,e="",f="",g=(this.get(),this.headers);d.onreadystatechange=function(){4===d.readyState&&(200===d.status?c.success(this.responseText):c.error(d.status,this.responseText))},b=b||this.method||"POST",b=b.toUpperCase(),a=a||this.url||"./",Object.keys(this.get()).forEach(function(a){e+="&",f=void 0===this.get(a)?"":encodeURIComponent(this.get(a)),e+=this.name?this.name+"["+a+"]="+f:a+"="+f},this),"GET"===b&&(a=a+"?"+e),d.open(b,a,!0),d.setRequestHeader("Content-type","application/x-www-form-urlencoded"),g&&Object.keys(g).forEach(function(a){d.setRequestHeader(a,g[a])}),d.send(e)};
    </script>
  </head>

  <body>
    <p>
      <input type="text" name="string" placeholder="Enter a sentence to be shortened..." style="width:400px; padding:10px;">
    </p>
    <p>
      <label>How many words would you like from the sentence?</label><br />
      <input type="text" name="num_words" style="width:50px; text-align:center; padding:10px;">
    </p>
    <button id="truncate">Truncate!</button>

    <div class="results hidden" style="background:#DDD; border-radius:3px; margin-top:20px; padding:30px; width: 500px; font-size:15px; font-family: Helvetica, Arial, sans-serif; display:none;"></div>

    <script type="text/javascript">
      var Truncation = new Instance({
        "url": "/process_truncation",
        "method": "get",
        success: function(response) {
          $(".results.hidden").slideDown(500);
          $(".results").removeClass("hidden");
          $(".results").text(response);
        },
        error: function(error) {
          alert("Oops. Something went wrong during the truncation. The server hit back with an Error " + error);
        }
      });

      Truncation.addField(["string", "num_words"])

      $("#truncate").click(function() {
        Truncation.send();
      });
    </script>
  </body>
</html>