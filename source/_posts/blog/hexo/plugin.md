---
title: Hexo Plugin 合集
date: 2019-04-09 22:44:42
tags:
- hexo
---

## Hexo Mermaid 插件

> [官方文档](https://www.npmjs.com/package/hexo-filter-mermaid-diagrams)

### Step1 Install Package
```bash
$ yarn add hexo-filter-mermaid-diagrams
```
> In your blog floder, not hexo floder

### Step2 Edit Config
After installed, you should edit hexo config file: `_config.yml`:
```yaml
# mermaid chart
mermaid: ## mermaid url https://github.com/knsv/mermaid
  enable: true  # default true
  version: "7.1.2" # default v7.1.2
  options:  # find more api options from https://github.com/knsv/mermaid/blob/master/src/mermaidAPI.js
    #startOnload: true  // default true
```
> ❗️❗️❗️Notice: if you want to use 'Class diagram', please edit your '_config.yml' file, set `external_link: false`. - hexo bug.

### Step3 include mermaid.js in pug or ejs
After edited `_config.yml`, you shou edit your blog page component like `after_footer.pug` , `after-footer.ejs` or `swig`.

Where is it?

Open your theme folder, you can see the `layout` folder, open it and then you could see it.

Okey! if your blog is used pug, you can copy the below codes in `after_footer.pug`:

```pug
if theme.mermaid.enable == true
  script(type='text/javascript', id='maid-script' mermaidoptioins=theme.mermaid.options src='https://unpkg.com/mermaid@'+ theme.mermaid.version + '/dist/mermaid.min.js' + '?v=' + theme.version)
  script.
    if (window.mermaid) {
      var options = JSON.parse(document.getElementById('maid-script').getAttribute('mermaidoptioins'));
      mermaid.initialize(options);
    }
```

`after-footer.ejs` should copy below codes:
```
<% if (theme.mermaid.enable) { %>
  <script src='https://unpkg.com/mermaid@<%= theme.mermaid.version %>/dist/mermaid.min.js'></script>
  <script>
    if (window.mermaid) {
      mermaid.initialize({theme: 'forest'});
    }
  </script>
<% } %>
```

swig template engine:
```swig
{% if theme.mermaid.enable %}
  <script src='https://unpkg.com/mermaid@{{ theme.mermaid.version }}/dist/mermaid.min.js'></script>
  <script>
    if (window.mermaid) {
      mermaid.initialize({{ JSON.stringify(theme.mermaid.options) }});
    }
  </script>
{% endif %}
```

