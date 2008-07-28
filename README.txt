= ruby-lvm-attrib

* http://ruby-lvm-attrib.rubyforge.org
* mailto:mkent@magoazul.com

== DESCRIPTION:

This is a list of attributes for lvm objects. They are generated from the 
source code and broken down by version.

At their core these files exist to determine which arguments to pass
lvs/vgs/pvs and the subsequent type conversions.

Currently this is split from the main ruby-lvm gem since these files require
updating to follow LVM2 releases.

== FEATURES/PROBLEMS:

* This library may go away depending on future progress of ruby-lvm.

== SYNOPSIS:

  require 'lvm/attributes'

  attributes = Attributes.load("2.0.36", "vgs.yaml")

== REQUIREMENTS:

* None

== INSTALL:

* sudo gem install ruby-lvm-attrib

== FEEDBACK:

Please feel free to submit patches or constructive criticism, I'm still pretty
new to ruby and object oriented programming in general.

== LICENSE:

(The MIT License)

Copyright (c) 2008 Matthew Kent, Bravenet Web Services Inc. 

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
