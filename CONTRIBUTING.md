# Contributing to fog-softlayer

We are happy to accept contributions to fog-softlayer.  Please follow the guidelines below.  

* Sign our contributor agreement (CLA) You can find the [CLA here](./docs/cla-individual.pdf).

* If you're contributing on behalf of your employer we'll need a signed copy of our corporate contributor agreement (CCLA) as well.  You can find the [CCLA here](./docs/cla-corporate.pdf).
    
* Fork the repo, make your changes, and open a pull request.

## Issue Tracking

You can file tickets to describe the bug you'd like to fix or feature you'd
like to add on the [fog-softlayer project](https://github.com/softlayer/fog-softlayer/issues) on github.

## Testing Instructions

To run tests, run the following Ruby tool commands from the root of your local copy of
fog-softlayer:

    bundle install
    bundle exec rake travis
    
**All tests must pass** before your contribution can be merged. Thus it's a good idea
to execute the tests without your change to be sure you understand how to run
them, as well as after to validate that you've avoided regressions.

All but the most trivial changes should include **at least one unit test case** to exercise the
new / changed code; please add tests to your pull request in this common case.

