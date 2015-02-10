# Performatic

Rails 4 performance experiment using database query techniques and caching.


## Techniques

* Eliminate N+1 queries
* Counter caches
* Browser caching
* Fragment caching
* Russian doll caching
* Use newer version of Ruby


## Experiment

This experiment benchmarks the performance by measuring response time while applying different techniques.

### Version of Ruby

Measuring tool : Apache Bench
Target path    : /courses
Number of trial: 30

| Ruby version   | Mean   | Min | Max | Standard deviation | Median |
|----------------|--------|-----|-----|------|--------|
|2.2.0           | 396    | 360 | 482 | 27.1 | 390 |
|2.1.2           | 393    | 361 | 505 | 32.9 | 384 |


*Time in milliseconds (ms)*

### N+1 Queries
