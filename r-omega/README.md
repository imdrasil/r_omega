# R-Omega
This repo represents generator of criteria maps and building R-omega relation on them.
Process consists of 3 steps:

- generating of inputs file for task generation
- generating tasks
- solving tasks

> Note: only description is in English - everywhere else is only Ukrainian.

### Inputs generation
There is html page (`generate_input_file.html`) which automatically generate needed file. You just need to open it in any
modern browser and choose needed parameters (be carefull - not move it from source folder because it uses css nad js files from assets folder).
Anyway you can write file by yourself.
File structure is next:

- first string represents number of described tasks; after it goes blocks of same structure
- criteria relation type (it can be only `equivalence`, `strict_order`, `quasy_order`)
- alternative count
- criteria count
- if you want to use own matrix - put `1`, if generate if - put `0`
- **only if you want to use own matrix** - puts it here, separating columns by spaces and rows by `\n`
- **elsewhere** - put `1` if you want at list 1 non zero element on non diagonal part of generated matrix; 0 - to random generation
- if you choose `quasy_order` - puts here numbers of criteris in each class; for example ` 1 2 3` for 6 criterias.

### Tasks generation
To generate tasks you need to use `generate.rb` script. It accepts next parameters:
- **file_name** - path to you file with parameters
- **-v** - verbous mode (additionaly html report will be created too)
- **-s** - separate mode (all report will be created in separated files)

Example of use:
```shell
ruby generate.rb test/params.txt -v -s
```

As a result all needed documents will be generated.

###Tasks Solving
To solve generated tasks you need to use `solve.rb` script. It accepts next parameters.

 - **file_name** - file name which tasks
 - **-v** - vervous mode
 - **-s** - separate mode

As a result you receive reports.

Exmaple:
```shell
ruby solve.rb inputs/inputs.txt -v -s
```
