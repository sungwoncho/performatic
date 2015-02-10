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
|2.1.2           | 128    | 111 | 167 | 12.1 | 125 |
|2.2.0           | 120    | 109 | 146 | 8.7  | 117 |


*Time in milliseconds (ms)*

### N+1 Queries

* Use Bullet gem to detect N+1 query.

|           | Mean   | Min | Max | Standard deviation | Median |
|-----------|--------|-----|-----|------|--------|
| true      | 120    | 109 | 146 | 8.7  | 117 |
| false     | 108    | 100 | 121 | 5.0  | 108 |

### Counter-cache

|           | Mean   | Min | Max | Standard deviation | Median |
|-----------|--------|-----|-----|------|--------|
| before    | 108    | 100 | 121 | 5.0  | 108 |
| after     | 68     | 62  | 76  | 3.8  | 68  |

Counter-caching improved the performance by about 63%.


### Add Indices on foreign keys

* Use lol_dba gem to detect missing indices

|           | Mean   | Min | Max | Standard deviation | Median |
|-----------|--------|-----|-----|------|--------|
| before    | 68     | 62  | 76  | 3.8  | 68  |
| after     | 69     | 62  | 75  | 3.6  | 69  |


### Use select in ActiveRecord query

|           | Mean   | Min | Max | Standard deviation | Median |
|-----------|--------|-----|-----|------|--------|
| before    | 69     | 62  | 75  | 3.6  | 69  |
| after     | 66     | 59  | 72  | 3.3  | 67  |


### Fragment caching

The file system was used to store caches, but it is not recommended in production.

|           | Mean   | Min | Max | Standard deviation | Median |
|-----------|--------|-----|-----|------|--------|
| before    | 67     | 62  | 73  | 3.2  | 66  |
| after     | 37     | 33  | 45  | 3.1  | 36  |
