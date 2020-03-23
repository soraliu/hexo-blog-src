---
title: Bazel Basic
date: 2019-12-16 14:22:53
tags:
- bazel
- build cache
---

## Concepts and Terminology

- Workspace
- Repositories
- Packages
- Targets
	- files
		- source files
		- generated files
	- rules
- Labels
	- labels belones to only the first parent package(otherwise, it will throw a error "crosses a package boundary"

## Rules

### Phases
> It will be important to understand the three phases of a build (loading, analysis and execution)

### Attributes
> -   _Dependency attributes_, such as  `attr.label`  and  `attr.label_list`, declare a dependency from the target that owns the attribute to the target whose label appears in the attribute’s value. This kind of attribute forms the basis of the target graph.

> _Output attributes_, such as `attr.output` and `attr.output_list`, declare an output file that the target generates.

> Both dependency attributes and output attributes take in label values.

#### Private Attribute
> Sometimes we want to not only provide a default value, but prevent the user from overriding this default. To do this, you can make the attribute _private_ by giving it a name that begins with an underscore (`_`). Private attributes must have default values. It generally only makes sense to use private attributes for implicit dependencies.

### Implementation Function

Implementation functions take exactly one parameter: a  [rule context](https://docs.bazel.build/versions/1.2.0/skylark/lib/ctx.html), conventionally named  `ctx`. It can be used to:

-   access attribute values and obtain handles on declared input and output files;
    
-   create actions; and
    
-   pass information to other targets that depend on this one, via  [providers](https://docs.bazel.build/versions/1.2.0/skylark/rules.html#providers).

<!--stackedit_data:
eyJoaXN0b3J5IjpbMjg2NTY4NTIwLC0xNTUyNjU0MTgyLC00NT
UwMDI1NjUsMjA1ODk1OTM3NiwtMTMyNzg5MTg0MSw0MjU3NDIw
LC02MjE1NDQyOTksLTIyNzczOTI1MF19
-->