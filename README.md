# Scanty, a really small blog

## Overview

Original [scanty
readme](https://github.com/chischaschos/scanty/blob/master/README.rdoc), but a
few changes:

- Simplified views and coverted them to HAML
- Added specs and fixed test suite
- Updated gems
- Added sprockets
- Added [foundation](http://foundation.zurb.com/)
- Uses [kramdown](https://github.com/gettalong/kramdown) instead of
[maruku](https://github.com/bhollis/maruku/). It is faster and has
better support for embedded html
- Uses [puma](https://github.com/puma/puma)

Made some changes to the default code base in
order to remove empty spaces, fix test suite, upgrade used gems and
customize its configuration.

## Priority fixes

- Server static content fast
- Serve all fast
- Serve multiple requests fast
- Generated markup styles
- Decoupling post model business logic

## Just for fun roadmap:

- Be able to post on any date
- Post review history
- Responsive layouts
- Full JS app consuming API
- Try to improve code so that codeclimate becomes happier [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/chischaschos/scanty)

## Provisioning
Based on https://github.com/radar/ansible-rails-app
