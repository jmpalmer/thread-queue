# The MIT License (MIT)
# Copyright (c) 2013 The MITRE Corporation. All rights reserved.
# Approved for Public Release; Distribution Unlimited. 13-1125
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#--------------------------------------------------------------------------------------------------------
# Worker Thread Queue for simple, easy parallelization of code block execution

require 'thread_queue/version'
require 'thread'

class ThreadQueue
  def initialize(count = 3)
    @count = count                      #number of threads allowed in thread pool
    @running_count = 0                  #number of threads currently running
    @jobs = []                          #array holding desired jobs
    @thread_group = ThreadGroup.new     #thread group for job threads
    @semaphore = Mutex.new              #semaphore for thread safety
  end

  #### Public Methods ####

  # call to add job to the queue
  def add_job(&block)

    #semaphore used force array modifications to be thread safe
    @semaphore.synchronize do
      @jobs << block
    end

    #call spooler
    spooler
  end

  # call to force program to wait for threads to finish
  def wait
    while (@running_count != 0) do
      sleep(0.5)
    end
  end

  #### Private Methods ####
  private

  # actually creates execution thread
  def create_thread (block)

    thread = Thread.new {

      #execute the desired code
      block.yield

      #once finished, try to fire off another thread
      add_thread

      #decremement running_count before exiting (enforce thread safety)
      @semaphore.synchronize do
        @running_count = @running_count - 1
      end
    }
  end

  # called by add job, fires off a thread if there is space available in thread pool
  def spooler
    if @thread_group.list.size < @count
      add_thread
    end
  end

  # called to check if there are jobs in the queue
  # will only fire off a new job if there are some waiting to be executed
  def add_thread
    if !@jobs.empty?

      #semaphore used force array modifications to be thread safe
      @semaphore.synchronize do
        @running_count = @running_count + 1
        @thread_group.add(create_thread(@jobs.delete_at(0)))
      end

    end
  end

end
