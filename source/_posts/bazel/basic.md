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

> -   _Dependency attributes_, such as  `attr.label`  and  `attr.label_list`, declare a dependency from the target that owns the attribute to the target whose label appears in the attribute’s value. This kind of attribute forms the basis of the target graph.
<!--stackedit_data:
eyJoaXN0b3J5IjpbNzQ2NzIzNTc0LDQyNTc0MjAsLTYyMTU0ND
I5OSwtMjI3NzM5MjUwXX0=
-->