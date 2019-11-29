tekton-env

```
pipeline -> pipelinerun
    |          |   -> 不共享env
  task     ->  taskrun
```

pipeline flow

```
build ->  push ->          deploy
		   |		  		  |
	 static & sentry & image  |
							  |
							image
```

---
### Thing will do

- [ ] 1️⃣prow config_updater
- [ ] 2️⃣support spyglass for tekton pipeline(logs)
- [ ] 4️⃣prow monitoring
- [ ] 4️⃣test grid
- [ ] 🔴build cache

---- 

- [x] 1️⃣migrate drone to tekton pipeline 
- [ ] 3️⃣bot create pr with github api
- [x] create repo
- [ ] 3️⃣auto bump version
- [ ] 4️⃣sinker support tekton pipeline(clean pods, resources, tr, pr)
- [ ] 	commit hash

---

- [ ] 5️⃣spyglass custom lense(jest, coverage)
- [ ] 5️⃣support spyglass for s3

---
- [x] split sentry to condition
- [x] split prow jobs
- [x] build cache
- [ ] clean pods
	- [ ] create a periodic job
	- [ ] run a tekton pipeline
- [x] document
- [x] i18n pre
- [ ] npm ci
- [ ] yarn offline mirror
- [ ] get static when deploy

---

### Share
- [ ] bot merge
- [ ] pipeline demo
- [ ] prow
	- [ ] job
	- [ ] bot
- [ ] what we done
- [ ] ci 集中管理，模版管理

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3NjU0NjkwODhdfQ==
-->