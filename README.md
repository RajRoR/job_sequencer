<a href="https://frontend.code-inspector.com/public/user/github/RajRoR">
   <img src="https://code-inspector.com/public/badge/user/github/RajRoR?style=light" alt="code inspector badge" />
</a>

# Job Sequencer

Imagine we have a list of jobs, each represented by a character. Because certain jobs must be done before others, a job may have a
dependency on another job. For example, a may depend on b, meaning the final sequence of jobs should place b before a. If a has no
dependency, the position of a in the final sequence does not matter.

- Given you’re passed an empty string (no jobs), the result should be an empty sequence.

#

- Given the following job structure:
```
a =>
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be a sequence consisting of a single job a.

#

- Given the following job structure:
```
a =>
b =>
c =>
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be a sequence containing all three jobs abc in no significant order.

#

- Given the following job structure:
```
a =>
b => c
c =>
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be a sequence that positions c before b, containing all three jobs abc.

#

- Given the following job structure:
```
a =>
b => c
c => f
d => a
e => b
f =>
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be a sequence that positions f before c, c before b, b before e and a before d containing all six jobs abcdef.

#

- Given the following job structure:
```
a =>
b =>
c => c
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be an error stating that jobs can’t depend on themselves.

#

- Given the following job structure:
```
a =>
b => c
c => f
d => a
e =>
f => b
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
The result should be an error stating that jobs can’t have circular dependencies.

---

# How to run Program
To run the program you need to run: `$ ruby bin/job_sequencer.rb <input>`
Some examples are:
- Single line input
```
$ ruby bin/job_sequencer.rb 'a => '
```
- Multiline input
```
$ ruby bin/job_sequencer.rb 'a =>\
  b => c \
  d => f \
  f => '
```

# How to run tests
 - You can simply run all the tests by running:
   - `rspec spec`
 - If you want to run specifically for JobSequencer then run:
   - `rspec spec/lib/job_sequencer_spec.rb`

# How to run Rubocop
You can run `rubocop` to run rubocop on the whole application.
To run it specifically for a file then run `rubocop <filename>`
