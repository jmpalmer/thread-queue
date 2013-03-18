#Readme
___

##Purpose
The purpose of this software is to provide an easy to use worker thread queue that enables easy parallelization of code block execution. This queue uses Ruby threads and is Operating System agnostic. 

##Usage
To use this in your code, first create a thread queue object like so:

    queue = WorkQueue.new(count)

Here the count is the number of threads desired in the pool.

Next, add jobs to the queue by calling `add_job` with a block:

    queue.add_job do
      # do work
    end
    
Lastly, tell the queue to wait till all the jobs are completed:

    queue.wait
    
    
And thats it! The queue will begin working as soon as the first job is added and will continue working till the last job is completed. At which point the call to wait will return and allow the rest of your code to execute. 

Please note, calling `wait` is blocking. Also, if no call to `wait` is made and your code completes execution, execution of the worker threads will be prematurely terminated. 




### License
___

The MIT License (MIT)

Copyright (c) 2013 The MITRE Corporation. All rights reserved.
Approved for Public Release; Distribution Unlimited. 13-1125

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.