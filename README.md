### This is a fork of the dart-grec-minimal package

- Find the original here: []()
- The motivation to fork rather than contribute is simply that I will tweak it to my use case. I recommend you use the original package.


*NB*: The rest of this Readme is the original readme from the original package.

# grec_minimal [![Build Status](https://travis-ci.org/moznion/dart-grec-minimal.svg?branch=master)](https://travis-ci.org/moznion/dart-grec-minimal)

A minimal parser/generator of Google Calendar recurrence rule for dart.

## Synopsis

### Parse recurrence rule text(s)


```dart
import 'package:grec_minimal/grec_minimal.dart';

void main() {
  final List<String> recurrenceRuleTexts = [
    'RRULE:FREQ=DAILY',
    // put recurrence rule texts
  ];

  List<RecurrenceRule> rules;
  try {
    rules = GrecMinimal.fromTexts(recurrenceRuleTexts);
  } catch (ex) {
    // There is possibility to occur InvalidSyntaxException and/or ConditionalException
    // do something
    rethrow;
  }

  rules.forEach((rule) {
    // do something
    print(rule.asRuleText());
  });
}
```

### Dump recurrence rule text(s) from rule object(s)
 
```dart
import 'package:grec_minimal/grec_minimal.dart';

void main() {
  final List<String> ruleTexts = GrecMinimal.toTexts([
    new RecurrenceRule(Frequency.DAILY, 123, null, 2, null),
    // put recurrence rule object as you like
  ]);

  ruleTexts.forEach((ruleText) {
    // do something
    print(ruleText);
  });
}
```
 
See also: [example/](./example)

## Description

grec_minimal is a simple parser/generator of recurrence rule for Google Calendar.

This library provides two funnctions:

- A parsing function of recurrence rule text(s) that is generated by Google Calendar.
It outputs recurrence rule object(s) according to give text(s). 
- A generating function of recurrence rule text(s) from give rule object(s).

i.e. This library is an implementation of a **subset** of [RFC 5545](https://tools.ietf.org/html/rfc5545).

## Disclaimer

This is **not** a full implementation of [RFC 5545](https://tools.ietf.org/html/rfc5545).
This library is focused on using Google Calendar. It means some features are not supported (e.g. `SECONDLY`, `MINUTELY`).

So if you need full implementation of RFC 5545, please consider other libraries.

## License

```
The MIT License (MIT)
Copyright © 2018 moznion, http://moznion.net/ <moznion@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
