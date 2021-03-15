# RTP

**Make a streaming Twitter sentiment analysis system**

* You will have to read 2 SSE streams of actual Twitter API tweets in JSON format. For Elixir use this project to read SSE: https://github.com/cwc/eventsource_ex
* The streams are available from a Docker container, alexburlacu/rtp-server:faf18x, just like Lab 1 PR, only now it's on port 4000
* To make things interesting, the rate of messages varies by up to an order of magnitude, from 100s to 1000s.
* Then, you route the messages to a group of workers that need to be autoscaled, you will need to scale up the workers (have more) when the rate is high, and less actors when the rate is low
* Route/load balance messages among worker actors in a round robin fashion
* Occasionally you will receive "kill messages", on which you have to crash the workers.
* To continue running the system you will have to have a supervisor/restart policy for the workers.
* The worker actors also must have a random sleep, in the range of 50ms to 500ms, normally distributed. This is necessary to make the system behave more like a real one + give the router/load balancer a bit of a hard time + for the optional speculative execution. The output will be shown as log messages.

## Installation

run `mix get.deps` to install dependencies

## Run

run `mix run --no-halt` to run the app


## Demo


https://user-images.githubusercontent.com/56967906/111125735-9f4c1580-857a-11eb-98d8-59272d9be3a4.mp4
