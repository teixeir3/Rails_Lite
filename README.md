# Active Record Lite
* Web server MVC framework inspired by the functionality of Ruby on Rails


  
# Using the specs
Some specs have been written to guide you towards the lite :) There are rspec
specs in the `spec` directory and ruby code for you to test with in the `test`
directory.

## Suggested Order
0.  `rspec spec/controller_base_spec.rb`
0.  `rspec spec/session_spec.rb`
0.  `rspec spec/params_spec.rb`
0.  `rspec spec/router_spec.rb`
0.  `rspec spec/integration_spec.rb`

### If you're feeling extra fancy you can run [guard](https://github.com/guard/guard)! 
just type `guard`


## Todo

  * Remove everything about phases (filenames, folders, comments in files)
  * Organize files - you should only have one `ControllerBase` class, not an inheritance chain, but still have it split up over multiple files if it's too big
  * Explain in README how somebody would go about using this instead of Rails
  
  * README:
    * Description/instructions on how to use and run code
    * List of techs/languages/plugins/APIs used
    * Technical implementation details for anything worth mentioning (basically anything you had to stop and think about before building)
      * Include links to the neatest parts of the code
      * Include screenshots of anything that looks pretty
    *future features
  * Go through the whole thing and refactor everything. There will be a lot of obvious things to refactor since you're a much better developer now.
  * Have only 1 class per file - no matter how small the class.
    * Name the files the same as the class (camel_cased).
  * Organize into /lib and /lib/pieces
  * Explain in README how someone would go about downloading and running this.
